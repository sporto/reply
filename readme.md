Reply
======

A simple class used to encapsulate the reply from a service

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

  # add erroor messages and mark as error
  reply.add_error(["Error 1", "Error 2"])

  # check if reply was successful
  reply.successful?
  reply.success?

  # check if reply was unsuccessful
  reply.error?
  reply.failure?

  # add some data to the reply
  reply.data = something
```

Copyright
---------
Copyright © 2013 Sebastian Porto. See LICENSE.txt for further details.
