#require "domino/version"
require 'rubygems'
require 'RMagick'


module Domino
  def self.decreasedpi
    for fname in ARGV do
    img = Magick::Image.read( fname ).first #firstは配列の[0]
    img = img.resize_to_fit(50, 996)
    img.write("#{fname}_decreasedpi.jpg")
    end
  end
  def self.count
    img = Magick::Image.read( ARGV[0] ).first #firstは配列の[0]
    for x in 0..img.rows do
      puts "#{img.pixel_color(x,0)}"
    end
  end
end

Domino.count

