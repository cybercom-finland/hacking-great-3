'use strict';

const express = require('express');
const os = require('os');

// Constants
const PORT = 8080;

// App
const app = express();

const hostname = os.hostname();
app.get('/', (req, res) => {
	res.send('Hello world from ' + hostname + '\n');
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
