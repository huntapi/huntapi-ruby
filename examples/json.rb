# frozen_string_literal: true

require "json"
require "huntapi"

client = HuntApi::Client.new # reads HUNTAPI_API_KEY
response = client.media_metadata(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs")
puts JSON.pretty_generate(response.data)
