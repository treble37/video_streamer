# == Schema Information
#
# Table name: videos
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  length           :string
#  direct_video_url :text
#  video_filename   :string
#  video_type       :string
#

class VideosController < ApplicationController
  before_action :set_user
  before_action :set_video, only: [:show, :edit]

  # GET /videos
  # GET /videos.json
  def index
    @videos = @user.videos
    @videos = @videos.order(:id).page params[:page]
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = @user.videos.build
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = @user.videos.build(video_params)
    respond_to do |format|
      if @video.save
        format.html { redirect_to user_videos_path(@user), notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: user_videos_path(@user) }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_s3_direct
    # this method is called from AngularJS http post call
    s3 = AWS::S3.new(access_key_id: Figaro.env.aws_access_key_id, secret_access_key: Figaro.env.aws_secret_access_key)
    bucket = s3.buckets[Figaro.env.s3_bucket_name]
    @video = @user.videos.create(title: params["title"], description: params["description"], length: params["length"], video_type: params["video_type"], video_filename: params["video_filename"])
    key = AmazonService.s3_key(@user, DateTime.now.year, params["title"])
    @video.direct_video_url = AmazonService.signed_url(@video, params["title"], :read).to_s
    @video.save
    signed_data = bucket.presigned_post("acl"=>"public-read", "success_action_status" => "201")
    render :json => {
      fields: signed_data.fields.merge(
          "policy" => s3_upload_policy_document,
          "signature" => s3_upload_signature,
          "key" => key ),
     }
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    @video = @user.videos.find(params[:id])
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to user_videos_path(@user), notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = @user.videos.find(params[:id])
    @video.destroy
    respond_to do |format|
      format.html { redirect_to user_videos_url(@user), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :length, :video_filename, :video_type)
    end

    # generate the policy document that amazon is expecting.
    def s3_upload_policy_document
      return @policy if @policy
      ret = {"expiration" => 60.minutes.from_now.utc.xmlschema,
             "conditions" =>  [
                 {"bucket" =>  Figaro.env.s3_bucket_name},
                 ["starts-with", "$key", ''],
                 {"acl" => "public-read"},
                 {"success_action_status" => "201"},
                 ["starts-with", "$utf8", ''],
                 ["starts-with", "$authenticity_token", ''],
                 ["content-length-range", 0, Figaro.env.s3_max_file_size.to_i]
             ]
      }
      @policy = Base64.encode64(ret.to_json).gsub(/\n/,'')
    end

    # sign our request by Base64 encoding the policy document.
    def s3_upload_signature
      signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), Figaro.env.aws_secret_access_key, s3_upload_policy_document)).gsub("\n","")
    end

end
