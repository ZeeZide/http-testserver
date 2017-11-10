import Foundation
import HTTP
 
func hello(request: HTTPRequest, response: HTTPResponseWriter, 
           queue: DispatchQueue ) -> HTTPBodyProcessing 
{        
    response.writeHeader(status: .ok) 
    response.writeBody("Hello, World!\n") 
    response.done() 
    return .discardBody 
} 

let server = HTTPServer()
do {
    print("Starting server on: http://localhost:1337/")
    try server.start(port: 1337, handler: hello)
}
catch {
    print("failed to start server:", error)
    exit(42)
}

RunLoop.current.run()
