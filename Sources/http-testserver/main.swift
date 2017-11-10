//
//  Created by Helge Heß on 11/10/17.
//  Copyright © 2017 ZeeZide GmbH. All rights reserved.
//
import Foundation
import Dispatch
import HTTP

let links = [
  ( "Swift Server APIs", "https://github.com/swift-server/http" ),
  ( "http-testserver", "https://github.com/ZeeZide/http-testserver" ),
  ( "Tutorial", "http://www.alwaysrightinstitute.com/http-010/" ),
  ( "ZeeZide", "http://zeezide.com/" ),
]

// MARK: - Test Endpoints

func hello(request: HTTPRequest, response: HTTPResponseWriter,
           queue: DispatchQueue ) -> HTTPBodyProcessing
{
  response.writeHeader(status: .ok,
                       headers: [ "Content-Type": "text/html" ])
  
  let localLinks = routes.map {
    "<li><a href='\($0.0)'>\($0.0)</a></li>"
  }.joined()
  
  let remoteLinks = links.map {
    "<a href='\($0.1)'>\($0.0)</a>"
  }.joined(separator: " / ")
  
  response.writeBody(
    """
    <h1>Hello Async Server Swift</h1>
    <h3>Routes</h3>
    <ul>\(localLinks)</ul>
    <hr />
    <center>\(remoteLinks)</center>
    """
  )
  response.done()
  return .discardBody
}

func echo(request: HTTPRequest, response: HTTPResponseWriter,
          queue: DispatchQueue ) -> HTTPBodyProcessing
{
  response.writeHeader(status: .ok)
  response.writeBody("Hello, World!\n")
  response.done()
  return .discardBody
}

func time(request: HTTPRequest, response: HTTPResponseWriter,
          queue: DispatchQueue ) -> HTTPBodyProcessing
{
  response.writeHeader(status: .ok)
  response.writeBody("Time is: \(Date())")
  response.done()
  return .discardBody
}

func emit404(request: HTTPRequest, response: HTTPResponseWriter,
             queue: DispatchQueue ) -> HTTPBodyProcessing
{
  response.writeHeader(status: .notFound)
  response.writeBody("404 not found\n")
  response.done()
  return .discardBody
}


let routes : [ ( String, HTTPRequestHandler ) ] = [
  ( "/echo", echo    ),
  ( "/time", time    ),
  ( "/404",  emit404 ),
  ( "/",     hello   )
]

// MARK: - Main Program

let server = HTTPServer()
do {
    print("Starting server on: http://localhost:1337/")
    try server.start(port: 1337) { request, response, queue in
        for route in routes {
            if request.target.starts(with: route.0) {
                return route.1(request, response, queue)
            }
        }
      
        response.writeHeader(status: .notFound)
        response.done()
        return .discardBody
    }
}
catch {
    print("failed to start server:", error)
    exit(42)
}

RunLoop.current.run()
