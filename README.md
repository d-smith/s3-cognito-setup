This project contains scripts needed to configure the Cognito identity pool
and associated role for read-only access to a specific file in a specific
s3 bucket.

In the current state, the following steps are performed:

1. Create the identity pool using create_id_pool.rb

        ruby create_id_pool.rb pool-name

2. Noting the identity pool id printed to stdout in the previous step, create
the role associated with the identity pool granting read-only access to the
bucket object

        ruby create_cognito_role.rb <role name> <identity pool arn> <s3 object arn>

3. Finally, run link_role_to_id_pool.rb to link the coginito role to authenticated
and unauthenticated access via Cognito

        ruby link_role_to_id_pool.rb <identity pool arn> <role arn>

More details (or a script) for determining the s3 bucket/object resource id
to follow.

Note the above assumes a json file containing the access key id and secret
access key (named admin.json) is available one directory level up from the
project directory - see config.rb for details.

For details on setting up a Vagrant environment for configuring ruby needed to
create the configuration, go [here.](https://github.com/d-smith/aws-ruby-samples#ruby-setup---vagrant-vm)

In addition to the linked instruction, additional set up is needed to include
AWS Ruby SDK v2:

    gem install aws-sdk-resources
    gem install aws-sdk --pre
