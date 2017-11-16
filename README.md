<h2>http-testserver
  <img src="https://avatars3.githubusercontent.com/u/10814202?s=200&v=4"
       align="right" height="128" />
</h2>

![Swift3](https://img.shields.io/badge/swift-3-blue.svg)
![Swift4](https://img.shields.io/badge/swift-4-blue.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)
![Travis](https://travis-ci.org/ZeeZide/http-server.svg?branch=develop)

Simple Test Server using the Async Swift Server API

- [Swift Server Project HTTP APIs](https://github.com/swift-server/http)
- [Async GCD Server Fork](https://github.com/ZeeZide/http/tree/feature/gcd-async-server) used here
- Tutorial: [Using the Swift Server API 0.1.0](http://www.alwaysrightinstitute.com/http-010/)

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


## Xcode

```
swift package generate-xcodeproj
open http-testserver.xcodeproj
```

Make sure to select the right target, then build and run.


## CURL

```
curl -X POST --data $'Hello World\n' http://localhost:1337/echo
```

## Who

http-testserver is brought to you by and not from the
[ZeeZide](http://zeezide.de).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.
We don't like people who are wrong.

There is a swift-server.slack.com Slack group.
