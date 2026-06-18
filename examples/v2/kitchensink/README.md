# Kitchen Sink Bot

A kitchen-sink LINE bot example. This contains many examples of line-bot-api gem's features.

## Getting started
This projects tries to set `${APP_BASE_URL}/callback` as webhook URL automatically on starting app.

```sh 
$ export LINE_CHANNEL_SECRET=YOUR_CHANNEL_SECRET
$ export LINE_CHANNEL_ACCESS_TOKEN=YOUR_CHANNEL_ACCESS_TOKEN
$ bundle install
$ export APP_BASE_URL="https://your.base.url:4567"
$ bundle exec ruby app.rb
```

## Use local SDK (for SDK contributors)

When developing the SDK in this repository, set `USE_LOCAL_LINE_BOT_SDK_RUBY=1`
so that `bundle install` resolves `line-bot-api` from the local checkout (`../../..`) instead of RubyGems:

```sh
$ USE_LOCAL_LINE_BOT_SDK_RUBY=1 bundle install
```

When `USE_LOCAL_LINE_BOT_SDK_RUBY` is unset, the published gem from RubyGems is used.
