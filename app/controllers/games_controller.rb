require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    # The word can’t be built out of the original grid
    @word = params[:word].split('')
    check = params[:letters].split

    @word.each do |char|
      if check.include?(char.upcase)
        check.reject { |letter| letter == char.upcase }
      else
        @message = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
      end
    end
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)

    if json['found'] == true
      @message = "Congratulations! #{params[:word]} is a valid English word!"
    else
      @message = "Sorry but #{params[:word]} does not seem to be a valid English word"
    end
  end
end
