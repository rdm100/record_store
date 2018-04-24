require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Prince', 'image' => '/images/artists/prince.jpg'})

artist2 = Artist.new({ 'name' => 'Cardi B', 'image' => '/images/artists/cardi_b.jpg'})

artist3 = Artist.new({ 'name' => 'Drake', 'image' => '/images/artists/drake.jpg'})

artist4 = Artist.new({ 'name' => 'Imagine Dragons', 'image' => '/images/artists/imagine_dragons.jpg'})

artist1.save()
artist2.save()
artist3.save()
artist4.save()


album1 = Album.new({ 'title' => 'Diamonds and pearls', 'in_stock' => 5, 'artist_id' => artist1.id(), 'genre' => 'Funk', 'album_art' => '/images/albums/diamonds_and_pearls.jpg' })

album2 = Album.new({ 'title' => 'Musicology', 'in_stock' => 0, 'artist_id' => artist1.id(), 'genre' => 'Funk', 'album_art' => '/images/albums/musicology.jpg' })

album3 = Album.new({ 'title' => 'Gangsta bitch volume 1', 'in_stock' => 20, 'artist_id' => artist2.id(), 'genre' => 'Rap', 'album_art' => '/images/albums/gangsta_bitch_vol_1.jpg' })

album4 = Album.new({ 'title' => 'Gangsta bitch volume 2', 'in_stock' => 50, 'artist_id' => artist2.id(), 'genre' => 'Rap', 'album_art' => '/images/albums/gangsta_bitch_vol_2.jpg' })

album5 = Album.new({ 'title' => 'More life', 'in_stock' => 60, 'artist_id' => artist3.id(), 'genre' => 'Rap', 'album_art' => '/images/albums/more_life.jpg' })

album6 = Album.new({ 'title' => 'Views', 'in_stock' => 50, 'artist_id' => artist3.id(), 'genre' => 'Rap', 'album_art' => '/images/albums/views.jpg' })

album7 = Album.new({ 'title' => 'Thank me later', 'in_stock' => 50, 'artist_id' => artist3.id(), 'genre' => 'Rap', 'album_art' => '/images/albums/thank_me_later.jpg' })


album1.save()
album2.save()
album3.save()
album4.save()
album5.save()
album6.save()
album7.save()

binding.pry
nil