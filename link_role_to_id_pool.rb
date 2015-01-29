require File.expand_path(File.dirname(__FILE__) + '/config')

(id_pool_id, role_arn) = ARGV
unless id_pool_id && role_arn
  puts "Usage: link_role_to_id_pool <id pool id> <role_arn>"
  exit 1
end

cognitoId = Aws::CognitoIdentity::Client.new


cognitoId.set_identity_pool_roles(
  :identity_pool_id => id_pool_id,
  :roles => {"authenticated" => role_arn, "unauthenticated" => role_arn}
)
