# FrmMercury

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/frm_mercury`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frm_mercury'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install frm_mercury

## Usage

First create an frm_mercury.rb in yours config/initializers

```ruby
require 'frm_mercury'
FrmMercury.configure do |config|
  config.api_key = "Your Api Key From Firebase console"
end
```

Then to send a message...
```ruby
FrmMercury::Sender.send("Device FCM token as String or many tokens as Array", "Some title", "Some body message", "sound.mp3 (Leave empty for default)", "Hash in case you want to send extra info (optional)")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/frm_mercury. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FrmMercury project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/frm_mercury/blob/master/CODE_OF_CONDUCT.md).
