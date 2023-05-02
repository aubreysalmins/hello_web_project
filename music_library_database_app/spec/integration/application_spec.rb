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
      response = get('/posts?title=Voyage&release_year=2022&artist_id=2')
      repo = AlbumRepository.new
      album = Album.new
      album.title = params[:title]
      album.release_year = params[:release_year]
      album.artist_id = params[:artist_id]
      repo.create(album)

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end
end
