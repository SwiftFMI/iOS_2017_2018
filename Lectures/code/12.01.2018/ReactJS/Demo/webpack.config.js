// /// BABLE LOADER SETTINGS ///

var path = require('path');
var webpack = require('webpack');

var babelOptions = {
  "presets": [
    "react",
    "babel-preset-es2015"
  ]
};

module.exports = {
  cache: true,
  entry: {
    main: './src/index.ts'
  },
  output: {
    path: path.resolve(__dirname, './assets/js'),
    filename: 'instagram.fmi.js',
  },
  plugins: [
    new webpack.SourceMapDevToolPlugin({
      filename: 'instagram.fmi.js.map',
      noSources: true,
      include: ['instagram.fmi.js']
    })
  ],
  // Enable sourcemaps for debugging webpack's output.
  devtool: "source-map",
  resolve: {
    // Add '.ts' and '.tsx' as resolvable extensions.
    extensions: [".ts", ".tsx", ".js", ".json"]
  },
  module: {
    rules: [{
      test: /\.ts(x?)$/,
      exclude: /node_modules/,
      use: [
        {
          loader: 'babel-loader',
          options: babelOptions
        },
        {
          loader: 'ts-loader'
        }
      ]
    }, {
      test: /\.js$/,
      exclude: /node_modules/,
      use: [
        {
          loader: 'babel-loader',
          options: babelOptions
        }
      ]
    }]
  },
  resolve: {
    extensions: [".ts", ".tsx", ".js", ".json"]
  },
};