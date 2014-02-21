# jade-pages-brunch

Adds Jade static pages support to brunch.

This plugin compile Jade templates into their HTML representation and create separate file for each input source file without wrapping it in AMD/CommonJS modules.

## Usage

Install the plugin via npm with `npm install --save jade-pages-brunch`.

Or, do manual install:

* Add `"jade-pages-brunch": "x.y.z"` to `package.json` of your brunch app.
  Pick a plugin version that corresponds to your minor (y) brunch version.
* If you want to use git version of plugin, add
`"jade-pages-brunch": "git+https://github.com/Kagami/jade-pages-brunch.git"`.

## Brunch plugin settings

Plugin settings could be defined in the `plugins.jadePages` section of the brunch config. Defaults are:
```coffeescript
exports.config =
  ...
  plugins:
    jadePages:
      destination: (path) ->
        path.replace /^app[\/\\](.*)\.jade$/, "$1.html"
      jade:
        doctype: "html"
      htmlmin: false
```

### Pattern

You could compile only certian Jade pages by specifying `pattern` option. By default all files with `jade` extension are compiled.

Example:
```coffeescript
exports.config =
  ...
  plugins:
    jadePages:
      pattern: /^app\/pages\/.*\.jade$/
```

### Destination

You could specify custom place for compiled Jade pages via `destination` option. It should be *Function* which takes path of the source file and return destination file path *String* (relative to the public path). All intermediate directories in the path are created automatically.

By default all Jade pages in `app/` are compiled to `public/` with the same directory structure and have `html` extension.

### Jade options

You could specify Jade options and template locals in the `jade` and `jade.locals` sections accordingly. Example:
```coffeescript
exports.config =
  ...
  plugins:
    jadePages:
      jade:
        doctype: "xml"
        pretty: true
        locals:
          varname: "123"
```

Note that in optimize mode `pretty` option is always disabled.

### HTML minification

You could minify compiled templates using [html-minifier](https://github.com/kangax/html-minifier) by passing following values to the `htmlmin` section:

* Enable with default options with `true`. Default options are:
```coffeescript
removeComments: true
removeCommentsFromCDATA: true
removeCDATASectionsFromCDATA: true
collapseBooleanAttributes: true
useShortDoctype: true
removeEmptyAttributes: true
removeScriptTypeAttributes: true
removeStyleLinkTypeAttributes: true
```

* Specify custom options by passing *Object*; see options description [here](http://perfectionkills.com/experimenting-with-html-minifier/#options).

Note that by default HTML minification is disabled and could be enabled only for optimize mode. Also beware that minification especially with agressive options enabled could broke things.

Example:
```coffeescript
exports.config =
  ...
  plugins:
    jadePages:
      htmlmin:
        removeComments: true
        collapseWhitespace: true
        removeEmptyAttributes: true
```

## FAQ

### Why do you need yet another Jade plugin for Brunch?

Because neither [static-jade-brunch](https://github.com/ilkosta/static-jade-brunch) nor [jaded-brunch](https://github.com/monokrome/jaded-brunch) can properly work with another plugin which I use, [jade-ngtemplates-brunch](https://github.com/Kagami/jade-ngtemplates-brunch). For some reason static-jade and jaded always want to generate dynamic templates despite their purposes and enter into a conflict with each other.

Also I don't want to implement Jade pages functionality inside jade-ngtemplates-brunch (like it's done for example in [jade-angularjs-brunch](https://github.com/GulinSS/jade-angularjs-brunch)) because it's contradict with plugins modularity spirit.

### Then move htmlmin feature inside the separate optimizer plugin.

Unfortunately Brunch doesn't provide a lot of flexibility for plugins. From it's point of view templates are always compiled into single JS file so we need to hack it out and write resulting compiled pages by ourself. Since we did it, another plugin wouldn't make any sense.

In [this issue](https://github.com/brunch/brunch/issues/616) goes discussion about Brunch architecture improvements but no real progress is done for now.

## License

jade-pages-brunch - Adds Jade static pages support to brunch

Written in 2014 by Kagami Hiiragi <kagami@genshiken.org>

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
