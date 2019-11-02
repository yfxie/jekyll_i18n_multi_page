RSpec.describe JekyllI18nMultiPage do
  let(:site) {
    Jekyll::Site.new(Jekyll.configuration({ source: test_dir('example'), destination: dist }))
  }

  before do
    FileUtils.remove_dir(dist) if File.directory?(dist)
    site.process
  end

  it "has a version number" do
    expect(JekyllI18nMultiPage::VERSION).not_to be nil
  end

  describe 'index.html' do
    it 'generates multiple pages by default' do
      expect(File.exist?(dist('index.html'))).to be(true)
      expect(File.exist?(dist('tw/index.html'))).to be(true)
      expect(File.exist?(dist('tw/en/index.html'))).to be(true)
    end

    it 'replaces page.i18n_locale with correct locale' do
      expect(File.read(dist('index.html'))).to include('en')
      expect(File.read(dist('tw/index.html'))).to include('zh-TW')
      expect(File.read(dist('tw/en/index.html'))).to include('en-TW')
    end

    it 'renders the corresponding i18n text' do
      expect(File.read(dist('index.html'))).to include('Hello')
      expect(File.read(dist('index.html'))).to include('English title - en site')
      expect(File.read(dist('tw/index.html'))).to include('哈囉')
      expect(File.read(dist('tw/index.html'))).to include('中文標題 - tw site')
      expect(File.read(dist('tw/en/index.html'))).to include('Hello')
      expect(File.read(dist('tw/en/index.html'))).to include('English title - en-tw site')
    end
  end

  describe 'single-locale-page.html which specify i18n_locales with single locale' do
    it 'generates single page' do
      expect(File.exist?(dist('single-locale-page.html'))).to be(false)
      expect(File.exist?(dist('tw/single-locale-page.html'))).to be(true)
      expect(File.exist?(dist('tw/en/single-locale-page.html'))).to be(false)
    end
  end

  describe 'i18n_disabled.html which specify i18n_disabled' do
    it 'generates single page' do
      expect(File.exist?(dist('i18n-disabled.html'))).to be(true)
      expect(File.exist?(dist('tw/i18n-disabled.html'))).to be(false)
      expect(File.exist?(dist('tw/en/i18n-disabled.html'))).to be(false)
    end
  end

  describe 't tag' do
    it 'renders the corresponding i18n text' do
      expect(File.read(dist('t-tag.html'))).to include('Hello')
      expect(File.read(dist('tw/t-tag.html'))).to include('哈囉')
      expect(File.read(dist('tw/en/t-tag.html'))).to include('Hello')
    end
  end

  describe 'i18n global variable' do
    it 'can access the root from i18n global variables' do
      content = File.read(dist('i18n-global-variable.html'))
      expect(content).to include('item1')
      expect(content).to include('item2')
      expect(content).to include('item3')
    end
  end
end
