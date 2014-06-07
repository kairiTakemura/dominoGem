#!/usr/bin/env ruby
#require "domino/version"
require 'rubygems'
require 'RMagick'


module Domino

  #Each domino RGB value.
  DOMINO_BLACK = Magick::Pixel.new(45*256,47*256,63*256)
  DOMINO_WHITE = Magick::Pixel.new(195*256,226*256,252*256)
  DOMINO_RED = Magick::Pixel.new(228*256,99*256,111*256)
  DOMINO_BLUE = Magick::Pixel.new(9*256,117*256,197*256)
  DOMINO_YELLOW = Magick::Pixel.new(239*256,216*256,145*256)
  DOMINO_GREEN = Magick::Pixel.new(81*256,196*256,149*256)
  DOMINO_ORANGE = Magick::Pixel.new(254*256,141*256,97*256)
  DOMINO_PINK = Magick::Pixel.new(232*256,160*256,212*256)
  DOMINO_VIOLET = Magick::Pixel.new(82*256,6*256,85*256)

  DOMINO = [DOMINO_BLACK,DOMINO_WHITE,DOMINO_RED,DOMINO_BLUE,DOMINO_YELLOW,DOMINO_GREEN,DOMINO_ORANGE,DOMINO_PINK,DOMINO_VIOLET]

=begin
  COUNT = {DOMINO_BLACK:cblack,DOMINO_WHITE:cwhite,DOMINO_RED:cred,DOMINO_BLUE,DOMINO_YELLOW,DOMINO_GREEN,DOMINO_ORANGE,DOMINO_PINK,DOMINO_VIOLET}
=end

  #Domino height,length and width.
  DOMINO_HEIGHT = 46e-3
  DOMINO_LENGTH = 23e-3
  DOMINO_WIDTH = 8e-3

  def self.decrease_dpi(fname)#Decrease row dpi to 50. 
    img = Magick::Image.read(fname).first #firstは配列の[0]
    img = img.resize_to_fit(50, )
    img.write("#{fname}_decreasedpi.jpg")
    self.count("#{fname}_decreasedpi.jpg")
    puts "height : #{self.size("#{fname}_decreasedpi.jpg")[0]}m"
    puts "width : #{self.size("#{fname}_decreasedpi.jpg")[1]}m"
  end

  def self.close_to_domino(pixel_color)#Return which color domino close to pixel. 
    min = Math.sqrt((DOMINO_BLACK.red-pixel_color.red)**2+(DOMINO_BLACK.green-pixel_color.green)**2+(DOMINO_BLACK.blue-pixel_color.blue)**2)
    tmp = DOMINO_BLACK
    for domino in DOMINO do
      distance = Math.sqrt((domino.red-pixel_color.red)**2+(domino.green-pixel_color.green)**2+(domino.blue-pixel_color.blue)**2)#Calculate the distance between domino and pixel.
      if distance < min then
        min = distance
        tmp = domino
      end
    end
    return tmp #Return minimal.
  end

  def self.count(fname)
    img = Magick::Image.read(fname).first #firstは配列の[0]
    cblack = 0 #Count for black domino.
    cwhite = 0
    cred = 0
    cblue = 0
    cyellow = 0
    cgreen = 0
    corange = 0
    cpink = 0
    cviolet = 0
    for y in 0..img.rows-1 do
      for x in 0..img.columns-1 do
        tmp = self.close_to_domino(img.pixel_color(x,y))
        img.pixel_color(x,y,tmp)
        case tmp 
        when DOMINO_BLACK then 
          cblack += 1
        when DOMINO_WHITE then 
          cwhite += 1
        when DOMINO_RED then 
          cred += 1
        when DOMINO_BLUE then 
          cblue += 1
        when DOMINO_YELLOW then 
          cyellow += 1
        when DOMINO_GREEN then 
          cgreen += 1
        when DOMINO_ORANGE then 
          corange += 1
        when DOMINO_PINK then 
          cpink += 1
        when DOMINO_VIOLET then 
          cviolet += 1
        end
      end
    end
    img.write("#{ARGV[0]}_replace.jpg")
    puts "Black : #{cblack}"
    puts "White : #{cwhite}"
    puts "Red : #{cred}"
    puts "Blue : #{cblue}"
    puts "Yellow : #{cyellow}"
    puts "Green : #{cgreen}"
    puts "Orange : #{corange}"
    puts "Pink : #{cpink}"
    puts "Violet : #{cviolet}"
  end

  def self.size(fname)#Expression area that required to put domino.
    img = Magick::Image.read(fname).first
    return [(DOMINO_HEIGHT/2+DOMINO_WIDTH)*img.columns,(DOMINO_LENGTH+DOMINO_WIDTH)*img.rows]
  end

  def self.layout#Output the layout of domino.
    
  end

end

Domino.decrease_dpi(ARGV[0])

