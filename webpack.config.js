const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = (env, argv) => {
  const elmOptions = argv.mode === "development" ? { debug: true } : {};

  return {
    entry: path.join(__dirname, "src"),
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: "elm-webpack-loader",
          options: elmOptions
        }
      ]
    },
    devServer: {
      contentBase: path.join(__dirname, "public"),
      compress: true,
      port: 9000
    },
    plugins: [new HtmlWebpackPlugin({ template: "public/index.html" })]
  };
};
