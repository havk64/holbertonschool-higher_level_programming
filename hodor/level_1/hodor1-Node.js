/***
 * ===---Description------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 1 by Julien Barbier.
 *  Using Node JS with ES6 Syntax(Harmony).
 *
 *  by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
 */

// Use the "request" module would make the code more compact and readable,
// but could make the grade process tricky as would be necessary to install it.
let http = require('http');
let querystring = require('querystring');

const num_votes = (1 << 10); //The bitwise left shift operation: (1 << 10) = "1024"
// The parameters for the POST request Body.
let data = {
    'id': '23',
    'holdthedoor': 'submit',
};

params = querystring.stringify(data);
// Setting the http Request/Headers.
let options = {
    hostname: '173.246.108.142',
    port: '80',
    path: '/level1.php',
    method: 'POST',
    headers: {
        'User-Agent': 'Node.js Post Requests - Alexandro de Oliveira', //'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': params.length
    }
};
console.log("Starting...");
let cookies = fetchCookie(options);

// This is the main function, which will process all POST requests.
function runIt(options, params){
    let votes = 0;
    for( let i = 0; i < num_votes; i++) { // 1024 times.
        let post = http.request(options, (res) => {
            // Optionally we could print the status code.
            //console.log('Status: ' + res.statusCode);
            // ...and the headers.
            //console.log('Headers: ' + JSON.stringify(res.headers));
            res.setEncoding('utf8');
            res.on('data', (chunk) => {
                //Here the chunck is the response body, the html.
                //console.log("Response: " + chunk );
                console.log(`Vote number: ${votes += 1}`);
            });
            res.on('error', (e) => {
                console.log(e);
            });
        });
        post.on('error', (e) => {
            console.log(`Request problem: ${e.message}`);
        });
        //console.log(post);
        post.write(params);
        post.end();
        //;
    }
}

// This function is used just to get a valid cookie or use an old, specified in case of failure.
// After that we cann the main function.
function fetchCookie(options) {
    options['method'] = "GET";
    let req = http.request(options, (res) => {
        // Optionally show the headers:
        //console.log(JSON.stringify(res.headers));
        let parsing = res.headers['set-cookie'][0] || "dbff031ccdef4d0be53054fba99dc18e06d0030e";
        // Parsing the cookie:
        let cookie = parsing.split(';')[0].split('=')[1];
        data['key'] = cookie;
        postParams = querystring.stringify(data);
        options['method'] = "POST";
        options['headers']['Cookie'] = "HoldTheDoor=" + cookie;
        options['headers']['Content-Length'] = 69;
        runIt(options, postParams); //

        res.on('error', (e) => {
            console.log(e);
        });
    });
    req.on('error', (e) => {
        console.log(e);
    });
    //req.write(params);
    req.end();
}
