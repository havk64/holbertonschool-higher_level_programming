var https = require('https');
var fs = require('fs');

var token = process.env.TOKEN;
var options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token '+token
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
		console.log("The file was saved!");
		});
	});

});
req.end();

req.on('error', function(e) {
	console.log(e);
});
