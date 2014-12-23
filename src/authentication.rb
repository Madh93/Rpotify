require 'rspotify'


credentials_path = File.expand_path("../../config/credentials.txt", __FILE__)
credentials = []

File.open(credentials_path, 'r') { |f|
  f.each_line do |line|
    credentials.push line
  end
}

client_id = credentials[1].delete(" \n").split('=')[1]
client_secret = credentials[2].delete(" \n").split('=')[1]

if !client_id.nil? and !client_secret.nil?
    RSpotify::authenticate(client_id, client_secret)
end