require 'bundler/setup'
require 'action_widget'

class ActionWidget::Base
  def content_tag(*args, **options, &block)
    options[:class] &&=
      case classes = options[:class]
      when Array
        classes.flatten.compact.join(" ")
      else
        classes
      end

    view.content_tag(*args, **options, &block)
  end
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, host: '0.0.0.0'
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

activate :action_widget, path: File.expand_path('../lib', __FILE__)

activate :deploy do |config|
  config.method = :git
end
