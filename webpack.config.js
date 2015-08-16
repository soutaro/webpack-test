module.exports = {
  devtool: "#inline-source-map",
  module: {
    loaders: [
      { test: /\.json$/, loader: 'json-loader' },
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      { test: /\.(png|jpg)$/, loader: 'url?limit=10000!img?progressive=true' },
    ]
  },
  // resolve: {
  //   root: [__dirname + '/app/assets/javascripts']
  //   // moduleDirectories: ['app/assets/javascripts']
  // },
  context: __dirname + "/app/assets/javascripts",
  entry: {
    application: "./application.js"
  },
  output: {
    path: __dirname + "/tmp/webpack",
    filename: "[name].js"
  }
};
