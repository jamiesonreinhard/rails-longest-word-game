require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      alphabet = ('A'..'Z').to_a
      index = rand(0..25)
      @letters << alphabet[index]
    end
    return @letters
  end

  def score
    @letters = params[:letters]
    @guess = params[:guess]
    if included?(@guess.upcase, @letters) && valid_english?(@guess)
      @message = "Congrats! Your word is valid. Your score is #{@guess.length * @guess.length}!"
    elsif included?(@guess.upcase, @letters) == false && valid_english?(@guess)
      @message = "Sorry, but #{@guess} can't be built from #{@letters}."
    elsif included?(@guess.upcase, @letters) && valid_english?(@guess) == false
      @message = "Sorry, but this is not a valid english word"
    else
      @message = "This is not valid english and can't be built from #{@letters}"
    end
    return @message
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def valid_english?(guess)
    attempt = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{guess}").read)
    return attempt["found"]
  end
end
