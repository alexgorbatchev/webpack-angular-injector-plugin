require 'coffee-errors'

chai = require 'chai'
fs = require 'fs'
webpack = require 'webpack'
# using compiled JavaScript file here to be sure module works
AngularInjectorPlugin = require '../lib/webpack-angular-injector-plugin.js'

expect = chai.expect
chai.use require 'sinon-chai'

describe 'webpack-angular-injector-plugin', ->
  describe 'processing file', ->
    before (done) ->
      config =
        target: 'web'

        entry:
          fixture: "#{__dirname}/fixture.js"

        output:
          path: __dirname
          filename: '[name].result.js'
          chunkFilename: 'chunk.js'

        plugins: [
          new AngularInjectorPlugin()
        ]

      webpack config, done

    after (done) ->
      fs.unlink "#{__dirname}/fixture.result.js", done

    it 'generates fixture.result.js', (done) ->
      fs.exists "#{__dirname}/fixture.result.js", (exists) ->
        expect(exists).to.be.ok
        done()

    it 'applies angular-injector', (done) ->
      fs.readFile "#{__dirname}/fixture.result.js", 'utf8', (err, content) ->
        expect(content).to.contain "app.service(['$http', function($http) {"
        done()

  describe 'filtering out file', ->
    before (done) ->
      config =
        target: 'web'

        entry:
          fixture: "#{__dirname}/fixture.js"

        output:
          path: __dirname
          filename: '[name].result.js'
          chunkFilename: 'chunk.js'

        plugins: [
          new AngularInjectorPlugin exclude: /fixture/
        ]

      webpack config, done

    it 'does not generate fixture.result.js', (done) ->
      fs.exists "#{__dirname}/fixture.result.js", (exists) ->
        expect(exists).to.be.falsy
        done()

    it 'does not apply angular-injector', (done) ->
      fs.readFile "#{__dirname}/fixture.result.js", 'utf8', (err, content) ->
        expect(content).to.contain "app.service(ng(function($http) {"
        done()
