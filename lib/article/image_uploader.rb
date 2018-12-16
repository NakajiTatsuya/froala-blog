class Article::ImageUploader
 
  def initialize(upload_image)
    @file = upload_image.tempfile  # アップロードするファイル
    @key_name = "#{SecureRandom.hex}"  # バケットに置く際のキー名
    @s3 = Aws::S3::Resource.new(
      region:      'ap-northeast-1',  # リージョン東京
      credentials: Aws::Credentials.new(
        ENV["aws_access_key_id"],  # S3用アクセスキー
        ENV["secret_access_key"]  # S3用シークレットアクセスキー
      )
    )
  end
 
  def upload_image
    begin
      @s3.bucket(get_bucket_name).object(@key_name).put(body: @file)
      return true
    rescue
      return false
    end
  end
 
  def get_bucket
    @s3.bucket(get_bucket_name)
  end
 
  def get_key_name
    @key_name
  end
 
  private
 
    def get_bucket_name
      Rails.env.production? ? 'dragonarrow' : 'dragonarrow'  # とりあえずバケットを分けてみた
    end
end