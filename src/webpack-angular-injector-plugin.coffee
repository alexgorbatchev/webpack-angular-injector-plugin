OriginalSource = require 'webpack-core/lib/OriginalSource'
injector = require 'angular-injector'

module.exports = class AngularInjectorPlugin
  constructor: (@options = {}) ->

  apply: (compiler) ->
    options = @options

    compiler.plugin 'compilation', (compilation) ->
      compilation.plugin 'optimize-chunk-assets', (chunks, callback) ->
        files = []

        chunks.forEach (chunk) ->
          files = files.concat chunk.files

        files = files.concat compilation.additionalChunkAssets

        files.forEach (file) ->
          if not options.exclude? or not options.exclude.test file
            map = compilation.assets[file].map()
            source = injector.annotate compilation.assets[file].source(), options
            compilation.assets[file] = new OriginalSource source, file, map

        callback()