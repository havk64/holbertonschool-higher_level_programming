var https = require('https');

var options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token 8ac478d797eecd39a3f8198d432dd772882f1c41'
  }
}

var req = https.request(options, function(res) {
	console.log(res.statusCode);
	res.on('data', function(d) {
	process.stdout.write(d);
	});
});
req.end();

req.on('error', function(e) {
	console.log(e);
});
