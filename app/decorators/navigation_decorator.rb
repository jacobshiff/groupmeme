class NavigationDecorator < SimpleDelegator
  include ActionView::Helpers::UrlHelper

  attr_accessor :group, :user

  def initialize(group, user)
    @group = group
    @user = user
  end

  def navbar
    if user
      navbar = <<-NAVBAR
        <li class="title">Menu</li><li>#{display_user_info}</li><li>#{profile_link}</li><li>#{groups_link}</li>#{admin_links}<li>#{sign_out}</li>
        NAVBAR
    navbar.html_safe
    end
  end

  def group_title_link
    h.link_to group_url do
    "<p class='brand-text'>#{group.title}</p>".html_safe
    end
  end

  def display_user_info
    user_info = <<-USER_INFO
      <div id='nav-user-block'><img src='#{user.avatar}' class='navbar-avatar'>
      <h5 class="nav-user-text">#{user.username}</h5>
      USER_INFO
    user_info.html_safe
  end

  def profile_link
    "<a href='/users/#{user.username}'>Profile</a>".html_safe
  end

  def groups_link
    "<a href='/groups'>Your Groups</a>".html_safe
  end

  def admin_links
    if user.type(group) == "admin"
      admin_links = <<-ADMIN_LINKS
      <li>#{h.link_to 'Edit Group', edit_group_url}</li><li>#{h.link_to 'Invite New User', invite_new_url}</li><li>#{h.link_to 'View and Edit Members', edit_users_url}</li>
      ADMIN_LINKS
      admin_links.html_safe
    end
  end

  def sign_out
    "#{h.link_to 'Sign Out', logout_url, method: :delete}".html_safe
  end

  private
  def h #a la Draper
    ActionController::Base.helpers
  end

  def group_url
    Rails.application.routes.url_helpers.group_path(group.group_slug) if group
  end

  def edit_group_url
    Rails.application.routes.url_helpers.edit_group_path(group.group_slug) if group
  end

  def invite_new_url
    Rails.application.routes.url_helpers.invite_new_path(group.group_slug) if group
  end

  def edit_users_url
    Rails.application.routes.url_helpers.edit_users_path(group.group_slug) if group
  end

  def logout_url
    Rails.application.routes.url_helpers.logout_path if user
  end

  def registration_new_url
    Rails.application.routes.url_helpers.registration_new_path unless user
  end
end
