require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WdylNew
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja

    # 複数のロケールファイルが読み込まれるようになる
    # i18nをgemでinstallしてから
    # ここで設定することで、config/locales/**/*.ymlで書いたものが反映される
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

  end
end
