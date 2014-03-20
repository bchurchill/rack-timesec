
module Rack

  class TimeSec

    def initialize(app, options={})
      options = { :interval => 0.1, :except => [] }.merge(options)

      @app = app

      @interval = options[:interval]
      @except = options[:except]

    end

    def call(env)

      ## Exempt certain paths from timing security
      ## an attacker will be able to time all 
      ## accesses to URLs matching these criteria,
      ## and identify which URLs have this property.
      ##
      ## This is good for static assets.
      ##
      req = Request.new(env)
      @except.each do |regex|
        if regex.match(req.fullpath)
          return @app.call(env)
        end
      end

      ## Start timing the request
      start = Time.now

      status, headers, response = @app.call(env)

      ## Wait for a multiple of @interval seconds from the original request
      delay(start)

      return status, headers, response
    end

    def delay(start)
      delta = Time.now - start
      remaining = (delta/@interval).ceil * @interval - delta
      sleep(remaining)
    end

  end
end
