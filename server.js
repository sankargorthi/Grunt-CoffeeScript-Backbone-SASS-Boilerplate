var express = require('express'),
    app = express(),
    configProps = require('./config.json');

app.use(express.static(__dirname));
app.configure(function() {
    app.use(express.bodyParser());
});

app.get('/', function(req, res) {
    res.sendfile('dist/index.html');
});
app.listen(configProps.port, configProps.hostName);
console.log("Running at http://" + configProps.hostName + ':' + configProps.port);

