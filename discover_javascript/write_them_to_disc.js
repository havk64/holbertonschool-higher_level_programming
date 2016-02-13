var https = require('https');
var fs = require('fs');

var options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token 8ac478d797eecd39a3f8198d432dd772882f1c41'
  }
}

function streamToString(stream, cb) {
  const chunks = [];
  stream.on('data', (chunk) => {
    chunks.push(chunk);
  });
  stream.on('end', () => {
    cb(chunks.join(''));
  });
}
var req = https.request(options, function(res) {
	streamToString(res, function(data){
	fs.writeFile("/tmp/23", data, function(err){
		if(err) {
			return console.log(err);
		}	
	});
	//console.log(typeof data);
	//console.log(data);
//})

	//res.on('data', function(d) {
	//process.stdout.write(d);
	//});
});
req.end();

req.on('error', function(e) {
	console.log(e);
});

