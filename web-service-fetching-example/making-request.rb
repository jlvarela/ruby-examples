require 'net/http'
require 'json'

ENDPOINT = "https://api.coindesk.com/v1/bpi/currentprice.json"

uri = URI(ENDPOINT)
res = Net::HTTP.get_response(uri)

puts res.code
puts res.content_type
puts res.body
puts JSON.parse(res.body)['time']