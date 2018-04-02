require 'rubygems'
require 'oauth'
require 'json'

# Parse a response from the API and return a user object
def parse_user_reponse(response)
    user = nil
    
    # Check for a successful request
    if response.code == '200'
        # Parse the response body, which is in JSON format
        # ADD CODE TO PARSE THE REPONSE BODY HERE
        user = JSON.parse(response.body, {:symbolize_names => true})
        
        # pretty-print the user object to see what data is availble
        puts "Hello, #{user[:screen_name]}!"
    else 
        #There was an error issuing the request.
        puts "Expected a reponse of 200 byt got #{response.code} instead"
    end
    
    user 
end

#Print data about a list of tweets
def print-timeline(tweets)
    #ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    puts tweets
end 
        
# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
consumer_key = OAuth::Consumer.new(
    "rg8xErivfUlUtmMsTU2IEy6MY",
    "ZKHRM3i7O21v4leu8J97rTtxQOhJpffkxXVPtBhtt6AUM2sFJC")
access_token = OAuth::Token.new(
    "765846050-oQ0bxMF2ANpjio93vjjBG7aOIqAsmG36IG5ZxJ9S",
    "RtbVRQnQZMB4fC96L02tL0GfLD3JwMlGQtLU31DzH0dq4")

# All requests will be sent to this server.
baseurl = "https://api.twitter.com"

# The verify credentials endpoint returns a 200 status if
# the request is signed correctly.
address = URI("#{baseurl}/1.1/account/verify_credentials.json")

# Set up Net::HTTP to use SSL, which is required by Twitter.
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Build the request and authorize it with OAuth.
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token

# Issue the request and return the response.
#http.start
#response = http.request request
#puts "The response status was #{response.code}"
##puts response.body
#user = parse_user_reponse(response)

# DAY 2  - READING TWEET
# Now you will fetch /1.1/status/show.json, which
# takes an 'id' parameter and returns the 
# representation of a single tweet

path = "/1.1/statuses/show.json"
query = URI.encode_www_form("id" => "266270116780576768")
address_status = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address_status.request_uri

# Print data about a tweet
def print_tweet(tweet)
     puts tweet
end

#Issue the request
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

puts responde.code

if response.code == '200' then
    tweet = JSON.parse(response.body)
    print_tweet(tweet)
end
