module OmniauthAccountsHelper

  def nav(options = {}, escape = true, &block)
    default_options = {id: :myTab, class: "nav nav-tabs"}
    elements = options.delete(:elements)
    active = :active
    content_tag :ul, nil, options.merge(default_options), escape  do
      raw(elements.map { |e|
        content_tag(:li, class: active) do 
          active = ""
          content_tag :a, e.last, "data-toggle".to_sym => "tab", href: "##{e.first}"
        end
      }.join(""))
    end
  end

  def tab_pane_profile(options = {}, escape = true, &block)
    default_options = {name: "Profile", id: :profile, class: "tab-pane fade active in"}
    elements = options.delete(:elements)
    name = options.delete(:name)
    content_tag :div, nil, options.merge(default_options), escape  do
      content_tag(:div, nil, class: "row") do
        content_tag(:h2, name) +
        content_tag(:dl, nil, class: "dl-horizontal") do
          raw(elements.map { |e|
            content_tag(:dt, e.first) + content_tag(:dd, e.last) 
          }.join(""))
        end
      end
    end
  end

  def tab_pane(options = {}, escape = true, &block)
    data = {title: "", image: "", link: ""}
    default_options = {class: "tab-pane fade"}
    elements = options.delete(:elements)
    name = options.delete(:name)
    content_tag :div, nil, options.merge(default_options), escape  do
      content_tag(:div, nil, class: "row-") do
        content_tag(:h2, name) +
        content_tag(:ul, nil, class: "thumbnails") do
          raw(elements.map { |element|
            block.call(data, element)
            content_tag(:li, nil, class: "span3") do
              content_tag(:div, nil, class: "thumbnail text-center") do
                content_tag(:div, nil, class: "caption") do
                  content_tag(:a, href: data[:link], class: "text-center" ) do
                    raw(tag(:img, src: data[:image]))
                  end +
                  content_tag(:h5, data[:title])  +
                  content_tag(:p,raw(data[:description]))+
                  content_tag(:p, nil ) do
                    content_tag(:a, "Visit", href: data[:link], class: "btn btn-primary") +
                    content_tag(:a, "Action", href: "#", class: "btn")
                  end
                end
              end
            end
          }.join(""))
        end
      end
    end
  end

  def tab_content(options = {}, escape = true, &block)
    default_options = {id: :myTabContent, class: "tab-content"}
    content_tag :div, nil, options.merge(default_options), escape, &block
  end

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
