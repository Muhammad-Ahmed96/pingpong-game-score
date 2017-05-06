require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  context 'when creating a game game' do
    let(:opponent) { FactoryGirl.create(:user) }
    let(:date_played) { Faker::Date.between(2.days.ago, Date.today) }
    let(:game_attr) { FactoryGirl.attributes_for(:game) }

    subject :log_game do
      post :log_game, game_attr.merge(opponent: opponent)
    end

  end
end
