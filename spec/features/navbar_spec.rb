require 'rails_helper'

describe 'NAV', type: 'feature' do
  describe 'login page' do
    before :each do
      @user = User.create(username: "kwebster", password: "password")
      @bangarangs = Group.create(title: "Bangarangs", group_slug: "bangarangs")
      @cats = Group.create(title: "Cats". group_slug: "cats")
      @group.group_creator_id = @user.id
      @user.groups << @group
    end


    it 'redirects to group path upon login' do
      visit login_path
      fill_in "user[username]", with: @user.username
      fill_in "user[password]", with: @user.password
      click_on("Login")
      expect(page).to have_content("Bangarangs")
    end
  end
end
