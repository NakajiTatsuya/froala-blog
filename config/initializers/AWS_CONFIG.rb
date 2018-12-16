AWS_CONFIG = {
 'bucket' => 'dragonarrow',
 'access_key_id' => ENV["aws_access_key_id"],
 'secret_access_key' => ENV["aws_secret_access_key"],
 'acl' => 'public-read',
 'key_start' => 'uploads/',
 'region' => 'ap-northeast-1'
}