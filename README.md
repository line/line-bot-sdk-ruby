# LINE Messaging API SDK for Ruby

[![Gem version](https://img.shields.io/gem/v/line-bot-api.svg)](https://rubygems.org/gems/line-bot-api) [![Build status](https://github.com/line/line-bot-sdk-ruby/actions/workflows/pull_request.yml/badge.svg)](https://github.com/line/line-bot-sdk-ruby/actions/workflows/pull_request.yml)

Using the LINE Messaging API SDK for Ruby, you can easily use the Messaging API and other APIs provided by the LINE Platform to build your own applications.

## Documentation

For documentation on each client, such as the Messaging API, see the README in each directory:

- [LINE::Client::ChannelAccessToken](lib/clients/channel-access-token/README.md)
- [LINE::Client::Insight](lib/clients/insight/README.md)
- [LINE::Client::Liff](lib/clients/liff/README.md)
- [LINE::Client::ManageAudience](lib/clients/manage-audience/README.md)
- [LINE::Client::MessagingApi](lib/clients/messaging-api/README.md)
- [LINE::Client::Module](lib/clients/module/README.md)
- [LINE::Client::ModuleAttach](lib/clients/module-attach/README.md)
- [LINE::Client::Shop](lib/clients/shop/README.md)
- [LINE::Client::Webhook](lib/clients/webhook/README.md)

For more information on the APIs provided by the LINE Platform, see the [LINE Developers site](https://developers.line.biz/en/).

## Requirements

- Ruby 2.7.0 or later

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'line-bot-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install line-bot-api

## Usage

```ruby
LINE::Client::MessagingApi.configure do |config|
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
result = api_instance.get_webhook_endpoint
result.endpoint # "https://example.com/test"
result.active   # true
```

For more information on how to use this library, see the [Documentation](#documentation).

## Related sites

| Site          | URL                                             |
| ------------- | ----------------------------------------------- |
| FAQ           | https://developers.line.biz/en/faq/             |
| Community Q&A | https://www.line-community.me/questions         |
| News          | https://developers.line.biz/en/news/            |
| Twitter       | [@LINE_DEV_EN](https://twitter.com/LINE_DEV_EN) |

## Versioning

The versioning policy for this project follows Semantic Versioning:

- [Semantic Versioning](https://semver.org/)

## Breaking changes

The LINE SDK development team has decided to generate codes based on the [LINE OpenAPI](https://github.com/line/line-openapi) specification. As a result, the version 2 series of the LINE Messaging API SDK for Ruby is not compatible with the version 1 series.

We plan to maintain only the version 2 series from now on. The 1 series can still be used, but we recommend using the 2 series to take advantage of the latest features.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/line/line-bot-sdk-ruby. See [CONTRIBUTING](CONTRIBUTING.md) before you make a contribution.

## License

```
Copyright (C) 2016 LINE Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
