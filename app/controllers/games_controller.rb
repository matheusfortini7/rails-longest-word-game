require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array('a'..'z').sample(10)
  end

  def score
    grid = params[:letters]
    guess = params[:word]
    if included?(guess, grid)
      if english_word?(guess)
        @message = 'Congratulations!'
      else
        @message = 'Not a english word'
      end
    else
      @message = 'Not includes'
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
