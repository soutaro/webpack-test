module.exports = {
  devtool: "#inline-source-map",
  // resolve: {
  //   root: [__dirname + '/app/assets/javascripts']
  //   // moduleDirectories: ['app/assets/javascripts']
  // },
  context: __dirname + "/app/assets/javascripts",
  entry: {
    application: "./application"
  },
  output: {
    path: __dirname + "/tmp/webpack",
    filename: "[name].js"
  }
};
