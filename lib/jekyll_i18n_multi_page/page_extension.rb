module JekyllI18nMultiPage
  module PageExtension
    def translate_key
      path.gsub('/','.')
        .gsub(/\.(html|md)$/,'')
    end

    def i18n_disabled
      data['i18n_disabled']
    end

    def template
      return super if i18n_disabled
      "/:i18n_path#{super}"
    end

    def url_placeholders
      return super if i18n_disabled
      super.merge({ i18n_path: data['i18n_path'] })
    end
  end
end