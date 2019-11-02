require 'jekyll'
require 'i18n'
require 'active_support/core_ext/hash'
require 'jekyll_i18n_multi_page/version'
require 'jekyll_i18n_multi_page/page_extension'
require 'jekyll_i18n_multi_page/translate_tag'

module JekyllI18nMultiPage; end


Jekyll::Page.class_eval do
  prepend JekyllI18nMultiPage::PageExtension
end


Jekyll::Hooks.register :site, :after_init do |site|
  I18n.load_path << Dir[File.join(site.config['source'], '_i18n', '**/*.{yml,yaml}')]
end

Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  if page.i18n_locale
    result = I18n.t('.', locale: page.i18n_locale)
    payload['i18n'] = { result: result }.with_indifferent_access[:result]
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  config = site.config['i18n']
  return unless config

  I18n.reload!

  locale_config_mappings = config.reduce({}) do |map, config|
    map[config['locale']] = config
    map
  end

  site.pages = site.pages.flat_map do |page|
    next page if page.i18n_disabled

    locales = page.data['i18n_locales'] || locale_config_mappings.keys
    locales.map do |locale|
      config = locale_config_mappings[locale]
      i18n_hash = I18n.t(page.translate_key, locale: locale)
      data = page.data.clone.tap do |data|
        data['i18n_locale'] = locale
        data['i18n'] = i18n_hash.is_a?(Hash) ? i18n_hash.with_indifferent_access : {}
        data['i18n_path'] = config['path']
      end
      page.clone.tap do |p|
        p.data = data
      end
    end
  end
end

Liquid::Template.register_tag('t', JekyllI18nMultiPage::TranslateTag)