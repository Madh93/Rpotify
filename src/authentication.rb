require 'rspotify'


credentials = []

File.open('../config/credentials.txt', 'r') { |f|
  f.each_line do |line|
    credentials.push line
  end
}

client_id = credentials[1].delete(" \n").split('=')[1]
client_secret = credentials[2].delete(" \n").split('=')[1]


RSpotify::authenticate(client_id, client_secret)