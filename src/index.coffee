fs = require "fs"
fspath = require "path"
_ = require "lodash"
mkdirp = require "mkdirp"
jade = require "jade"
minify = require("html-minifier").minify

module.exports = class JadePages
  brunchPlugin: true
  type: "template"
  extension: "jade"

  DEFAULT_DESTINATION_FN: (path) ->
    path.replace /^app[\/\\](.*)\.jade$/, "$1.html"
  DEFAULT_JADE_OPTIONS:
    doctype: "html"
  DEFAULT_HTMLMIN_OPTIONS:
    removeComments: true
    removeCommentsFromCDATA: true
    removeCDATASectionsFromCDATA: true
    collapseWhitespace: true
    collapseBooleanAttributes: true
    removeAttributeQuotes: true
    removeRedundantAttributes: true
    useShortDoctype: true
    removeEmptyAttributes: true
    removeScriptTypeAttributes: true
    removeStyleLinkTypeAttributes: true

  constructor: (config) ->
    optimize = config.optimize
    pluginConfig = config.plugins?.jadePages
    @pattern = pluginConfig?.pattern
    @publicPath = fspath.resolve(config.paths.public)
    @destinationFn = pluginConfig?.destination ? @DEFAULT_DESTINATION_FN

    jadeConfig = _.extend({}, pluginConfig?.jade)
    @jadeLocals = jadeConfig.locals
    delete jadeConfig.locals
    @jadeOptions = _.extend(jadeConfig, @DEFAULT_JADE_OPTIONS)
    if optimize
      # We don't want redundant whitespaces for product version, right?
      @jadeOptions.pretty = false

    # Disable html-minifier by default.
    @htmlmin = false
    if optimize
      htmlminConfig = pluginConfig?.htmlmin
      if _.isBoolean(htmlminConfig)
        @htmlmin = htmlminConfig
        @htmlminOptions = @DEFAULT_HTMLMIN_OPTIONS
      else if _.isObject(htmlminConfig)
        @htmlmin = true
        @htmlminOptions = htmlminConfig

  compile: (data, path, callback) ->
    try
      templateFn = jade.compile(data, @jadeOptions)
      result = templateFn(@jadeLocals)
      if @htmlmin
        result = minify(result, @htmlminOptions)
      destinationPath = @destinationFn(path)
      destinationPath = fspath.join(@publicPath, destinationPath)
      destinationDir = fspath.dirname(destinationPath)
      mkdirp.sync(destinationDir)
      fs.writeFileSync destinationPath, result
    catch err
      # XXX: For some reason brunch doesn't report this errors.
      console.error "Error while processing '#{path}': #{err.toString()}"
      error = err
    finally
      # Do not send anything back to brunch as we write compiled jade
      # page by ourself.
      callback error, ""
