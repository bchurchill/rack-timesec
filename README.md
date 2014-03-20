rack-timesec
============

A rack middleware to prevent timing attacks.

In a timing attack an attacker times how long a query takes to disclose sensitive information about the application.  In the past, timing attacks have been known to reveal,

* usernames
* credentials (or hashes thereof)
* cryptographic keys
* session cookies (e.g. CVE-2013-0263)
* mapping authorization or firewall rules
* etc.

An authoratative description of timing attacks on web applications may be found in "Exposing Private Information
by Timing Web Applications" by Bortz, Boneh and Nandy.  See https://crypto.stanford.edu/~dabo/papers/webtiming.pdf.

Overview
--------

This gem implements a defense described in the paper mentioned above.  It delays requests so that they take a multiple of 100ms to complete.  The value of 100ms is configurable; increasing it causes the site to respond slower, while decreasing it makes the application more vulnerable.  This parameter must be tuned for each application.

(Note that random delays have been shown not to prevent these attacks, which is why they aren't implemented here)

Install
-------

1. Update your gemfile.  For now, use

    gem 'rack-timesec', :git => 'git://github.com/bchurchill/rack-timesec.git'

2. Add the middleware in the application.rb file.  The location in the middleware stack is important.  You want TimeSec to run before any sensitive operations, such as working with the session cookie, or authentication/authorization.  For security, it's best not to use Rack::Runtime anywhere, because this would help a timing attacker.  If you use Rack::Runtime anyway, then Rack::TimeSec **must** follow it, or you will have no protection.  *In general, it's best to setup Rack::TimeSec to run sooner rather than later.*  Therefore, my recommendation is to use the following in application.rb, which replaces Rack::Runtime with Rack::TimeSec


    config.middleware.swap Rack::Runtime, Rack::TimSec


Configure
---------

Rails::TimeSec will work right out of the box. There are two
configurable options, both of which are important: 

### Interval

The first is the 'interval' setting. This defines the maximum interval
(in seconds) that TimeSec will delay a request. Setting this value
higher often provides better security, while setting it lower provides
better performance. The default setting is 0.1 seconds (100ms). This
seems to work well for many sites. To set this value to 0.2 seconds
(200ms), you would use:

    config.middleware.swap Rack::Runtime, Rack::TimeSec, :interval => 0.2


To test, you should do some sensitive operations that take different
amounts of time on the server and ensure they look the same to a
client. For example, try logging in with a valid user and an invalid
password, and then with an invalid user and an invalid password. If
one of these operations takes less time than the other (e.g. one takes
100ms while the other takes 200ms), then it's necessary to adjust your
interval.

You should also perform this test when the server is at minimum load,
typical load, and maximum load. The load on the server affects the
response times, and so your interval should work in all cases.

Note that a greater interval doesn't [em]always[/em] provide better
security. For example, if you have a sensitive operation that takes
120ms or 170ms on the server, then using an interval of 100 would
entirely mask this difference. However, an interval of 150 would cause
the client to see these operations taking 150 or 300ms (respectively),
and this could be a vulnerability.

If you're very paranoid, you may set the interval so large that all
requests will complete in the same interval. An example would be
setting it to one second.




### Except

For performance reasons, especially in a development environment where
assets are served statically, we want to exclude certain URLs which
are not sensitive to timint attacks. For example, one can exclude all
paths starting with /assets/ as follows:

[code]
config.middleware.swap Rack::Runtime, Rack::TimeSec, :except => [\^/assets\//]
[/code]


Limitations
-----------

Please read http://tenderlovemaking.com/2011/03/03/rack-api-is-awkward.html about how my method could miscalculate the time that a response takes.  I'm also not sure about chuncked responses and if they'll be handled properly.  If someone wants to look into this, that would be superb!

Contributions
-------------

If you have a security bug report, please let me know confidentially.  It's best to email me at berkeley@berkeleychurchill.com.  You may download my GPG key from https://www.berkeleychurchill.com/contact.php.  Your contribution will be publicly acknowledged once it's fixed (if you like).

Non-security bugs can be posted on the github tracker.  If you're in doubt, consider it a security bug.

If you would like to contribute, please look into the TODO.md file for thoughts on what to do (other contributions are welcome too).  Please let me know if you start working on something so effort isn't duplicated.  Pull requests are welcomed.

### Authors & Contributors

Berkeley Churchill
