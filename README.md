digital-river-ruby
==================

Wrapper for Digital River eCommerce API.

https://developers.digitalriver.com/api-home

Sponsors
---------

The development has been proudly sponsored by the friends
of https://www.sennheiser.com

Installation
------------

```ruby
gem "digital-river-ruby", :git => "git@github.com:zirni/digital-river-ruby.git", :branch => :master
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

```ruby
# Auth object to retrieve an access token
auth = DigitalRiver::Auth.new("your client id")

# Grab your token object
token = auth.token

# Build your session. This is a convenient way to
# talk to the API. Pass the session object to all
# classes or objects you want them to access the API
session = DigitalRiver::Session.build(token)

# Set your currency and locale with this.
# This is important for Digital River to
# calculate shipping costs for instance
session.update_shopper_resource(:currency => "USD", :locale => "en_US")

# Add a line item to your shopping cart.
digital_river_product_id = 4711
response = session.add_line_item(digital_river_product_id)

if response.errors?
  raise response.to_exception
else
  # analyze response state
  response.status
  response.headers
  response.body
end

# Retrieve all shopping cart line items you have added
r = session.line_items

r.body["lineItems"]["lineItem"].each do |line_item|
  puts line_item["id"]
end

# Update the quantity of a line item
r = session.update_line_item(line_item_id, 3)

# No we want to delete this line item
r = session.delete_line_item(line_item_id)

# Ok ready for checkout
r = session.checkout_resource
puts r.headers["Location"] # visit this location with your browser
```

Documentation
-------------

Create code documentation with yard.

```bash
yard && open doc/index.html
```

Consider that yard will output some warnings about mixins it can't document.

### YARD Coverage

See a documentation coverage.

```bash
rake yardstick
```
