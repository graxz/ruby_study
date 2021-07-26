class MainController < ApplicationController
  require 'rest-client'
  require 'json'
  load 'pexels'

  def index
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      
      messages = File.read('./app/messages/messages.json')
      data_hash = JSON.parse(messages)

      client = Pexels::Client.new('563492ad6f91700001000001c3ccfe9f81f343b6973e97b11b3414bf')

      number_rand_cats = rand(0..1000)
      number_rand = rand(0..28)

      cats_fetch = client.photos.search('cats', per_page: 1, page: number_rand_cats)

      data = data_hash[number_rand]
      @message = data['msg']
      @author = data['author']

      @cats = []
      cats_fetch.each do |cat|
        @cats << cat.src
      end

    else
      redirect_to '/sign_in'
    end

  end
end