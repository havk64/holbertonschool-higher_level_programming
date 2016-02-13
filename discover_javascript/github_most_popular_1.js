var https = require('https');

var options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token 871d65c65635f8c39047c940ee7de3dd2fb3aba7'
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
