set :stage, :production

server '107.170.133.242', user: 'deploy', roles: %w{web app db}