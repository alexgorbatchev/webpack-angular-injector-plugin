var AngularInjectorPlugin, OriginalSource, injector;

OriginalSource = require('webpack-core/lib/OriginalSource');

injector = require('angular-injector');

module.exports = AngularInjectorPlugin = (function() {
  function AngularInjectorPlugin(options) {
    this.options = options != null ? options : {};
  }

  AngularInjectorPlugin.prototype.apply = function(compiler) {
    var options;
    options = this.options;
    return compiler.plugin('compilation', function(compilation) {
      return compilation.plugin('optimize-chunk-assets', function(chunks, callback) {
        var files;
        files = [];
        chunks.forEach(function(chunk) {
          return files = files.concat(chunk.files);
        });
        files = files.concat(compilation.additionalChunkAssets);
        files.forEach(function(file) {
          var map, source;
          if ((options.exclude == null) || !options.exclude.test(file)) {
            map = compilation.assets[file].map();
            source = injector.annotate(compilation.assets[file].source(), options);
            return compilation.assets[file] = new OriginalSource(source, file, map);
          }
        });
        return callback();
      });
    });
  };

  return AngularInjectorPlugin;

})();
