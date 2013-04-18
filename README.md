digital-river-ruby
==================

Wrapper for Digital River eCommerce API.

https://developers.digitalriver.com/api-home

We're testing against the real API. Please keep in mind,
that the client_id can be deactivated in the future. Don't
wonder when test will unexpectly fail. 

Installation
------------

```ruby
gem "digital-river-ruby", :git => "git@github.com:jabz/digital-river-ruby.git", :branch => :master
```

Development
-----------

Automated test with guard.

```bash
bundle exec guard
```

Examples
--------

See spec/integration/spike_spec.rb

Documentation
-------------

Create code documentation with yard.

```bash
yard && open doc/index.html
```

Consider that yard will output some warnings about mixins it can't document.
