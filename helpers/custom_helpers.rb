# ====================================
#   Custom Helpers
# ====================================

module CustomHelpers

  def page_title(separator = '-')
    if current_page.data.title
      "#{ current_page.data.title } #{ separator } #{ data.config.title }"
    else
      data.config.title
    end
  end

  def page_description
    current_page.data.description ? current_page.data.description : data.config.description
  end

end
