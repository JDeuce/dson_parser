var path = require('path');

module.exports = {
  context: __dirname,
  resolve: {
    root: [ path.resolve(__dirname, 'src'), path.resolve(__dirname, 'node_modules') ],
    extensions: ['', '.js', '.pegjs']
  },
  module: {
    loaders: [
      {
        test: /\.pegjs$/,
        loader: 'pegjs-loader'
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      }
    ]
  }
};
