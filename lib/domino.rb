require "./domino/version"
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
end

Domino.decreasedpi

