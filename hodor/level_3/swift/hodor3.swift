
import Foundation

//===---Description:------------------------------------------------------------===//
// Swift script to solve Hodor Level 3 Project by Julien Barbier - Holberton
// School.
//
// by Alexandro de Oliveira.
//===---XCode Playground:-------------------------------------------------------===//
// For the purpose of understand how the requests works it's interesting to
// test it in the XCode Playground.
// For that matter just add this two lines at the beginning of XCode Playground:
//
// > import XCPlaygroung
// > XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//
// ...and paste the code below in the XCode Playground window.
//===---------------------------------------------------------------------------===//

//===---Function post()---------------------------------------------------------===//
// Function post used to make the http requests:
//===---------------------------------------------------------------------------===//
func post() {
    //Defining the URL to be requested:
    let url = NSURL(string: "http://173.246.108.142/level3.php")
    let cookie = getCookie()
    //Defining the POST request parameters:
    let param = "id=23&holdthedoor=Submit" // To test it replace the "23" with your own id ;-)
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
    //print(request.allHTTPHeaderFields!)
    /*
     * Here we need to develop something different ;-)
     */
    let task = session.dataTaskWithRequest(request, completionHandler:
        { data, response, error -> Void in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            // To print the http response uncomment the line below: << Response
            // print("Response: \(response)")

            // To print the response.Body(html) uncomment the two lines below: << Response Body
            // let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            // print("Body: \(strData)")

        })
        // Making the request:
        task.resume()

    }
//===-----getCookie()-----------------------------------------------------------===//
// Function getCookie() for now just returns a valid cookie.
// Next step is to allow it to get a cookie from server and use it in each request.
//===---------------------------------------------------------------------------===//
var counter = 0
//Calling the function 1024 times.
for i in 0 ..< (1 << 10) {
    post()
    usleep(200000) // <<< This is fundamental to compute the vote ! ! ! (It waits 200 milliseconds before the new request.)
    print("Vote number: \(counter + 1)")
    counter += 1
}

print("BOOOOOOMMMM ! ! !") // A là Julien Barbier, hehe!
