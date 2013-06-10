module OmniauthAccountsHelper
  def hero_unit(options = {}, escape = true, &block)
    data = {title: "", image: "", link: ""}
    default_options = {class: "hero-unit"}
    profile = options.delete(:profile)
    block.call(data, profile)
    content_tag :div, nil, options.merge(default_options), escape do
      content_tag(:h1, data[:title]) +
      content_tag(:p, nil) do
        content_tag(:a, href: data[:link]) do
          raw(tag(:img, src: data[:image]))
        end +
        data[:description]
      end +
      content_tag(:p, nil) do
        content_tag(:a, icon_tag("Visit","icon-circle-arrow-right icon-white"), href: data[:link], class: "btn btn-primary btn-large pull-left") +
        content_tag(:a, icon_tag("Refresh","icon-refresh icon-white"), href: "#{data[:refresh_link]}?refresh=true", class: "btn btn-primary btn-large pull-right")
      end
    end
  end

end
