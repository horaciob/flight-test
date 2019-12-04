# frozen_string_literal: true

class Server < Sinatra::Base
  get '/test/:id' do
    'test'
  end
end
