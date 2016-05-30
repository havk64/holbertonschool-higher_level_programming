let http = require('http');
let querystring = require('querystring');
//let request = require('request');
const num_votes = (1 << 10);

const params = querystring.stringify({
    'id': '23',
    'holdthedoor': 'submit'
});

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
for( let i = 0; i < num_votes; i++) {
    let post = http.request(options, (res) => {
        //console.log('Status: ' + res.statusCode);
        //console.log('Headers: ' + JSON.stringify(res.headers));
        res.setEncoding('utf8');
        res.on('data', (chunk) => {
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
