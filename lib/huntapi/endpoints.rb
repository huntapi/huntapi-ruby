# frozen_string_literal: true

# Generated from the HuntAPI OpenAPI document. Do not edit by hand.

module HuntApi
  # Path, methods, response kind and parameter names of every documented operation.
  ENDPOINTS = {
    "audio_download" => {
      path: "/v1/audio/download",
      methods: ["GET", "POST"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "download_type", "max_duration", "audio_quality", "audio_format", "webhook_url", "webhook_authorization", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "jobs" => {
      path: "/v1/jobs/{id}",
      methods: ["GET"].freeze,
      response: :json,
      required: ["id"].freeze,
      params: ["id"].freeze
    }.freeze,
    "media_metadata" => {
      path: "/v1/media/metadata",
      methods: ["GET"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "fields", "is_async", "soft_fail"].freeze
    }.freeze,
    "stats" => {
      path: "/v1/stats",
      methods: ["GET"].freeze,
      response: :json,
      required: [].freeze,
      params: ["engine", "path"].freeze
    }.freeze,
    "usage" => {
      path: "/v1/usage",
      methods: ["GET"].freeze,
      response: :json,
      required: [].freeze,
      params: [].freeze
    }.freeze,
    "video_download" => {
      path: "/v1/video/download",
      methods: ["GET", "POST"].freeze,
      response: :json,
      required: ["query"].freeze,
      params: ["query", "download_type", "max_duration", "video_quality", "video_format", "webhook_url", "webhook_authorization", "fields", "is_async", "soft_fail"].freeze
    }.freeze
  }.freeze
end
