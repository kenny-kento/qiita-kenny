import * as FontAwesome from "./build/fontawesome";
require("dotenv").config();

export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,

  // Target: https://go.nuxtjs.dev/config-target
  target: "static",

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    title: "Qiita-kenny",
    htmlAttrs: {
      lang: "ja",
    },
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { hid: "description", name: "description", content: "" },
      { name: "format-detection", content: "telephone=no" },
    ],
    link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: ["~/assets/styles/main.scss"],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: ["~/plugins/axios.js"],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/typescript
    "@nuxt/typescript-build",
    ["@nuxtjs/fontawesome", { component: "fontAwesome", suffix: true }],
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    "bootstrap-vue/nuxt",
    "@nuxtjs/axios",
    "@nuxtjs/auth",
    "@nuxt/content",
    "@nuxtjs/markdownit",
    "@nuxtjs/vuetify",
  ],

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {},

  fontawesome: {
    icons: {
      solid: FontAwesome.solid,
      regular: FontAwesome.regular,
      brands: FontAwesome.brands,
    },
  },
  axios: {
    baseURL: "http://localhost:3001",
  },
  content: {},
  markdownit: {
    // ref: https://github.com/markdown-it/markdown-it
    injected: true,
    breaks: true,
    linkify: true,
    breaks: true,
    use: ["markdown-it-highlightjs"],
  },
  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: "/api/auth/sign_in",
            method: "post",
            propertyName: "access_token",
          },
          logout: { url: "/api/auth/sign_out", method: "delete" },
          user: false,
        },
      },
    },
  },
  env: {
    baseUrl: process.env.BASE_URL || "http://localhost:3001",
  },
};
