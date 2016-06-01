require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:connie) {User.create(username: 'Connie', password: "M4heswaran")}

  describe 'post create' do
    it 'logs you in with the correct password' do
      post :create, user: {username: connie.username, password: connie.password}
      expect(session[:user_id]).to eq(connie.id)
    end

    it 'rejects invalid passwords' do
      post :create, user: {username: connie.username, password: connie.password + 'x'}
      expect(session[:user_id]).to be_nil
    end

















  end #END describe
end #END SessionsController
