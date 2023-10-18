# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.?

Rails.application.config.assets.precompile += %w( nunito.css font-awesome.css sb-admin-2.css )

Rails.application.config.assets.precompile += %w( bootstrap.js jquery.easing.min.js jquery.min.js sb-admin-min-2.js )

Rails.application.config.assets.precompile += %w( custom.min.css bootstrap.min.css nprogress.css jqueryCustomScrollbar.css font-awesome.min.css )

Rails.application.config.assets.precompile += %w( jquery.js fastclick.js custom.min.js bootstrap.bundle.min.js nprogress.js jqueryCustomScrollbar.js )

