require File.expand_path(File.dirname(__FILE__) + '/config')

s3 = Aws::S3::Client.new

buckets = s3.list_buckets[:buckets]

buckets.each do |bucket_info|
  puts bucket_info[:name]
end
