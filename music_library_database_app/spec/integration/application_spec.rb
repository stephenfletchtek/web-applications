require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "POST /albums" do
    it 'returns 200 OK' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')
      expect(response.status).to eq(200)
      repo = AlbumRepository.new
      latest_album = repo.all[-1]
      expect(latest_album.title).to eq('Voyage')
      expect(latest_album.release_year).to eq('2022')
      expect(latest_album.artist_id).to eq(2)
    end
  end
end
