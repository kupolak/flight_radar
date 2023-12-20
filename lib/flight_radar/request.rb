# frozen_string_literal: true

require 'httparty'

# The `Request` class handles making HTTP requests using the HTTParty gem.
class Request
  # Initializes a new instance of the `Request` class.
  #
  # @param url [String] The URL for the HTTP request.
  # @param headers [Hash] (optional) The headers to include in the HTTP request.
  # @param params [Hash] (optional) The parameters to include in the HTTP request.
  def initialize(url, headers = {}, params = {})
    @url = url
    @params = params
    @headers = headers
    @lang = 'en'

    @response = send_request(url, headers, params)
  end

  # Returns the parsed content of the HTTP response.
  #
  # @return [Hash] The parsed content of the HTTP response.
  def content
    @response.parsed_response
  end

  # Returns the content type of the HTTP response.
  #
  # @return [String] The content type of the HTTP response.
  def content_type
    @response.content_type
  end

  # Returns the status code of the HTTP response.
  #
  # @return [Integer] The status code of the HTTP response.
  def status_code
    @response.code
  end

  private

  # Sends an HTTP GET request using the specified URL, headers, and parameters.
  #
  # @param url [String] The URL for the HTTP request.
  # @param headers [Hash] The headers to include in the HTTP request.
  # @param params [Hash] The parameters to include in the HTTP request.
  # @return [HTTParty::Response] The HTTParty response object.
  def send_request(url, headers, params)
    full_url = build_full_url(url, params)
    HTTParty.get(full_url, headers)
  end

  # Builds the full URL by appending parameters to the base URL.
  #
  # @param url [String] The base URL.
  # @param params [Hash] The parameters to include in the URL.
  # @return [String] The full URL for the HTTP request.
  def build_full_url(url, params)
    return url unless params

    "#{url}?#{params_to_string(params)}"
  end

  # Converts parameters to a query string.
  #
  # @param params [Hash] The parameters to convert.
  # @return [String] The query string representation of the parameters.
  def params_to_string(params)
    HTTParty::HashConversions.to_params(params)
  end
end
