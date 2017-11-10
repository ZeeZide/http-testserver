<h2>http-testserver
  <img src="https://avatars3.githubusercontent.com/u/10814202?s=200&v=4"
       align="right" height="128" />
</h2>

Simple Test Server using the Async Swift Server API

- [Swift Server Project HTTP APIs](https://github.com/swift-server/http)
- [Async GCD Server Fork](https://github.com/ZeeZide/http/tree/feature/gcd-async-server) used here

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

### Build in Linux using Docker4Mac

```
docker run --rm \
  -v $PWD:/buildit \
  -v $PWD/.build-linux:/buildit/.build \
  helje5/swift-dev \
  swift build --package-path /buildit
```

... and run it:

```
docker run -p 1337:1337 -d --name async-swift --rm \
  -v $PWD:/buildit \
  -v $PWD/.build-linux:/buildit/.build \
  helje5/swift-dev \
   /buildit/.build/x86_64-unknown-linux/debug/http-testserver
```

## Tutorial

- [Using the Swift Server API 0.1.0](http://www.alwaysrightinstitute.com/http-010/)

## Who

http-testserver is brought to you by and not from the
[ZeeZide](http://zeezide.de).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.
We don't like people who are wrong.

There is a swift-server.slack.com Slack group.
