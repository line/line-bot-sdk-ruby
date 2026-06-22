# Channel access token example

[Issue channel access token](https://developers.line.biz/en/docs/messaging-api/generate-json-web-token/)

## Getting started

```sh
$ export LINE_CHANNEL_ID=YOUR_CHANNEL_ID
$ export LINE_CHANNEL_SECRET=YOUR_CHANNEL_SECRET
$ bundle install
$ bundle exec ruby app.rb
```

## Use local SDK (for SDK contributors)

When developing the SDK in this repository, set `USE_LOCAL_LINE_BOT_SDK_RUBY=1`
so that `bundle install` resolves `line-bot-api` from the local checkout (`../../..`) instead of RubyGems:

```sh
$ USE_LOCAL_LINE_BOT_SDK_RUBY=1 bundle install
```

When `USE_LOCAL_LINE_BOT_SDK_RUBY` is unset, the published gem from RubyGems is used.
