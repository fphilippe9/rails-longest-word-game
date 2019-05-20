
require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample}
  end

  def score
    @letters = params[:letters]
    @attempt = params[:attempt]
    if included?(@attempt, @letters)
      @answer = 'good'
      if english_word?(@attempt)
        @answer = 'good '
      else
        @answer = 'wrong'
      end
    else
      @answer = 'not included'
    end
  end

  def included?(attempt, letters)
    attempt.upcase.chars.all? do |letter|
      letters.include?(letter)
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end