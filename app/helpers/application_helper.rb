module ApplicationHelper
  def sortable(column, title = nil)
    column = column.to_s.downcase
    
    title ||= t("#{model_name}.#{column}")
    
    title = title.titleize unless I18n.locale == :ar
    
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  def title(text)
    raw "<h1>#{text}</h1>"
  end
  
  def model_name
    controller_name.gsub(/_controller$/, "").underscore.singularize
  end
  
  def filter_header
    "<p class='filter'>#{t("standard.advanced_search")}</p>".html_safe
  end
  
  def remote_flash(obj=nil)
    if @flash_notice
      "<div class='flash notice'>#{@flash_notice}</div>".html_safe
    end
  end
end

module WillPaginate::I18nViewHelpers
  def will_paginate(collection, options = {}) 
    super(collection, options.merge(:previous_label => I18n.t('will_paginate.previous'), :next_label => I18n.t('will_paginate.next'))) 
  end
end

ActionView::Base.send :include, WillPaginate::I18nViewHelpers