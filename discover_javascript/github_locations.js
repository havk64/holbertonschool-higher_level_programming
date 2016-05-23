const https = require('https');
const fs = require('fs');

const options = {
	hostname: 'api.github.com',
	path: '/search/repositories?q=language:javascript&sort=stars&order=desc',
	headers: {
	'User-Agent': 'Holberton_School',
	'Authorization': 'token 6a54def2525aa32b003337b31487e321d6a2bb59'
  }
}

var streamToString = (stream, cb) => {
  const chunks = [];
  stream.on('data', (chunk) => {
    chunks.push(chunk);
  });
  stream.on('end', () => {
    cb(chunks.join(''));
  });
}

const req = https.request(options, (res) => {
    console.time("dbsave");
	streamToString(res, (data) => {
		const gitObj = JSON.parse(data);
        const result = [];
        const items = gitObj.items;
        items.map((obj) =>{
            result.push({fullName: obj.full_name ,login: obj.owner.login});
        })
        compute(result);
	});
});
req.end();

req.on('error', (e) => {
	console.log(e);
});

const compute = (result) => {
    const final = [];
    result.map((user) => {
        options.path = '/users/'+user.login;
        const reqUser = https.request(options, (res) => {
            streamToString(res, (data) => {
                data = JSON.parse(data);
                final.push({"full_name": user.fullName, "location": data.location});
		console.log(user.fullName);
                complete();
            });
        });
        reqUser.end();
        reqUser.on('error', (e) => {
            console.log(e);
        });
    });
    const complete = () => {
        if(final.length == 30){
	    console.log(JSON.stringify(final));
	    console.timeEnd("dbsave");
            /*fs.writeFile("/tmp/23", JSON.stringify(final), (err) => {
                if(err) {
                    console.log(err);
                }
                console.log("The file was saved!");
            });*/
        } 
    }
};
