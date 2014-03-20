Future Work
-----------
-----------

* Build a tiny test suite
* Investigate issues of lazy evaluation in rack APIs that could be giving us invalid times (see limitations)
* Investigate chunking (see limitations)
* Provide more flexibility for specifying paths/routes to apply delays on.
* Provide more options for delay invervals (e.g. a fixed set of values).
* Provide option to use different interval for different parts of the site.
    * Nested protection (e.g. interval X for processing cookies/session and interval Y for application)
    * Different protection in different places (e.g. interval X for /users/ and interval Y for /media/)
    * Combinations thereof!

