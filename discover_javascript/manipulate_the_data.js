var https = require('https');

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
		var gitObj = JSON.parse(data);
		var items = gitObj.items;
		items.map(function(obj){
			console.log(obj.full_name);	
		});
	});
});
req.end();

req.on('error', function(e) {
	console.log(e);
});

