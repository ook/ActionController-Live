# README

Minimal test of `ActionController::Live`

Rails7
Ruby 3.1.1

# PROBLEM SOLVED

The culprit is ETag rack middleware that bufferize the response until the end
to compute headers `ETag` and `Last-Modified`.
We can bypass that behavior by setting them ourself.

```rb
headers["Last-Modified"] = "0"
headers["ETag"] = "0"
```

# Running

    $ bundle install && bin/rails s -e production -p 4444

# Testing

    $ curl -N localhost:4444/streams/me

(-N means --no-buffer)

## Expected

   "1... 2... 3..." streamed with 2s of pause between each number

## Actual

   Buffered for 6s and all the content at once

# Resource:

   * http://railscasts.com/episodes/401-actioncontroller-live
   * http://tenderlovemaking.com/2012/07/30/is-it-live.html
   * https://api.rubyonrails.org/classes/ActionController/Live.html
   * https://stackoverflow.com/questions/23259163/rails-streaming-not-streaming
