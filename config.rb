require 'breakpoint'
require 'extensions/sitemap.rb'
require 'dotenv'
Slim::Engine.disable_option_validator!

Time.zone = 'Europe/Kiev'

# ====================================
#   Compass
# ====================================

compass_config do |config|
  config.output_style = :compact
  config.line_comments = false
end

# ====================================
#   Activate Plugins
# ====================================

activate :blog do |blog|
  # blog.prefix = "blog"
  blog.permalink = "{category_slug}/{slug}"
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "article_layout"
  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 4
  blog.page_link = "page/{num}"

  blog.custom_collections = {
    category: {
      link: '/categories/{category}.html',
      template: 'category.html'
    },
    author: {
      link: '/authors/{author}.html',
      template: 'author.html'
    }
  }
end

# activate :automatic_image_sizes
activate :directory_indexes
activate :livereload, :host => "127.0.0.1"
activate :sitemap_generator
activate :i18n, :langs => [:uk]

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 10']
  config.cascade = false
end

# ====================================
#   Global Variables
# ====================================

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'
set :slim, pretty: true

set :disabled_files_in_sitemap, ['sitemap.html', '404.html']

# require 'kramdown'
# set :markdown_engine, :kramdown
# set :md, :layout_engine => :erb, :auto_ids => false

# ====================================
#   Pages
# ====================================

page '/feed.xml', layout: false
page '/sitemap.html', layout: false
page '/sitemap.xml', layout: false
page '/robots.txt', layout: false
page '/humans.txt', layout: false
page "/404.html" #, :directory_index => false
page "/articles/*", :layout => :article_layout


# ====================================
#   After Configuration
# ====================================

after_configuration do
  @bower_config = JSON.parse( IO.read( "#{ root }/.bowerrc" ) )
  sprockets.append_path File.join root.to_s, @bower_config['directory']
end

# ====================================
#   Build Configuration
# ====================================

configure :build do
  # activate :cache_buster
  activate :asset_hash
  activate :minify_css
  activate :minify_html
  activate :minify_javascript
  activate :relative_assets

  # Compress and optimize images
  activate :imageoptim

  activate :gzip

  activate :favicon_maker do |f|
    f.template_dir = File.join(root, 'source/assets/images')
    f.icons = {
      "_favicon_template.png" => [
        { icon: "apple-touch-icon-152x152-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
        { icon: "apple-touch-icon-144x144-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
        { icon: "apple-touch-icon-120x120-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
        { icon: "apple-touch-icon-114x114-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
        { icon: "apple-touch-icon-76x76-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
        { icon: "apple-touch-icon-72x72-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
        { icon: "apple-touch-icon-60x60-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
        { icon: "apple-touch-icon-57x57-precomposed.png" },               # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
        { icon: "apple-touch-icon-precomposed.png", size: "57x57" },      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
        { icon: "apple-touch-icon.png", size: "57x57" },                  # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
        { icon: "favicon-196x196.png" },                                  # For Android Chrome M31+.
        { icon: "favicon-160x160.png" },                                  # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
        { icon: "favicon-96x96.png" },                                    # For Google TV.
        { icon: "favicon-32x32.png" },                                    # For Safari on Mac OS.
        { icon: "favicon-16x16.png" },                                    # The classic favicon, displayed in the tabs.
        { icon: "favicon.png", size: "16x16" },                           # The classic favicon, displayed in the tabs.
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },         # Used by IE, and also by some other browsers if we are not careful.
        { icon: "mstile-70x70.png", size: "70x70" },                      # For Windows 8 / IE11.
        { icon: "mstile-144x144.png", size: "144x144" },
        { icon: "mstile-150x150.png", size: "150x150" },
        { icon: "mstile-310x310.png", size: "310x310" },
        { icon: "mstile-310x150.png", size: "310x150" }
      ]
    }
  end
end

activate :deploy do |deploy|
  deploy.method   = :ftp
  deploy.host     = ENV['FTP_HOST']
  deploy.path     = ENV['FTP_PATH']
  deploy.user     = ENV['FTP_USER']
  deploy.password = ENV['FTP_PASS']
end
