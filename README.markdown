RightScaleAPIHelper
=========================

This GEM is a simple wrapper for the RightScale API. It simplifies authentication, and provides an object to run GET, PUT, POST, and DELETE calls.

Usage
-----
  Create new instance 

    RightScaleAPIHelper::Helper.new(acct_id, email, password, format=('js'/'xml'), version = 1.0)

  Example

    api_conn = RightScaleAPIHelper::Helper.new(123456, 'email@email.com', 'password')

    resp = api_conn.get("/deployments")
    puts resp.code  # Response code from RightScale
    puts resp.body  # xml or json response


Copyright
---------

Copyright (c) 2012 Eric VanWieren. See LICENSE.txt for
further details.

