/***
 * ===---Description------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 0 by Julien Barbier.
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
const params = querystring.stringify({
    'id': '23',
    'holdthedoor': 'submit'
});
// Setting the http Request/Headers.
const options = {
    hostname: '173.246.108.142',
    port: '80',
    path: '/level0.php',
    method: 'POST',
    headers: {
        'User-Agent': 'Node.js Post Requests - Alexandro de Oliveira',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': params.length
    }
};

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
        })
    });
    post.on('error', (e) => {
        console.log(`Request problem: ${e.message}`);
    })
    //console.log(post);

    post.write(params);
    post.end();
}
