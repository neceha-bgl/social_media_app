module ApplicationHelper
  def icon_tag(name,icon)
    content_tag(:i,nil,class: icon) + " #{name}" 
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def admin_omniauth_account_path omniauth_account
    if current_user.has_role? :admin
      omniauth_account_path(omniauth_account.id)
    else
      account_path(omniauth_account.provider)
    end
  end

end
