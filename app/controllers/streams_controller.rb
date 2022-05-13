class StreamsController < ApplicationController
  include StreamableController

  around_action :with_streaming

  def me
    3.times do |n|
      response.stream.write "#{n}...\n\n"
      sleep(2)
    end
  end
end
