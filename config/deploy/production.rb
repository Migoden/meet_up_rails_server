# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :web, %w{104.131.55.49}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
# server "MeetUpRails.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/meet_up_rails"

set :application, "meet_up_rails"
set :scm, :git
set :repository, "git@github.com:Migoden/meet_up_rails_server.git"
set :scm_passphrase, ""
set :user, "sj5khan@uwaterloo.ca"

set :stage, :development
set :default_stage, "staging"

server 'MeetUpRails.com', user: 'deploy', roles: %w{web}, my_property: :my_value


# Host bitbucket.org
# IdentityFile ~/.ssh/id_rsa.pub
# Host heroku.com
# Hostname heroku.com 
# Port 22 
# IdentitiesOnly yes 
# IdentityFile id_rsa
# TCPKeepAlive yes 
# User saifkhan994@gmail.com


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
