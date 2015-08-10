# ====================================
#   Custom Helpers
# ====================================

module CustomHelpers

  def title(title)
    @page_title = title
  end

  def page_title(separator = '|')
    if current_page.data.title
      "#{ current_page.data.title } #{ separator } #{ data.site.title }"
    elsif @page_title
      "#{ @page_title } #{ separator } #{ data.site.title }"
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
    # date.strftime('%B %d, %Y')
    I18n.localize(date, :format => "%B %d, %Y")
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

  def build_categories(articles)
    categories = []
    articles.each do |article|
      category = article.metadata[:page]['category']
      categories.push(category) unless categories.include? category
    end
    categories
  end

  def featured_articles(all_articles, current_article, size)
    featured_articles = all_articles.select{ |i| i.metadata[:page]["featured"] rescue false }
    featured_articles.delete_if{ |i| i == current_article }
    featured_articles.first(size)
  end

  def category_name(category_slug)
    data.categories[category_slug]['name']
  end

  def article_category_slug(article)
    article.data.category.present? ? article.data.category.to_s : 'unknown'
  end

  def article_category_name(article)
    category_name(article_category_slug(article))
  end

  def author_name(author_slug)
    data.authors[author_slug]['name']
  end

  def article_author_slug(article)
    article.data.author.present? ? article.data.author.to_s : 'unknown'
  end

  def article_author_name(article)
    author_name(article_author_slug(article))
  end

  def article_author_img(article)
    data.authors[article_author_slug(article)]['img_path']
  end

  def article_author_descr(article)
    data.authors[article_author_slug(article)]['description']
  end
end
