<h2>http-testserver
  <img src="https://avatars3.githubusercontent.com/u/10814202?s=200&v=4"
       align="right" height="128" />
</h2>

Simple Test Server using the Async Swift Server API

## Setup

```
git clone https://github.com/ZeeZide/http-testserver.git
cd http-testserver

swift build
  Fetching https://github.com/ZeeZide/http.git
  Cloning https://github.com/ZeeZide/http.git
  Resolving https://github.com/ZeeZide/http.git at feature/gcd-async-server
  Compile CHTTPParser http_parser.c
  Compile Swift Module 'HTTP' (9 sources)
  Compile Swift Module 'http_testserver' (1 sources)
  Linking ./.build/x86_64-apple-macosx10.10/debug/http-testserver

./.build/x86_64-apple-macosx10.10/debug/http-testserver
  Starting server on: http://localhost:1337/
```

Server pages:

- [http://localhost:1337/](http://localhost:1337/)

## Tutorial

- [Using the Swift Server API 0.1.0](http://www.alwaysrightinstitute.com/http-010/)
  - including hosting the stuff in Apache

## Who

http-testserver is brought to you by
[ZeeZide](http://zeezide.de).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.
We don't like people who are wrong.

There is a swift-server.slack.com Slack group.
