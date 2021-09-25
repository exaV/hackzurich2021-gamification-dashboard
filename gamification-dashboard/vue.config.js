module.exports = {
  transpileDependencies: ["vuetify"],
  devServer: {
    proxy: {
      "^/api": {
        target: "https://6b9a-178-239-165-206.ngrok.io",
        ws: true,
        changeOrigin: true,
      },
    },
  },
};
