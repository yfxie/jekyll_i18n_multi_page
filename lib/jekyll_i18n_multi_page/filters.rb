module JekyllI18nMultiPage
  module Filters
    def i18n(path)
      result = I18n.t(path, locale: @context['page']['i18n_locale'])
      { result: result }.with_indifferent_access[:result]
    end
  end
end

