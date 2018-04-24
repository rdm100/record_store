require('minitest/autorun')
require('minitest/rg')

require_relative('../album')
require_relative('../artist')
require_relative('../../db/sql_runner')

class TestAlbum < MiniTest::Test

  def setup()
    Album.delete_all()
    Artist.delete_all()

    #instances of artist created
    @artist1 = Artist.new({ 'name' => 'Prince', 'image' => '/images/artist/prince.jpg' })
    @artist1.save()

    #instances of albums created
    @album1 = Album.new({ 'title' => 'Diamonds and Pearls', 'in_stock' => 0, 'artist_id' => @artist1.id(), 'genre' => 'Funk', 'album_art' => "/images/albums/diamonds_and_pearls.jpg"})

    @album2 = Album.new({ 'title' => 'Diamonds and Pearls', 'in_stock' => 5, 'artist_id' => @artist1.id(), 'genre' => 'Funk', 'album_art' => "/images/albums/diamonds_and_pearls.jpg"})

    @album3 = Album.new({ 'title' => 'Diamonds and Pearls', 'in_stock' => 20, 'artist_id' => @artist1.id(), 'genre' => 'Funk', 'album_art' => "/images/albums/diamonds_and_pearls.jpg"})

    @album4 = Album.new({ 'title' => 'Diamonds and Pearls', 'in_stock' => 45, 'artist_id' => @artist1.id(), 'genre' => 'Funk', 'album_art' => "/images/albums/diamonds_and_pearls.jpg"})

    @album5 = Album.new({ 'title' => 'Diamonds and Pearls', 'in_stock' => 60, 'artist_id' => @artist1.id(), 'genre' => 'Funk', 'album_art' => "/images/albums/diamonds_and_pearls.jpg"})

    @album1.save()
    @album2.save()
    @album3.save()
    @album4.save()
    @album5.save()
  end

  def test_title()
    result = @album1.title()
    assert_equal('Diamonds and Pearls', result)
  end

  def test_in_stock()
    result = @album2.in_stock()
    assert_equal(5, result)
  end

  def test_out_of_stock()
    result = @album1.stock_level()
    assert_equal("Out of stock", result)
  end

  def test_low_stock()
    result = @album2.stock_level()
    assert_equal("Low", result)
  end

  def test_medium_stock()
    result = @album3.stock_level()
    assert_equal("Medium", result)
  end

  def test_high_stock()
    result = @album5.stock_level()
    assert_equal("High", result)
  end

  def test_album_art()
    result = @album5.album_art()
    assert_equal("/images/albums/diamonds_and_pearls.jpg", result)
  end


end