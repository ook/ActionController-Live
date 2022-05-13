module StreamableController
  extend ActiveSupport::Concern
  include ActionController::Live

  def with_streaming
    headers["Content-Type"] = "text/event-stream"

    # Mandatory to stream: rack middleware ETag will bufferize response to set
    # those headers. By setting them by hand we skip ETag middleware behavior.
    headers["Last-Modified"] = "0"
    headers["ETag"] = "0"

    yield
  rescue ActionController::Live::ClientDisconnected
    # Ignore errors on HEAD requests wheb using command-line curl.
  ensure
    response.stream.close
  end
end
