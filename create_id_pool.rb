require File.expand_path(File.dirname(__FILE__) + '/config')

(id_pool_name, dummy) = ARGV
unless id_pool_name
  puts "Usage: create_id_pool <id pool name>"
  exit 1
end

cognitoId = Aws::CognitoIdentity::Client.new

id_pool_id = cognitoId.create_identity_pool(
  :identity_pool_name => id_pool_name,
  :allow_unauthenticated_identities => true
)[:identity_pool_id]

puts "created #{id_pool_id}"
