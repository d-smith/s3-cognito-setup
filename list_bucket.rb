require File.expand_path(File.dirname(__FILE__) + '/config')

(bucket_name, dummy) = ARGV
unless bucket_name
  puts "Usage: ruby list_bucket.rb <bucket name>"
  exit 1
end

s3 = Aws::S3::Client.new

contents = s3.list_objects({
    :bucket => bucket_name
})[:contents]

contents.each do |content|
  puts content[:key]
end
