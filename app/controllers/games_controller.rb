require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = ('A'..'Z').to_a.sample(10)
    @start_time = Time.now
  end

  def score
    @score = 0
    @word = params[:word].upcase
    start_time = params[:start_time].to_f
    grid = params[:grid].split('')
    @time = (Time.now.to_f - start_time).round(2)
    in_grid = true
    @word.chars.each do |char|
      if grid.include?(char)
        grid.delete_at(grid.find_index(char))
      else
        in_grid = false
      end
    end
    @message = in_grid ? 'Congrats!' : 'Use the letters in the grid :('
    if in_grid
      json = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      word_data = JSON.parse(json)
      if word_data['found']
        @score = (word_data['length'] + 10 / @time).round(2)
      else
        @message = 'Not an english word'
      end
    end
  end
end
