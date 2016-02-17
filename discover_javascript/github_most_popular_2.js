const https = require('https');

const options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
  }
}

const streamToString = (stream, cb) => {
  const chunks = [];
  stream.on('data', (chunk) => {
    chunks.push(chunk);
  });
  stream.on('end', () => {
    cb(chunks.join(''));
  });
}
const req = https.request(options, (res) => {
	streamToString(res, (data) => {
	console.log(typeof data);
	console.log(data);
    });
});
req.end();

req.on('error', (e) => {
	console.log(e);
});

