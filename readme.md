Reply
======

A simple class used to encapsulate the reply from a service / interactor

[![Build Status](https://travis-ci.org/sporto/reply.png)](https://travis-ci.org/sporto/reply)

Usage
-----

```ruby
  reply = Reply.new

  # add message
  reply.add_message("Something")

  # add multiple messages
  reply.add_messages(["x", "y"])

  # mark the reply as succesful (this is the default)
  reply.success!

  # mark as warning
  reply.warning!

  # mark as error
  reply.error!

  # add error message and mark as error at the same time
  reply.add_error("Something bad happend")

  # add error messages and mark as error
  reply.add_error(["Error 1", "Error 2"])

  # reply.error! .success!, .warning! also accept an optional message
  reply.error!("I don't like you")

  # reply.error returns the reply itself, so you can do one liners like:
  return reply.error!("Didn't work")

  # check if reply was successful
  reply.successful?
  reply.success?

  # check if reply was unsuccessful
  reply.error?
  reply.failure?

  # add some data to the reply
  reply.data = something

  # add a status to the reply
  # this is independent of success, error and warning
  reply.status = 401

  # copy all the errors from an active record object
  reply.replace_messages_with_errors_for(active_record_object)
```

Testing
--------

  rake spec

or

  guard start

Release
------

This gem uses jeweler
https://github.com/technicalpickles/jeweler

  rake version:bump:minor
  rake release


Copyright
---------
Copyright © 2014 Sebastian Porto. See LICENSE.txt for further details.
