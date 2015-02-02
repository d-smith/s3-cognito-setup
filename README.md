This project contains scripts needed to configure the Cognito identity pool
and associated role for read-only access to a specific file in a specific
s3 bucket.

In the current state, the following steps are performed:

0. Verify the bucket name and object name used to store the config using
the list_buckets.rb and list_bucket script. The bucket and object name need
to be known prior to the rest of the setup, which effectively is used to
grant access to a specific object in a bucket.

        ruby list_buckets.rb
        ruby list_bucket <bucket name>

1. Create the identity pool using create_id_pool.rb

        ruby create_id_pool.rb <pool-name>

2. Noting the identity pool id printed to stdout in the previous step, create
the role associated with the identity pool granting read-only access to the
bucket object

        ruby create_cognito_role.rb <role name> <s3 bucket name> <s3 object name> <identity pool id>

3. Finally, run link_role_to_id_pool.rb to link the coginito role to authenticated
and unauthenticated access via Cognito

        ruby link_role_to_id_pool.rb <identity pool arn> <role arn>

The applications that will use the above configuration to access the s3 object
will need to know the Amazon account number associated with the definitions
(available via the admin console), the role arn (which is the output from the
create_cognito_role script), and the identity pool id (which is the output from
the create_id_pool script).

Note the above scripts assume a json file containing the access key id and secret
access key (named admin.json) is available one directory level up from the
project directory - see config.rb for details.

For details on setting up a Vagrant environment for configuring ruby needed to
create the configuration, go [here.](https://github.com/d-smith/aws-ruby-samples#ruby-setup---vagrant-vm)

In addition to the linked instruction, additional set up is needed to include
AWS Ruby SDK v2:

    gem install aws-sdk-resources
    gem install aws-sdk --pre
