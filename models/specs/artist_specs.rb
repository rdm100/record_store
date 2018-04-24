require('minitest/autorun')
require('minitest/rg')
require_relative('../artist')

class TestArtist < Minitest::Test

  def setup
    @artist = Artist.new({'name' => 'Prince', 'image' => '/images/artist/prince.jpg'})
  end

  def test_name
    assert_equal("Prince", @artist.name)
  end

   def test_image
    assert_equal('/images/artist/prince.jpg', @artist.image)
  end

end