const path = require('path');

module.exports = {
  entry: './index.js',
  output: {
    path: path.resolve(__dirname, '..', 'public', 'dist'),
    filename: 'bundle.js'
  },
  module: {
    rules: [{
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      }, {
          test: /\.js$/,
          loader: 'ify-loader'
      }
    ]
  }
};
