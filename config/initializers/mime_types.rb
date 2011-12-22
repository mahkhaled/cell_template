# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone


module ActionView::Helpers::JavaScriptHelper
  def escape_javascript_with_workaround(javascript)
    escape_javascript_without_workaround(javascript.try(:to_str)).html_safe
  end

  alias_method_chain :escape_javascript, :workaround
end