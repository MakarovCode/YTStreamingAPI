# YTStreamingAPI

Ruby gem to use the YouTube Streaming API simple

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'YTStreamingAPI'
```

And then execute:

$ bundle

Or install it yourself as:

$ gem install YTStreamingAPI

## Usage

For Rails First create an yt_streaming_api.rb in yours config/initializers

```ruby
require "YTStreamingAPI"

YtStreamingApi::RApi.configure do |config|
  config.api_key        = 'your api key'
  config.client_id      = 'your client id'
  config.client_secret  = 'your secret key'
  config.redirect_uri   = 'callback url for login'
  config.response_type  = 'code'
  config.scope          = 'https://www.googleapis.com/auth/youtube'
  config.access_type    = 'offline'
end
```

## Create the needed fields to your user table

Run the next migration if you are using Rails and a table users

```ruby
rails g migration add_yt_fields_to_users youtube_authorization_token youtube_access_token youtube_reset_token testing:boolean
```

## Authenticating with the client YouTube account

For Rails First create an yt_streaming_api.rb in yours config/initializers

```ruby
# In your HTML you can init a Login object passing an ActiveRecord object of your users
@login_api = YtStreamingApi::RApi::Login.new current_user

# With this you can know go to YouTube to authenticate your user.
link_to "Authenticate with YouTube", @login_api.url


# The authentication callback should have the next code, Init the Login object passing an ActiveRecord object of your users
login_api = YtStreamingApi::RApi::Login.new current_user
if login_api.is_valid_response(params)
  # This will validate the response
  login_api.process_response_params(params)
  # This will consume the youtube api and retrieve the tokens needed for the user connection
  login_api.get_tokens
  # save in data base
  current_user.save
end

# Once your user is authenticated with YouTube and you stored it tokens in database, then you can start using the next api methods.

# Always ask for the tokens of the users because these are refreshed by YouTube every hour.

login_api = YtStreamingApi::RApi::Login.new user
login_api.get_tokens
user.save

# List the active Broadcast of the user
broadcast_api = YtStreamingApi::RApi::Broadcast.new user
broadcast_res = broadcast_api.list

# How the get a ChatId for retrieveing messages
chat_id = nil
unless broadcast_res["items"].blank?
  if broadcast_res["items"].any?
    chat_id = broadcast_res["items"][0]["snippet"]["liveChatId"]
  end
end

# Get the last 2000 records of the live chat with the retrieved ID
messages_api = YtStreamingApi::RApi::Message.new user
res = messages_api.list("snippet", 2000, chat_id)

```
