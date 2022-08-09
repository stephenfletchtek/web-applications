require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_albums_table
  end
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "gets all albums and displays in html" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include("      <div>\n        Title: Doolittle\n        Released: 1989\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Surfer Rosa\n        Released: 1988\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Waterloo\n        Released: 1974\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Super Trouper\n        Released: 1980\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Bossanova\n        Released: 1990\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Lover\n        Released: 2019\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Folklore\n        Released: 2020\n      </div>")
      expect(response.body).to include("      <div>\n        Title: I Put a Spell on You\n        Released: 1965\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Baltimore\n        Released: 1978\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Here Comes the Sun\n        Released: 1971\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Fodder on My Wings\n        Released: 1982\n      </div>")
      expect(response.body).to include("      <div>\n        Title: Ring Ring\n        Released: 1973\n      </div>")
    end
  end

  context "GET /albums/:id" do
    it "returns 200 OK and displays album/1 retrieved" do
      response = get('/albums/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it "returns 200 OK and displays album/1 retrieved" do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end

  end

  context "POST /albums" do
    it 'returns 200 OK' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it "returns 200OK and a list of artists" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos')
    end
  end

  context "POST /artists" do
    it "returns 200 OK" do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      response = get('/artists')
      expect(response.body).to include('Wild nothing')
    end
  end
end
