# Redox
Ruby API wrapper for [Redox Engine](https://www.redoxengine.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redox

## Usage

In an initializer file:
```ruby
Redox.configure do |redox|
  redox.api_key = #{Your API Key}
  redox.secret = #{Your secret}
end
```

```ruby
source = {
  Name: 'Redox Dev Tools',
  ID: ENV['REDOX_SRC_ID']
}

destinations = [
  {
    Name: 'Redox EMR',
    ID: ENV['REDOX_DEST_ID']
  }
]

redox = Redox::Client.new(
  source: source,
  destinations: destinations,
  test: true
)

redox.add_patient(
  Identifiers: [...],
  Demographics: {
    FirstName: 'Joe'
    ...
  }
)
```

Initializing with a persisted access token (check if it's expired, client will load naively)
```ruby
c = Redox::Client.new(
  source: source,
  destinations: destinations,
  test: true,
  token: <Existing access token>
)
```

Initializing with a persisted refresh token (client will get a new access token)
```ruby
c = Redox::Client.new(
  source: source,
  destinations: destinations,
  test: true,
  refresh_token: <Existing refresh token>
)
c.access_token # => returns new token
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/WeInfuse/redox.
