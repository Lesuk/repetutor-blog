# ====================================
#   Custom Helpers
# ====================================

module CustomHelpers

  def page_title(separator = '|')
    if current_page.data.title
      "#{ current_page.data.title } #{ separator } #{ data.site.title }"
    else
      data.site.title
    end
  end

  def page_description
    current_page.data.description ? current_page.data.description : data.site.description
  end

  def is_page_active?(page)
    current_page.url.include?(page)
  end

  def active_link(page)
    is_page_active?(page) ? 'is-active' : ''
  end

  def format_date(date)
    date.strftime('%B %d, %Y')
  end

  def current_page_url
    "#{data.site.url}#{current_page.url}"
  end

  def page_url(page)
    "#{data.site.url}#{page.url}"
  end

  def page_twitter_card_type
    current_page.data.twitter_card_type || 'summary'
  end

  def page_image
    current_page.data.image_path || image_path('Mortar-Board_main.png')
  end

  def review_rating_percent(rating)
    (100 / 5) * rating
  end
end
