# frozen_string_literal: true

require "huntapi"

client = HuntApi::Client.new # reads HUNTAPI_API_KEY
submitted = client.video_download(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs", video_quality: "720p")
job = client.wait_for_job(submitted.data["job_id"]) { |j| puts "#{j['status']} #{j['progress']}%" }
puts job.data
