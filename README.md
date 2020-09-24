# Omniauth::Typeform

[![Travis-CI](https://travis-ci.org/fnando/omniauth-typeform.svg)](https://travis-ci.org/fnando/omniauth-typeform)
[![CodeClimate](https://codeclimate.com/github/fnando/omniauth-typeform.svg)](https://codeclimate.com/github/fnando/omniauth-typeform)
[![Gem](https://img.shields.io/gem/v/omniauth-typeform.svg)](https://rubygems.org/gems/omniauth-typeform)
[![Gem](https://img.shields.io/gem/dt/omniauth-typeform.svg)](https://rubygems.org/gems/omniauth-typeform)

[Typeform](http://typeform.com)'s OAuth Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-typeform'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-typeform

## Usage

`OmniAuth::Strategies::Typeform` is simply a Rack middleware. Read the OmniAuth
docs for detailed instructions: <https://github.com/intridea/omniauth>.

First, create a new application at
`https://admin.typeform.com/account#/section/apps`. Your callback URL must be
something like `https://example.com/auth/typeform/callback`. For development you
can use `http://127.0.0.1:3000/auth/typeform/callback`.

Here's a quick example, adding the middleware to a Rails app in
`config/initializers/omniauth.rb`. This example assumes you're exporting your
credentials as environment variables.

Notice that omniauth-typeform will always inject `account` and `emails` scopes,
so we can retrieve the required information.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :typeform,
            ENV['TYPEFORM_CLIENT_ID'],
            ENV['TYPEFORM_CLIENT_SECRET']
end
```

Now visit `/auth/typeform` to start authentication against Typeform.

## Contributing

1. Fork [omniauth-typeform](https://github.com/fnando/omniauth-typeform/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
