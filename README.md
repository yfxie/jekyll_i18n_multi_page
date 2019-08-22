# Jekyll I18n MultiPage

Generate multiple pages for different locales based on single template.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll_i18n_multi_page'
```

And then execute:

    $ bundle

Add the plugin to  `_config.yml` file:

```yml
plugins:
  - jekyll_i18n_multi_page
```

## Usage

Declare available locales in your website in `_config.yml`:

```yml
i18n:
  - path: /
    locale: en
  - path: /tw
    locale: zh-TW
``` 

For each entry must contain `path`(the output of localized page) and `locale`.

Define files with localized contents in `_i18n` folder, filenames aren't mattered. For examples:

```yml
# _i18n/my-en-site.yml
en:
  index:
    title: English title
    hello: Hello
```

```yml
# _i18n/my-tw-site.yml
zh-TW:
  index:
    title: 中文標題
    hello: 哈囉
```

`page.i18n` is the way to access the current localized contents, said you have a HTML named `index.html` with content as the following:
```html
---
---
{{ page.i18n.hello }}
```

After building of Jekyll, the dist folder should have two files `index.html` and `tw/index.html`

Assume you have a file named `some/where/my.html` you should have its path in the localization file:
```yml
# _i18n/my-en-site.yml
en:
  some:
    where:
      my:
        hello: Hello # access this text via page.i18n.hello
```

## Use cases

**For some reason, I have a page which is only available for certain locales**

```html
---
i18n_locales: ['zh-TW']
---
{{ page.i18n.hello }}
```
Using `i18n_locales` to declare the support locales. Then Jekyll will build `tw/index.html` file only.

**How to disable the features on certain pages**

```html
---
i18n_disabled: true
---
```
Using `i18n_disabled` to tell the plugin do not do anything for me.

**Translate helper**

```
{% t index.hello %}
```
`t` tag provides a way to translate content. When you take this way, you must write a full path.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yfxie/jekyll_i18n_multi_page. 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
