## jade-pages-brunch

Adds Jade static pages support to brunch.

## Usage

Install the plugin via npm with `npm install --save jade-pages-brunch`.

Or, do manual install:

* Add `"jade-pages-brunch": "x.y.z"` to `package.json` of your brunch app.
  Pick a plugin version that corresponds to your minor (y) brunch version.
* If you want to use git version of plugin, add
`"jade-pages-brunch": "git+https://github.com/Kagami/jade-pages-brunch.git"`.

### Brunch plugin settings

TODO

## FAQ

### Why do you need yet another Jade plugin for Brunch?

Because neither [static-jade-brunch](https://github.com/ilkosta/static-jade-brunch) nor [jaded-brunch](https://github.com/monokrome/jaded-brunch) can properly work with another plugin which I use, [jade-ngtemplates-brunch](https://github.com/Kagami/jade-ngtemplates-brunch). For some reason static-jade and jaded always wan't to generate dynamic templates despite their purposes and enter into a conflict with each other.

Also I don't want to implement Jade pages functionality inside jade-ngtemplates-brunch (like it's done for example in [jade-angularjs-brunch](https://github.com/GulinSS/jade-angularjs-brunch)) because it's contradict with plugins modularity spirit.

## Then move htmlmin feature inside the separate optimizer plugin.

Unfortunately Brunch doesn't provide a lot of flexibility for plugins. From it's point of view templates are always compiled into single JS file so we need to hack it out and write resulting compiled pages by ourself. Since we made it, another plugin wouldn't do any sense.

In [this issue](https://github.com/brunch/brunch/issues/616) goes discussion about Brunch architecture improvements but no real progress is done for now.

## License

jade-pages-brunch - Adds Jade static pages support to brunch

Written in 2014 by Kagami Hiiragi <kagami@genshiken.org>

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
