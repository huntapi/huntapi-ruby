# HuntAPI Ruby SDK

The official Ruby SDK for the [HuntAPI](https://www.huntapi.com) media download API.

Download video and audio from public media URLs, or extract their metadata, with one async REST API.

The SDK exposes **6 methods**, one per documented endpoint, plus a generic `request`. It only uses the Ruby standard library.

## Requirements

- Ruby 3.1 or newer

## Installation

```sh
gem install huntapi
```

Or in your `Gemfile`:

```ruby
gem "huntapi"
```

## Get your API key

[Sign up for HuntAPI](https://app.huntapi.com/register) or sign in, then copy your API key from the [dashboard](https://app.huntapi.com). The client reads `ENV["HUNTAPI_API_KEY"]` when no key is passed.

## Quick start

```ruby
require "huntapi"

client = HuntApi::Client.new(api_key: ENV.fetch("HUNTAPI_API_KEY"))
response = client.media_metadata(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs")
puts response.data
```

Keyword arguments use the parameter names of the [API reference](https://docs.huntapi.com). Unknown names raise `HuntApi::SerializationError`; use `request` for undocumented parameters.

## Async jobs

Download endpoints are asynchronous: they return a `job_id`, and jobs can run for up to 12 hours. `wait_for_job` polls `GET /v1/jobs/{id}` until a terminal status (`CompletedJob`, `Error`, `NotFound`, `BadRequest`):

```ruby
submitted = client.video_download(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs", video_quality: "720p")
job = client.wait_for_job(submitted.data["job_id"]) { |j| puts "#{j['status']} #{j['progress']}%" }
puts job.data
```

## GET or POST

Methods use GET when the endpoint supports it (query string). POST sends the same parameters as JSON:

```ruby
client.audio_download(query: "test", request_options: { method: "POST" })
```

`nil` values are omitted, `false` and `0` are sent, and arrays repeat the parameter name.

## Any endpoint

```ruby
response = client.request("GET", "/v1/usage")
```

## Errors

```ruby
begin
  client.media_metadata(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs")
rescue HuntApi::APIError => e
  warn "HTTP #{e.status}: #{e.message}"
end
```

| Error | When |
| --- | --- |
| `HuntApi::ConfigurationError` | Missing API key, invalid options or unsupported method. |
| `HuntApi::SerializationError` | A required parameter is missing, unknown or can't be sent. |
| `HuntApi::TransportError` | Network failure or timeout. |
| `HuntApi::APIError` | Non-2xx status (`status`, `error_message`, `response_body`, `raw_response`). |
| `HuntApi::ResponseDecodingError` | A success response could not be decoded. |

All of them inherit from `HuntApi::Error`.

## Retries

Requests are retried up to 3 times after a network error, a `408`, `500`, `502`, `503` or `504`, or a rate limit — which the API returns as `401` (or `429`) with a `Rate limit exceeded` message. Per-key quota errors (`…: quota daily`) are not retried, nor are `400`, `402`, `404` or client-side timeouts. The delay starts at 1 second and grows 1.5× per retry (capped at 30 seconds); a `Retry-After` header wins.

```ruby
client = HuntApi::Client.new(max_retries: 5, retry_delay: 0.5)
client.media_metadata(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs", request_options: { max_retries: 0 }) # one request without retries
```

## Batch requests

`batch` runs the block for every item on 10 threads (`concurrency:`) and returns one `BatchResult` per item, in input order. A failing item never stops the others.

```ruby
inputs = ["https://www.youtube.com/watch?v=Z5YP8kznWZs", "https://www.youtube.com/watch?v=jNQXAC9IVRw"]
results = client.batch(inputs, concurrency: 5) { |value| client.media_metadata(query: value) }
results.each do |result|
  if result.ok?
    puts result.value.data
  else
    warn "#{inputs[result.index]}: #{result.error.message}"
  end
end
```

| Constant | Default | Description |
| --- | --- | --- |
| `HuntApi::Client::DEFAULT_CONCURRENCY` | `10` | Tasks run at the same time by batch |
| `HuntApi::Client::DEFAULT_TIMEOUT` | `120` | Request timeout (seconds) |
| `HuntApi::Client::MAX_RETRIES` | `3` | Retry attempts after a network error, a 408/5xx or a rate limit |
| `HuntApi::Client::RETRY_BACKOFF_FACTOR` | `1.5` | Exponential backoff multiplier |
| `HuntApi::Client::DEFAULT_RETRY_DELAY` | `1.0` | Delay before the first retry (seconds) |

## Timeouts and custom transports

```ruby
client = HuntApi::Client.new(timeout: 60) # seconds, default 120
client.media_metadata(query: "https://www.youtube.com/watch?v=Z5YP8kznWZs", request_options: { timeout: 30 })
```

A transport is any object with `call(method:, url:, headers:, body:, timeout:)` returning `[status, headers, body]`; the default is `HuntApi::NetHTTPTransport`.

## Endpoints

6 methods, generated from the [OpenAPI document](https://app.huntapi.com/openapi).

| Method | HTTP | Description |
| --- | --- | --- |
| `audio_download` | GET / POST `/v1/audio/download` | Download audio from a URL via HuntAPI and receive a job id. |
| `jobs` | GET `/v1/jobs/{id}` | Poll status, progress (0–100), and result of an async HuntAPI job. |
| `media_metadata` | GET `/v1/media/metadata` | Extract metadata from a media URL without downloading the file. |
| `stats` | GET `/v1/stats` | Infrastructure health for an engine or endpoint over the last hour. Not scoped to your account or tenant. Enabled per account: HTTP 403 mea… |
| `usage` | GET `/v1/usage` | Retrieve real-time usage statistics and credit balance for your Huntapi account. |
| `video_download` | GET / POST `/v1/video/download` | Video Download |

## All HuntAPI SDKs

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@huntapi/sdk`](https://www.npmjs.com/package/@huntapi/sdk) | `npm install @huntapi/sdk` |
| Python | [`huntapi`](https://pypi.org/project/huntapi/) | `pip install huntapi` |
| Go | [`huntapi-go`](https://pkg.go.dev/github.com/huntapi/huntapi-go) | `go get github.com/huntapi/huntapi-go` |
| .NET | [`HuntApi`](https://www.nuget.org/packages/HuntApi) | `dotnet add package HuntApi` |
| Ruby | [`huntapi`](https://rubygems.org/gems/huntapi) | `gem install huntapi` |
| PHP | [`huntapi/sdk`](https://packagist.org/packages/huntapi/sdk) | `composer require huntapi/sdk` |
| Java | [`huntapi-java`](https://github.com/huntapi/huntapi-java) | build from source, see its README |
| CLI | [`@huntapi/cli`](https://www.npmjs.com/package/@huntapi/cli) | `npm install -g @huntapi/cli` |
| MCP server | [`@huntapi/mcp`](https://www.npmjs.com/package/@huntapi/mcp) | `npx -y @huntapi/mcp` |

## License

MIT — see [LICENSE](LICENSE).
