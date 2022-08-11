# frozen_string_literal: true

class HomesController < ApplicationController
  def show
    @ranking = Ranking.new.ranking
  end
end
