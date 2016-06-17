
import Foundation

//===-------Description:--------------------------------------------------------===//
// Swift script to solve Hodor Level 0 Project by Julien Barbier - Holberton
// School.
// Working 100% ! ! ! (not Asyncronous yet, though)
//
// Next step is to create an iOS app to automatize the vote process...
// and be able to vote from anywhere! \o/ \o/ \o/
//===------Xcode Playground-----------------------------------------------------===//
// For the purpose of understand how the requests works it's interesting to
// test it in the XCode Playground.
// For that matter just add this two lines at the beginning of XCode Playground:
//
// > import XCPlaygroung
// > XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//
// ...and paste the code below in the Playground window.
//===---------------------------------------------------------------------------===//

//===-----Function post()-------------------------------------------------------===//
// Function post used to make the http requests:
//===---------------------------------------------------------------------------===//
func post() {
    //Defining the URL to be requested:
    let url = NSURL(string: "http://173.246.108.142/level0.php")
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
    request.setValue("havk64 - Swift Requests",  forHTTPHeaderField: "User-Agent") // Use your own User-Agent setting.
    //print(request.allHTTPHeaderFields!)
    let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
        guard data != nil else {
            print("no data found: \(error)")
            return
        }
        if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    counter += 1
                    print("Vote numer: \(counter)")
                } else {
                    print("Connection error... (vote not computed!)")
                }
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
// Variable counter is used to count each valid vote.
var counter = 0
let votes = (1 << 10) // The result of this bitwise operatation(1 << 10) is "1024"
//Calling the function 1024 times.
for i in 0 ..< votes {
    post()
    usleep(500000) // <<< This is fundamental to compute the vote ! ! ! (It waits 500 milliseconds before the new request.)
}

print("BOOOOOOMMMM ! ! !") // A là Julien Barbier, hehe!
