# NeonCrm

Provides login and create account by [NeonCRM](http://www.z2systems.com) API

## Installation

Add this line to your application's Gemfile:

    gem 'neon_crm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install neon_crm

## Usage

After you install NeonCRM and add it to your Gemfile, you need to run the generator:

```console
rails generate neon_crm:install
```

Provide your api key and organization id in `config/networks.yml`

To get session id:

```ruby
NeonCrm.get_user_session_id
```

To create account:

```ruby
NeonCrm.create_account("first_name" => user.first_name, "last_name" => user.last_name, "phone" => user.phone, "organization" => user.organization,                                   "address" => user.address, "email" => user.email, "source" => 'www.example.org')
```
## Contributing

1. Fork it ( http://github.com/<my-github-username>/neon_crm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Say Thank You

If you want to say thank you, please support the petition to designate [25june](http://25june.org/en/signatures/new) as Vitiligo World Day and save millions of people worldwide from social isolation and persecution.
