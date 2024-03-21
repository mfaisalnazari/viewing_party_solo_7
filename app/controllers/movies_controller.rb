class MoviesController < ApplicationController
    def index
        if params[:search].present?
              
              conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
                faraday.params['api_key'] = Rails.application.credentials.themoviedb[:key]
              end

              response = conn.get("/3/discover/movie")
              data = JSON.parse(response.body, symbolize_names: true)
              movies1 = data[:results]
              @movies = movies1.find_all {|m| m[:title] == params[:search]}

            #   require 'pry'; binding.pry
        else
            conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
                faraday.params['api_key'] = Rails.application.credentials.themoviedb[:key]
              end

              response = conn.get("/3/movie/top_rated")
              data = JSON.parse(response.body, symbolize_names: true)
              @movies = data[:results]


            #   require 'pry'; binding.pry
        end
    end
end