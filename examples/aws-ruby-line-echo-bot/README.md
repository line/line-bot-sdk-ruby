# aws-line-echo-bot

Follow this [project](https://github.com/louis70109/aws-line-echo-bot),

I use my first language(ruby) to build this on serverless,

so you can use this project in others case.

# others

This project is merged in [serverless/example](https://github.com/serverless/examples/tree/master/aws-ruby-line-bot)

# Bebore you start

1. Line developer account
2. [Line Message API](https://developers.line.biz/en/docs/messaging-api/getting-started/)

# Quick Start

1. Install serverless via npm

```bash=
$ npm install -g serverless
```

2. Setup your **AWS** ceritficate

```bash=
export AWS_ACCESS_KEY_ID=<your-key-here>
export AWS_SECRET_ACCESS_KEY=<your-secret-key-here>
```

3. Clone this project

```bash=
$ serverless install --url https://github.com/louis70109/aws-ruby-line-echo-bot -n <YOUR_FILE_NAME>
$ cd <YOUR_FILE_NAME>/
```

4. Insert you line bot secret & key

```python=
config.channel_secret = "YOUR_LINE_CHANNEL_SECRET"
config.channel_token = "YOUR_LINE_CHANNEL_TOKEN"
```

5. Deploy the webhhok function

```bash=
npm install
serverless deploy
```

Now you can test you chatbot, have fun!
![Echo bot](https://i.imgur.com/ekiLRHS.png)

# References

- [Plugin hook](https://github.com/serverless/serverless/issues/5567#issuecomment-444671106)
