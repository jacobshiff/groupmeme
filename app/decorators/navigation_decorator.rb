class NavigationDecorator < SimpleDelegator
  include ActionView::Helpers::UrlHelper

  attr_accessor :group, :user

  def initialize(group, user)
    @group = group
    @user = user
  end

  def group_title_link
    if group
      h.link_to group_url do
      "<p class='brand-text'>#{group.title}</p>".html_safe
      end
    end
  end

  def display_user_info
    if user
      user_info = <<-USER_INFO
      <div id='nav-user-block'><img src='#{user.avatar}' class='navbar-avatar'>
      <h5 class="nav-user-text">#{user.username}</h5>
      USER_INFO
      user_info.html_safe
    end
  end

  def admin_links
    if user && user.type(group) == "admin"
      h.link_to 'Edit Group', edit_group_url
      h.link_to 'Invite New User', invite_new_url
      h.link_to 'View and Edit Members', edit_users_url
    end
  end



  private
  def h #a la Draper
    ActionController::Base.helpers
  end

  def group_url
    Rails.application.routes.url_helpers.group_path(group.group_slug)
  end

  def edit_group_url
    Rails.application.routes.url_helpers.edit_group_path(group.group_slug)
  end

  def invite_new_url
    Rails.application.routes.url_helpers.invite_new_path(group.group_slug)
  end

  def edit_users_url
    Rails.application.routes.url_helpers.edit_users_path(group.group_slug)
  end

end

# <!-- Conditional links -->
#
#    <li><%= (button_to "Add A New Meme", new_meme_path(current_group.group_slug), method: :get, class: 'btn btn-large btn-primary') if current_group%></li>
#   <li><a href="/users/<%= current_user.username %>">Profile</a></li>
#   <li><a href="/groups">Your Groups</a></li>
#   <% if current_user && current_group %>
#     <!-- Add a new meme button - maybe move -->
#     <% if current_user.type(current_group) == "admin" %>
#     <li><%= link_to 'Edit Group', edit_group_path(current_group.group_slug) %></li>
#     <li><%= link_to 'Invite New User', invite_new_path(current_group.group_slug) %></li>
#     <li><%= link_to 'View and Edit Members', edit_users_path(current_group.group_slug) %></li>
#     <% end %>
#     <li><%= link_to "Sign Out", logout_path, method: :delete %></li>
#   <% end %>
# <% end %>
# <% if !current_user %>
#     <li><%= button_to "Sign Up", registration_new_path, class: 'btn btn-light', method: 'get', style: "width:80%; margin-top:5px;" %></li>
# <% end %>


# <!-- <% if current_group %>
#   <%= link_to group_path(current_group.group_slug) do %>
#   <p class="brand-text"><%= current_group.title %></p>
#   <% end %>
# <% end %> -->
#
# <!-- Conditional links -->
# <!-- <% if current_user %>
#   <li>
#     <div id="nav-user-block">
#      <img src="<%= current_user.avatar %>" class="navbar-avatar">
#       <h5 class="nav-user-text"><%= current_user.username %></h5>
#     </div>
#  </li>
#    <li><%= (button_to "Add A New Meme", new_meme_path(current_group.group_slug), method: :get, class: 'btn btn-large btn-primary') if current_group%></li>
#   <li><a href="/users/<%= current_user.username %>">Profile</a></li>
#   <li><a href="/groups">Your Groups</a></li>
#   <% if current_user && current_group %>
#     Add a new meme button - maybe move
#     <% if current_user.type(current_group) == "admin" %>
#     <li><%= link_to 'Edit Group', edit_group_path(current_group.group_slug) %></li>
#     <li><%= link_to 'Invite New User', invite_new_path(current_group.group_slug) %></li>
#     <li><%= link_to 'View and Edit Members', edit_users_path(current_group.group_slug) %></li>
#     <% end %>
#     <li><%= link_to "Sign Out", logout_path, method: :delete %></li>
#   <% end %>
# <% end %>
# <% if !current_user %>
#     <li><%= button_to "Sign Up", registration_new_path, class: 'btn btn-light', method: 'get', style: "width:80%; margin-top:5px;" %></li>
# <% end %> -->
