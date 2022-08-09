require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  context "GET to /hello" do
    it "returns 200 and the content" do
      # response = get('/hello?name=Julia, Mary, Karim')
      response = get('/hello', name: 'Julia, Mary, Karim')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello Julia, Mary, Karim!</h1>')
    end
  end

  context "POST to /sort_names" do
    it "returns 200 and the content with single name" do
      response = post('/sort-names?names=Alice')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice')
    end

    it "returns 200 and the content with two names" do
      response = post('sort-names?names=Alice,Zoe')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice,Zoe') 
    end

    it "returns 200 and sorted list of names" do
      response = post('sort-names?names=Joe,Alice,Zoe,Julia,Kieran')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice,Joe,Julia,Kieran,Zoe')
    end
  end
end