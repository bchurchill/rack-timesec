rack-timesec
============

A rack middleware to prevent timing attacks.

In a timing attack an attacker times how long a query takes to disclose sensitive information about the application.  In the past, timing attacks have been known to reveal,

* usernames
* credentials (or hashes thereof)
* cryptographic keys
* session cookies
* mapping authorization or firewall rules
* etc.

An authoratative description of timing attacks on web applications may be found in "Exposing Private Information
by Timing Web Applications" by Bortz, Boneh and Nandy.  See https://crypto.stanford.edu/~dabo/papers/webtiming.pdf.

Defense
-------

This gem implements a defense that delays requests so that they take a multiple of 100ms to complete.  The value of 100ms is configurable; increasing it causes the site to respond slower, while decreasing it makes the application more vulnerable.  This parameter must be tuned for each application.


