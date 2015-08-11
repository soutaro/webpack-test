var express = require('express');
var webpackDevMiddleware = require("webpack-dev-middleware");
var webpack = require("webpack");

var app = express();

var config = require('./webpack.config.js');

var compiler = webpack(config);

app.use(webpackDevMiddleware(compiler, {
    lazy: true
}));

var server = app.listen(3001, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
