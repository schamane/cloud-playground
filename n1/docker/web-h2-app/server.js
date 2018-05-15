'use strict';

const express = require('express'),
	spdy = require('spdy'),
	fs = require('fs'),
	os = require('os');

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
  res.send(`Hello world for h2::${os.hostname()} ${new Date()} - \n`);
});

spdy.createServer(sslOptions, app).listen(PORT);
console.log(`Running on https://:${PORT}`);

