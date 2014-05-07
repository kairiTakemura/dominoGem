#require "domino/version"
require 'rubygems'
require 'RMagick'


module Domino
  def self.decreasedpi
    for fname in ARGV do
    img = Magick::Image.read( fname ).first #firstは配列の[0]
    img = img.resize_to_fit(50, 996)
    img.write("#{fname}_decreasedpi.jpg")
    self.count("#{fname}_decreasedpi.jpg")
    end
  end

  def self.close_to_domino(red,green,blue)
    domino_black = [45,47,63]
    domino_white = [195,226,252]
    domino_red = [228,99,111]
    domino_blue = [9,117,197]
    domino_yellow = [239,216,145]
    domino_green = [81,196,149]
    domino_orange = [254,141,97]
    domino_pink = [232,160,212]
    domino_violet = [82,6,85]
    diff_black = Math.sqrt((domino_black[0]-red)**2+(domino_black[1]-green)**2+(domino_black[2]-blue)**2)
    diff_white = Math.sqrt((domino_white[0]-red)**2+(domino_white[1]-green)**2+(domino_white[2]-blue)**2)
    diff_red = Math.sqrt((domino_red[0]-red)**2+(domino_red[1]-green)**2+(domino_red[2]-blue)**2)
    diff_blue = Math.sqrt((domino_blue[0]-red)**2+(domino_blue[1]-green)**2+(domino_blue[2]-blue)**2)
    diff_yellow = Math.sqrt((domino_yellow[0]-red)**2+(domino_yellow[1]-green)**2+(domino_yellow[2]-blue)**2)
    diff_green = Math.sqrt((domino_green[0]-red)**2+(domino_green[1]-green)**2+(domino_green[2]-blue)**2)
    diff_orange = Math.sqrt((domino_orange[0]-red)**2+(domino_orange[1]-green)**2+(domino_orange[2]-blue)**2)
    diff_pink = Math.sqrt((domino_pink[0]-red)**2+(domino_pink[1]-green)**2+(domino_pink[2]-blue)**2)
    diff_violet = Math.sqrt((domino_violet[0]-red)**2+(domino_violet[1]-green)**2+(domino_violet[2]-blue)**2)
    diff = {"black" => diff_black,"white" => diff_white,"red" => diff_red,"blue" => diff_blue,"yellow" => diff_yellow,"green" => diff_green,"orange" => diff_orange,"pink" => diff_pink,"violet" => diff_violet}
    return ( diff.min { |a, b| a[1] <=> b[1] } )[0]
  end

  def self.count(fname)
    img = Magick::Image.read( fname ).first #firstは配列の[0]
    domino_black = Magick::Pixel.new(45*256,47*256,63*256)
    domino_white = Magick::Pixel.new(195*256,226*256,252*256)
    domino_red = Magick::Pixel.new(228*256,99*256,111*256)
    domino_blue = Magick::Pixel.new(9*256,117*256,197*256)
    domino_yellow = Magick::Pixel.new(239*256,216*256,145*256)
    domino_green = Magick::Pixel.new(81*256,196*256,149*256)
    domino_orange = Magick::Pixel.new(254*256,141*256,97*256)
    domino_pink = Magick::Pixel.new(232*256,160*256,212*256)
    domino_violet = Magick::Pixel.new(82*256,6*256,85*256)
    for y in 0..img.columns-1 do
      for x in 0..img.rows-1 do
        tmp = self.close_to_domino(img.pixel_color(x,y).red/256,img.pixel_color(x,y).green/256,img.pixel_color(x,y).green/256)
        if tmp == "black" then 
          img.pixel_color(x,y,domino_black)
        elsif tmp == "white" then
          img.pixel_color(x,y,domino_white)
        elsif tmp == "red" then
          img.pixel_color(x,y,domino_red)
        elsif tmp == "blue" then
          img.pixel_color(x,y,domino_blue)
        elsif tmp == "yellow" then
          img.pixel_color(x,y,domino_yellow)
        elsif tmp == "green" then
          img.pixel_color(x,y,domino_green)
        elsif tmp == "orange" then
          img.pixel_color(x,y,domino_orange)
        elsif tmp == "pink" then
          img.pixel_color(x,y,domino_pink)
        elsif tmp == "violet" then
          img.pixel_color(x,y,domino_violet)
        end
      end
    end
    img.write("#{ARGV[0]}_replace.jpg")
  end
end

#Domino.decreasedpi
Domino.count
