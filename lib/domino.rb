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

  def self.decrease_dpi#Decrease row dpi to 50. 
    for fname in ARGV do
      img = Magick::Image.read( fname ).first #firstは配列の[0]
      img = img.resize_to_fit(50, )
      img.write("#{fname}_decreasedpi.jpg")
      self.count("#{fname}_decreasedpi.jpg")
    end
  end

  def self.close_to_domino(red,green,blue)#Return which color domino close to pixel. 
    dis_black = Math.sqrt((DOMINO_BLACK.red-red)**2+(DOMINO_BLACK.green-green)**2+(DOMINO_BLACK.blue-blue)**2)#Calculate the distance between black domino and pixel.
    dis_white = Math.sqrt((DOMINO_WHITE.red-red)**2+(DOMINO_WHITE.green-green)**2+(DOMINO_WHITE.blue-blue)**2)
    dis_red = Math.sqrt((DOMINO_RED.red-red)**2+(DOMINO_RED.green-green)**2+(DOMINO_RED.blue-blue)**2)
    dis_blue = Math.sqrt((DOMINO_BLUE.red-red)**2+(DOMINO_BLUE.green-green)**2+(DOMINO_BLUE.blue-blue)**2)
    dis_yellow = Math.sqrt((DOMINO_YELLOW.red-red)**2+(DOMINO_YELLOW.green-green)**2+(DOMINO_YELLOW.blue-blue)**2)
    dis_green = Math.sqrt((DOMINO_GREEN.red-red)**2+(DOMINO_GREEN.green-green)**2+(DOMINO_GREEN.blue-blue)**2)
    dis_orange = Math.sqrt((DOMINO_ORANGE.red-red)**2+(DOMINO_ORANGE.green-green)**2+(DOMINO_ORANGE.blue-blue)**2)
    dis_pink = Math.sqrt((DOMINO_PINK.red-red)**2+(DOMINO_PINK.green-green)**2+(DOMINO_PINK.blue-blue)**2)
    dis_violet = Math.sqrt((DOMINO_VIOLET.red-red)**2+(DOMINO_VIOLET.green-green)**2+(DOMINO_VIOLET.blue-blue)**2)

    dis = {"black" => dis_black,"white" => dis_white,"red" => dis_red,"blue" => dis_blue,"yellow" => dis_yellow,"green" => dis_green,"orange" => dis_orange,"pink" => dis_pink,"violet" => dis_violet}#Store several distance for hash.
    return ( dis.min { |a, b| a[1] <=> b[1] } )[0]#Return minimal value's key.
  end

  def self.count(fname)
    img = Magick::Image.read( fname ).first #firstは配列の[0]
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
        case self.close_to_domino(img.pixel_color(x,y).red,img.pixel_color(x,y).green,img.pixel_color(x,y).blue)
        when "Black" then
          img.pixel_color(x,y,DOMINO_BLACK)
          cblack += 1
        when "white" then
          img.pixel_color(x,y,DOMINO_WHITE)
          cwhite += 1
        when "red" then
          img.pixel_color(x,y,DOMINO_RED)
          cred += 1
        when "blue" then
          img.pixel_color(x,y,DOMINO_BLUE)
          cblue += 1
        when "yellow" then
          img.pixel_color(x,y,DOMINO_YELLOW)
          cyellow += 1
        when "green" then
          img.pixel_color(x,y,DOMINO_GREEN)
          cgreen += 1
        when "orange" then
          img.pixel_color(x,y,DOMINO_ORANGE)
          corange += 1
        when "pink" then
          img.pixel_color(x,y,DOMINO_PINK)
          cpink += 1
        when "violet" then
          img.pixel_color(x,y,DOMINO_VIOLET)
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
end

Domino.decrease_dpi

