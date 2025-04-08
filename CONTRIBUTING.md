# How to contribute to LINE Bot SDK for Ruby project

First of all, thank you so much for taking your time to contribute!
LINE Bot SDK for Ruby is not very different from any other open source projects you are aware of.
It will be amazing if you could help us by doing any of the following:

- File an issue in [the issue tracker](https://github.com/line/line-bot-sdk-ruby/issues) to report bugs and propose new features and improvements.
- Ask a question using [the issue tracker](https://github.com/line/line-bot-sdk-ruby/issues).
- Contribute your work by sending [a pull request](https://github.com/line/line-bot-sdk-ruby/pulls).

## Development

### YARD

We use [YARD](https://yardoc.org) to generate and maintain our code documentation.
**Please make sure your new or modified code is also covered by proper YARD doc comments.**
Good documentation ensures that contributors and users can easily read and understand how the methods and classes work.

#### How to generate and view documentation locally

##### 1. **Start a local documentation server**

Run the following command to start a local YARD server that will automatically reload when files change:

```bash
bundle exec yard server --reload
```

Then open the printed URL in your browser (e.g., http://localhost:8808).

##### 2. **Validate your documentation**  

Before pushing your changes, run the following command to check YARD documentation coverage and warnings:
```bash
bundle exec yard stats ./lib/line/bot/v2 --fail-on-warning
```
This will fail if there are missing doc comments or any YARD-specific warnings.
Make sure to fix any issues before creating a pull request.

For more details on how to write YARD doc comments, refer to YARD’s official [Getting Started guide](https://rubydoc.info/gems/yard/file/docs/GettingStarted.md).

### Contributor license agreement

When you are sending a pull request and it's a non-trivial change beyond fixing typos, please make sure to sign [the ICLA (individual contributor license agreement)](https://cla-assistant.io/line/line-bot-sdk-ruby).
Please [contact us](mailto:dl_oss_dev@linecorp.com) if you need the CCLA (corporate contributor license agreement).
