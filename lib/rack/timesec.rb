
module Rack

  class TimeSec

    def initialize(app, options={})
      @app = app
      @interval = 0.1
    end

    def call(env)
      start = Time.now

      status, headers, response = @app.call(env)

      current = Time.now
      delta = current - start
      remaining = (delta/@interval).ceil * @interval - delta
      sleep(remaining)

      return status, headers, response
    end

  end
end
