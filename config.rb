# Minor changes to the AWS Rubt SDK samples sample_config.rb

# Copyright 2011-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.


require 'aws-sdk'
require 'aws-sdk-v1'
require 'json'

config_file = File.join(File.dirname(__FILE__),
                        "../admin.json")
unless File.exist?(config_file)
  puts <<END
Put your credentials in an admin.json file (found one directory level up)

{"AccessKeyId":"access key id", "SecretAccessKey":"secret key id"}

END
  exit 1
end

creds = JSON.load(File.read('../admin.json'))
awsCreds = Aws::Credentials.new(creds['AccessKeyId'], creds['SecretAccessKey'])

key = creds['AccessKeyId']
secret = creds['SecretAccessKey']

Aws.config[:credentials] = awsCreds
Aws.config[:region] = "us-east-1"

AWS.config(
  :access_key_id => key,
  :secret_access_key => secret,
  :region => "us-east-1"
)
