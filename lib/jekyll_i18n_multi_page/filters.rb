module JekyllI18nMultiPage
  module Filters
    def i18n(path)
      I18n.t(path, locale: @context['page']['i18n_locale'])
    end
  end
end

