class AmazonService
  def self.signed_url(video, title, url_type = :read)
    s3 = AWS::S3.new(:access_key_id => Figaro.env.aws_access_key_id, :secret_access_key => Figaro.env.aws_secret_access_key)
    bucket = s3.buckets[Figaro.env.s3_bucket_name]
    bucket.objects[s3_key(video.user, DateTime.now.year, title)].url_for(url_type, :expires => Time.utc(2019, 12, 3))
  end

  def self.s3_key(user, year, title)
    "#{year}/#{user.last_name}_#{user.first_name}_#{DateTime.now.to_s}_#{title}".gsub(/:/, '-')
  end
end
