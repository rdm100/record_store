require('sinatra')
require('sinatra/contrib/all')
require ('pry-byebug')

require_relative("./models/artist.rb")
require_relative("./models/album.rb")
require_relative("./album_controller.rb")
require_relative("./artist_controller.rb")

#index
get "/" do
  @artists = Artist.all()
  @albums = Album.all()
  erb(:index)
end