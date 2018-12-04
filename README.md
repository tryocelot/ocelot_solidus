# Ocelot for Solidus eCommerce Storefronts

**Note**: *This product is currently in beta.*

Integrate Ocelot into your Solidus store to receive powerful analytics and
business intelligence data.

Free for stores under $50,000 annual revenue.

## Usage

Signup for an account at [ocelot.cat](https://ocelot.cat) and receive your
api key there.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ocelot_solidus', github: 'tryocelot/ocelot_solidus'
```

And then execute:

```bash
$ bundle install
```

Then, create an initializer to authenticate with Ocelot.

```ruby
# config/initializers/ocelot.rb
OcelotSolidus.setup do |config|
  config.api_key = 'abc123'
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Support

Please contact [team@ocelot.cat](mailto:team@ocelot.cat) for support or help
with setting up Ocelot.
