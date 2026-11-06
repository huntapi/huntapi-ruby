# frozen_string_literal: true

# Generated from the HuntAPI OpenAPI document. Do not edit by hand.

module HuntApi
  # One method per documented endpoint. Mixed into {Client}.
  module Operations
    # Audio Download. Download audio from a URL via HuntAPI and receive a job id. Credit cost: 1 credit per call.
    #
    # +GET / POST /v1/audio/download+
    #
    # @param query [String] (required) URL to download audio from.
    # @param download_type [String] Desired download type. Supported values: audio (default).
    # @param max_duration [Numeric] Maximum duration of the downloaded content in seconds. If the audio is longer than this value, only the content up to this duration will be downloaded.
    # @param audio_quality [String] Desired audio quality.
    # @param audio_format [String] Desired output format for the audio.
    # @param webhook_url [String] URL of the webhook where results will be sent. When specified, the system will attempt to send the response to this URL up to 3 times with a 5-second delay between each attempt. The results will be s…
    # @param webhook_authorization [String] Authorization header for the webhook. This parameter allows you to add authentication to your webhook endpoint.
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def audio_download(request_options: nil, **params)
      call_operation("audio_download", params, request_options)
    end

    # Jobs. Poll status, progress (0–100), and result of an async HuntAPI job.
    #
    # +GET /v1/jobs/{id}+
    #
    # @param id [String] (required) Job UUID returned as job_id by async endpoints such as /v1/video/download and /v1/audio/download.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def jobs(request_options: nil, **params)
      call_operation("jobs", params, request_options)
    end

    # Media Metadata. Extract metadata from a media URL without downloading the file. Credit cost: 1 credit per call.
    #
    # +GET /v1/media/metadata+
    #
    # @param query [String] (required) Media URL to inspect (YouTube, Instagram, TikTok, Vimeo, X, Facebook, Twitch, Reddit, etc.).
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def media_metadata(request_options: nil, **params)
      call_operation("media_metadata", params, request_options)
    end

    # Stats. Infrastructure health for an engine or endpoint over the last hour. Not scoped to your account or tenant. Enabled per account: HTTP 403 means contact support to activate it.
    #
    # +GET /v1/stats+
    #
    # @param engine [String] API family to check, for example video. Provide at least engine or path.
    # @param path [String] Specific endpoint to check, for example /v1/video/download. If you also pass engine, use an endpoint from that API.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def stats(request_options: nil, **params)
      call_operation("stats", params, request_options)
    end

    # Usage. Retrieve real-time usage statistics and credit balance for your Huntapi account.
    #
    # +GET /v1/usage+
    #
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def usage(request_options: nil, **params)
      call_operation("usage", params, request_options)
    end

    # Video Download. Credit cost: 1 credit per call.
    #
    # +GET / POST /v1/video/download+
    #
    # @param query [String] (required) Video URL to download.
    # @param download_type [String] Desired download type. You have three options:
    # @param max_duration [Numeric] Maximum duration of the downloaded content in seconds. If the video/audio is longer than this value, only the content up to this duration will be downloaded.
    # @param video_quality [String] Desired video quality. Available options:
    # @param video_format [String] Desired output format for the video. Available options:
    # @param webhook_url [String] URL of the webhook where results will be sent. When specified, the system will attempt to send the response to this URL up to 3 times with a 5-second delay between each attempt. The results will be s…
    # @param webhook_authorization [String] Authorization header for the webhook. This parameter allows you to add authentication to your webhook endpoint. This value will be included in the Authorization header when making the webhook request…
    # @param fields [String] Comma-separated list of fields to keep in the response, with dot notation for nested fields (e.g. name,location.city). Does not change the credit cost.
    # @param is_async [Boolean] Process the request asynchronously: the response is a job_id to poll on /v1/jobs/{id} (see waitForJob).
    # @param soft_fail [Boolean] Return HTTP 200 even when an error occurs; the error is then in the response body.
    # @param request_options [Hash, nil] +:method+ ("GET"/"POST"), +:timeout+ (seconds), +:headers+
    # @return [JsonResponse]
    def video_download(request_options: nil, **params)
      call_operation("video_download", params, request_options)
    end
  end
end
