# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.?

Rails.application.config.assets.precompile += %w( sb-admin-2.css  custom.css)

Rails.application.config.assets.precompile += %w( sb-admin-2.js custom.js)

Rails.application.config.assets.precompile += %w( admin_devise.js admin_devise.css)

Rails.application.config.assets.precompile += %w( user_devise.js user_devise.css )

Rails.application.config.assets.precompile += %w( surface-fix.css surface-fix.js navbar.css site.css site.js)


Rails.application.config.assets.precompile += %w( oh_neyma.jpg )






