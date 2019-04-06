require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #home" do

    it "正しくページが表示される" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
