# Audience

[Use Audiences](https://developers.line.biz/en/docs/messaging-api/using-audience/)

## Getting started
Update User ID of `app.rb` and `audience.txt' to your own.

```sh
$ export LINE_CHANNEL_SECRET=YOUR_CHANNEL_SECRET
$ export LINE_CHANNEL_ACCESS_TOKEN=YOUR_CHANNEL_ACCESS_TOKEN
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
