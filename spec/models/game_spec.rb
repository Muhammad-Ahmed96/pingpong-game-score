# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  player_1_id    :integer
#  player_2_id    :integer
#  player_1_score :integer
#  player_2_score :integer
#  date_played    :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:player_1_score) { 21 }
  let(:player_2_score) { 12 }
  let(:winner) { FactoryGirl.create(:user) }
  let(:loser) { FactoryGirl.create(:user) }

  subject(:game) do
    FactoryGirl.build :game, {
      player_1: winner,
      player_2: loser,
      player_1_score: player_1_score,
      player_2_score: player_2_score
    }
  end

  context 'when creating a game the player 1 wins' do
    let(:initial_ranking) { 1000 }

    before do
      subject.save
    end

    it 'increases the ranking of the winner' do
      expect(winner.ranking).to be > initial_ranking
    end

    it 'decreases the ranking of the loser' do
      expect(loser.ranking).to be < initial_ranking
    end
  end

  context 'when creating a game the player 2 wins' do
    let(:player_2_score) { 23 }

    it 'has the correct winner' do
      expect(game.player_1_score > game.player_2_score ? game.player_1 : game.player_2).to be game.player_2
    end
  end

  context 'when creating a game with the score less than 21' do
    let(:player_1_score) { 10 }
    let(:player_2_score) { 11 }

    it 'is not valid' do
      expect(game).not_to be_valid
    end
  end

  context 'when creating a game with the score max 21' do
    let(:player_1_score) { 12 }
    let(:player_2_score) { 25 }

    it 'is not valid' do
      expect(game).not_to be_valid
    end
  end

  context 'when creating a game with the both scores are greater than 21' do
    let(:player_1_score) { 56 }
    let(:player_2_score) { 57 }

    it 'is not valid' do
      expect(game).not_to be_valid
    end

    context 'when th difference is exactly 2' do
      let(:player_2_score) { 58 }

      it 'is valid' do
        expect(game).to be_valid
      end
    end
  end
end
