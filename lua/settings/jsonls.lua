local default_schemas = require("schemastore").json.schemas()

local schemas = {
  {
    fileMatch = { "app.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/app.schema.json",
  },
  {
    fileMatch = { "ext.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/ext.schema.json",
  },
  {
    fileMatch = { "game.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/game.schema.json",
  },
  {
    fileMatch = { "plugin.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/plugin.schema.json",
  },
  {
    fileMatch = { "project.config.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/project.config.schema.json",
  },
  {
    fileMatch = { "project.private.config.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/project.private.config.schema.json",
  },
  {
    fileMatch = { "sitemap.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/sitemap.schema.json",
  },
  {
    fileMatch = { "container.config.json" },
    url = "https://dldir1.qq.com/WechatWebDev/editor-extension/wx-json/container.config.schema.json",
  },
  {
    fileMatch = { "androidPrivacy.json" },
    url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/androidPrivacy.json",
  },
  {
    fileMatch = { "manifest.json" },
    url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/manifest.json",
  },
  {
    fileMatch = { "pages.json" },
    url = "https://raw.githubusercontent.com/ModyQyW/uni-helper/main/packages/vscode-uni-app-schemas/schemas/pages.json",
  },
  {
    fileMatch = {
      "*.json",
      "!/settings.json",
      "!/config.json",
      "!/app.json",
      "!/ext.json",
      "!/game.json",
      "!/plugin.json",
      "!/project.config.json",
      "!/sitemap.json",
      "!/container.config.json",
      "!/.eslintrc.*",
      "!project.private.config.json",
      "!keybindings.json",
    },
    url = "https://dldir1.qq.com/WechatWebDev/plugins/editor/wechat-miniprogram_wx-json/1.0.0/page_component.schema.json",
  },
}

local extended_schemas = vim.tbl_deep_extend("force", default_schemas, schemas)

return {
  settings = {
    json = {
      schemas = extended_schemas,
    },
  },
}
