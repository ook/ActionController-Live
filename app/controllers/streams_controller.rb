class StreamsController < ApplicationController
  include ActionController::Live
  def me
    response.headers["Content-Type"] = "text/event-stream"
    3.times do |n|
      response.stream.write "#{n}...\n\n"
      sleep(2)
    end
  ensure
    response.stream.close
  end
end
