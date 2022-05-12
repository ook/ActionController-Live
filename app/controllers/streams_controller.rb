class StreamsController < ApplicationController
  include ActionController::Live
  def me
    expires_now
    response.headers["Content-Type"] = "text/event-stream"

    # Mandatory to stream: rack middleware ETag will bufferize response to set those headers
    # By setting them by hand we skip ETag middleware behavior
    response.headers['Last-Modified'] = '0'
    response.headers['ETag'] = '0'

    3.times do |n|
      response.stream.write "#{n}...\n\n"
      sleep(2)
    end
  ensure
    response.stream.close
  end
end
