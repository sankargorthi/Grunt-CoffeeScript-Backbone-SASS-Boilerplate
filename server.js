var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var configProps = require('./config.json');

app.use(express.static('dist'));

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

app.get('/', function(req, res) {
    res.sendfile('dist/index.html');
});

app.listen(configProps.port, configProps.hostName, function () {
    console.log('Running at http://' + configProps.hostName + ':' + configProps.port);
});
