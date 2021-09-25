module.exports = {
  transpileDependencies: ["vuetify"],
  devServer: {
    proxy: {
      "^/api": {
        target: "https://70c6-178-239-165-206.ngrok.io",
        ws: true,
        changeOrigin: true,
      },
    },
  },
};
