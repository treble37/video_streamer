# == Schema Information
#
# Table name: videos
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  video_file_file_name    :string
#  video_file_content_type :string
#  video_file_file_size    :integer
#  video_file_updated_at   :datetime
#  length                  :string
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
      params.require(:video).permit(:title, :description, :length, :video_file)
    end
end
