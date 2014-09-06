# webpack-angular-injector-plugin

[![Dependency status](http://img.shields.io/david/alexgorbatchev/webpack-angular-injector-plugin.svg?style=flat)](https://david-dm.org/alexgorbatchev/webpack-angular-injector-plugin)
[![devDependency Status](http://img.shields.io/david/dev/alexgorbatchev/webpack-angular-injector-plugin.svg?style=flat)](https://david-dm.org/alexgorbatchev/webpack-angular-injector-plugin#info=devDependencies)
[![Build Status](http://img.shields.io/travis/alexgorbatchev/webpack-angular-injector-plugin.svg?style=flat&branch=master)](https://travis-ci.org/alexgorbatchev/webpack-angular-injector-plugin)

[![NPM](https://nodei.co/npm/webpack-angular-injector-plugin.svg?style=flat)](https://npmjs.org/package/webpack-angular-injector-plugin)

## Installation

This [Webpack](http://webpack.github.io/) plugin is meant to solve an annoying problem of minification and dependency injection in [`angular.js`](https://www.angularjs.org). `angular-injector` works better and more reliably than [`ngmin`](https://www.npmjs.org/package/ngmin) because it works with any syntax and every possible declaration regardless of where and how it happens. `webpack-angular-injector-plugin` wraps [`angular-injector`](https://github.com/alexgorbatchev/angular-injector).

In order for minified Angular applicaiton to continue working, all functions must be annotated:

    someModule.factory('greeter', function($window) {
      // ...
    });

Must be rewritten as:

    someModule.factory('greeter', ['$window', function($window) {
      // ...
    }]);

This module does that automatically.

## Support

Please help me spend more time developing and maintaining awesome modules like this by donating! Just setup [Gittip](http://gittip.com) if you haven't already and if you donate $1/week I can buy a coffee on your behalf to keep me coding.

[![Gittip](http://img.shields.io/gittip/alexgorbatchev.svg)](https://www.gittip.com/alexgorbatchev/)
[![PayPayl donate button](http://img.shields.io/paypal/donate.png?color=yellow)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PSDPM9268P8RW "Donate once-off to this project using Paypal")

## Installation

    npm install webpack-angular-injector-plugin

## Usage Example

Write your angular functions like so:

    someModule.factory('greeter', ng(function($window) {
      // ...
    }));

Then add the following to your webpack config:

    var AngularInjectorPlugin = require('webpack-angular-injector-plugin');

    module.exports = {
      plugins: [
        new AngularInjectorPlugin({
          exclude: /fixture/
        })
      ]
    };

You don't need to declare `ng` function anywhere and it could be customized to anything. If you wanted to get fancy, use something like `ƒ` or `∑` to never have any naming conflicts. Or even an emoji if you feeling wild.

This syntax works particularly well in CoffeeScript and is literally 2-3 extra characters:

    someModule.factory 'greeter', ng ($window) ->
      # ...

## API

### AngularInjectorPlugin(opts)

* `opts.token` is a `String`, default value `ng`. Change it to any other token which suits your style best.
* `opts.exclude` is a `RegExp`. Any file name matching this regular expression will NOT be processed.

## How does it work?

Using the powers of [`esprima`](https://github.com/ariya/esprima) all function calls to `ng` are replaced with array injector notation and the list of dependencies is generated using function arguments. Because actual AST is used, there are no misses.

## Testing

    npm test

## License

The MIT License (MIT)

Copyright 2014 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.