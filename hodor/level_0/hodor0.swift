
import Foundation

//===----------------------------------------------------------------------===//
// For the purpose of understand how the requests works it's interesting to
// test it in the XCode Playground.
// Just add this two lines at the beginning
// of XCode Playground:
// > import XCPlaygroung
// > XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//===----------------------------------------------------------------------===//
// Function post used to make the http requests:
//===----------------------------------------------------------------------===//
func post() {
    //Defining the URL to be requested:
    let url = NSURL(string: "http://173.246.108.142/level0.php")
    //Defining the POST request parameters:
    let param = "id={your id here}&holdthedoor=Submit"
    //Initializing the session:
    let session = NSURLSession.sharedSession()
    //The NSMutableURLRequest allow us to change its parameters later(header, values):
    let request = NSMutableURLRequest(URL: url!) //let request = NSURLRequest(URL: url!)
    //Defining the http Method:
    request.HTTPMethod = "POST"
    //Encoding the parameters to the HTTPBody.
    request.HTTPBody = param.dataUsingEncoding(NSUTF8StringEncoding)
    //Setting the headers:
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("{Your custom User-Agent here}",  forHTTPHeaderField: "User-Agent")

    let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
        guard data != nil else {
            print("no data found: \(error)")
            return
        }
        print("Response: \(response)")
        let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("Body: \(strData)")
    })
    // Initiating the connection:
    task.resume()
}

//Calling the function 1024 times.
for i in 0 ..< 1024 {
    post()
}
