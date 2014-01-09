require './credentials.rb'
require './mangopay_client.rb'
require 'net/http'

client = MangopayClient.new(CLIENT_ID, PASSPHRASE)
user_id = client.create_user
payline_url = client.create_web_payin(amount: 1295, user_id: user_id, wallet_id: WALLET_ID)

puts "Got url : #{payline_url}\n"

body = Net::HTTP.get(URI(payline_url))

puts "-- PAGE BODY BEGIN --"
puts body
puts "-- PAGE BODY END --"