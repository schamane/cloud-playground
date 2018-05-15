'use strict';

const express = require('express'),
	https = require('https'),
	fs = require('fs');

// Constants
const PORT = process.env.PORT || 8443,
	sslOptions = {
		key: fs.readFileSync('key.pem'),
		cert: fs.readFileSync('cert.pem'),
		passphrase: 'test23'
	};

// App
const app = express();
app.get('/', (req, res) => {
  res.send(`Hello world from https ${new Date()} - \n`);
});

https.createServer(sslOptions, app).listen(PORT);
console.log(`Running on https://:${PORT}`);

