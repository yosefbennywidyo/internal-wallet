# Usually, especially when using Selenium, developers tend to increase the max wait time.
# With Cuprite, there is no need for that.
# We use a Capybara default value here explicitly.
Capybara.default_max_wait_time = 2

# Normalize whitespaces when using `has_text?` and similar matchers,
# i.e., ignore newlines, trailing spaces, etc.
# That makes tests less dependent on slightly UI changes.
Capybara.default_normalize_ws = true

# Where to store system tests artifacts (e.g. screenshots, downloaded files, etc.).
# It could be useful to be able to configure this path from the outside (e.g., on CI).
Capybara.save_path = ENV.fetch("CAPYBARA_ARTIFACTS", "./tmp/capybara")

Capybara.singleton_class.prepend(Module.new do
  attr_accessor :last_used_session

  def using_session(name, &block)
    self.last_used_session = name
    super
  ensure
    self.last_used_session = nil
  end
end)

Capybara.threadsafe = true

Capybara.register_driver :chrome_headless do |app|
  chrome_capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome('goog:chromeOptions' => { 'args': %w[no-sandbox headless disable-gpu window-size=1400,1400] })

  if ENV['HUB_URL']
    Capybara::Selenium::Driver.new(app,
                                   browser: :remote,
                                   url: ENV['HUB_URL'],
                                   capabilities: chrome_capabilities)
  else
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   capabilities: chrome_capabilities)
  end
end
