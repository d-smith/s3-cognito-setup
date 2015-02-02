require File.expand_path(File.dirname(__FILE__) + '/config')

(role_name, bucket_name, object_name, id_pool_id) = ARGV
unless role_name && bucket_name && object_name && id_pool_id
  puts "Usage: create_cognito_role <role name> <s3 bucket name> <s3 object name> <cognito identity pool id>"
  exit 1
end

s3resource = "arn:aws:s3:::#{bucket_name}/#{object_name}"

iamClient = AWS::IAM::Client::new

assume_role_policy_document = "{\"Version\": \"2012-10-17\",
\"Statement\": [{\"Sid\": \"\",\"Effect\": \"Allow\",\"Principal\": {\"Federated\": \"cognito-identity.amazonaws.com\"},
\"Action\": \"sts:AssumeRoleWithWebIdentity\",
\"Condition\": {\"StringEquals\": {\"cognito-identity.amazonaws.com:aud\": \"#{id_pool_id}\"
},\"ForAnyValue:StringLike\": {\"cognito-identity.amazonaws.com:amr\": \"unauthenticated\"}}}]}
"

policy = AWS::IAM::Policy.new
policy.allow(:actions => ["s3:GetObject"],
:resources => s3resource
)

puts policy.to_json

role = iamClient.create_role(
  :role_name => role_name,
  :assume_role_policy_document => assume_role_policy_document
)[:role]

iamClient.put_role_policy(
  :role_name => role_name,
  :policy_name => role_name,
  :policy_document => policy.to_json
)

puts "created role #{role[:arn]}"
