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
        "<h1>Hello Async Server Swift</h1>" +
        "<h3>Routes</h3>" +
        "<ul>\(localLinks)</ul>" +
        "<hr />" +
        "<center>\(remoteLinks)</center>"
    )
    response.done()
    return .discardBody
}


/**
 * Echo all request input to output.
 *
 * To test:
 *
 *     curl -X POST --data $'Hello World\n' http://localhost:1337/echo
 *
 */
func echo(request: HTTPRequest, response: HTTPResponseWriter,
          queue: DispatchQueue ) -> HTTPBodyProcessing
{
    response.writeHeader(status: .ok)
  
    return .processBody { chunk, shouldStop in
        switch chunk {
            case .chunk(let data, let doneCB):
                response.writeBody(data) { result in doneCB() }
          
            case .end:
                response.done()
          
            case .failed(let error):
                print("failed:", error)
                shouldStop = true
          
            case .trailer:
                break
        }
    }
}

/// Just print out the result of `Date()` aka the current time.
func time(request: HTTPRequest, response: HTTPResponseWriter,
          queue: DispatchQueue ) -> HTTPBodyProcessing
{
    response.writeHeader(status: .ok)
    response.writeBody("Time is: \(Date())")
    response.done()
    return .discardBody
}


/**
 * Emit a 404.
 *
 * To test:
 *
 *     curl -v http://localhost:1337/404/kjsdf
 */
func emit404(request: HTTPRequest, response: HTTPResponseWriter,
             queue: DispatchQueue ) -> HTTPBodyProcessing
{
    response.writeHeader(status: .notFound)
    response.writeBody("404 not found\n")
    response.done()
    return .discardBody
}


/**
 * Async demo. Do not generate response immediately, but after a few
 * seconds.
 *
 * This is not a `sleep()` blocking a thread.
 */
func slow(request: HTTPRequest, response: HTTPResponseWriter,
          queue: DispatchQueue ) -> HTTPBodyProcessing
{
    // Note: we stay on the queue
    let startDate = Date()
    queue.asyncAfter(deadline: .now() + .seconds(5)) {
        let endDate = Date()
        response.writeHeader(status: .ok)
        response.writeBody(
            "started:  \(startDate)\n" +
            "finished: \(endDate)\n"
        )
        response.done()
    }
    return .discardBody
}




// MARK: - Main Program

let routes : [ ( String, HTTPRequestHandler ) ] = [
  ( "/echo", echo    ),
  ( "/time", time    ),
  ( "/slow", slow    ),
  ( "/404",  emit404 ),
  ( "/",     hello   )
]

let server = HTTPServer()
do {
    print("Starting server on: http://localhost:1337/")
    try server.start(port: 1337) { request, response, queue in
        for ( pathPrefix, handler ) in routes {
            if request.target.starts(with: pathPrefix) {
                return handler(request, response, queue)
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
