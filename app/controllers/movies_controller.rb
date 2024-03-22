class MoviesController < ApplicationController
    def index
        if params[:search].present?
               @user = User.find(params[:user_id])

              conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
                faraday.params['api_key'] = Rails.application.credentials.themoviedb[:key]
              end

              response = conn.get("/3/search/movie", { query: params[:search] })
              data = JSON.parse(response.body, symbolize_names: true)
              @movies = data[:results]





              # require 'pry'; binding.pry
        else
            @user = User.find(params[:user_id])

            conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
                faraday.params['api_key'] = Rails.application.credentials.themoviedb[:key]
              end

              response = conn.get("/3/movie/top_rated")
              data = JSON.parse(response.body, symbolize_names: true)
              @movies = data[:results]


              # require 'pry'; binding.pry
        end
    end

    def show
      @user = User.find(params[:user_id])
      conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        faraday.params['api_key'] = Rails.application.credentials.themoviedb[:key]
      end
      id = params[:id].to_i

      response = conn.get("/3/movie/#{id}")
      @movie = JSON.parse(response.body, symbolize_names: true)
      
      response1 = conn.get("/3/movie/#{id}/credits")
      result = JSON.parse(response1.body, symbolize_names: true)
      @cast = result[:cast]

      response1 = conn.get("/3/movie/#{id}/reviews")
      result = JSON.parse(response1.body, symbolize_names: true)
      @authors = result[:results]
      @authors_count = result[:total_results]


      # require 'pry'; binding.pry
      
    end
end