module JekyllI18nMultiPage
  class TranslateTag < Liquid::Tag
    attr_accessor :markup

    def initialize(tag_name, translate_path, tokens)
      super
      @translate_path = translate_path.strip
    end

    def render(context)
      I18n.t(@translate_path, locale: context['page']['i18n_locale'])
    end
  end
end