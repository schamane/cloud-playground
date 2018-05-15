'use strict';

const express = require('express');

// Constants
const PORT = process.env.PORT || 8080;

// App
const app = express();
app.get('/', (req, res) => {
  res.send(`Hello world http : ${new Date()}\n`);
});

app.listen(PORT);
console.log(`Running on http://:${PORT}`);

