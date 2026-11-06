# frozen_string_literal: true

require "huntapi"

client = HuntApi::Client.new # reads HUNTAPI_API_KEY
begin
  response = client.request("GET", "/v1/usage")
  puts response.data if response.json?
rescue HuntApi::APIError => e
  warn "HTTP #{e.status}: #{e.message}"
end
