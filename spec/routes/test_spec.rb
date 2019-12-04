# frozen_string_literal: true

require_relative '../spec_helper'

describe Server do
  it '' do
    get '/test/1'
    expect(last_response).to be_ok
  end

  it '' do
    get '/test/1'
    expect(last_response.body).to eq 'test'
  end
end
