#!/usr/bin/env ruby
require 'rubygems' rescue nil
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
require 'chingu'
include Gosu
include Chingu

#
# Animation / retrofy example
#
class DrdCat < Chingu::Window
  def initialize
    super    
    self.factor = 2
    self.input = { :escape => :exit }
#		self.caption = "Chingu::Animation / retrofy example. Move with arrows!"
    retrofy
    Droid.create(:x => $window.width/4*3, :y => $window.height/4*3)
  end
end

class Droid < Chingu::GameObject
  traits :timer
  
  def initialize(options = {})
    super
    
    #
    # This shows up the shorten versio of input-maps, where each key calls a method of the very same name.
    # Use this by giving an array of symbols to self.input
    #
    self.input = [:holding_left, :holding_right, :holding_up, :holding_down]
    
    # Load the full animation from tile-file media/droid.bmp
    @animation = Chingu::Animation.new(:file => "CpnCt.png")
    @animation.frame_names = { :scan => 0..0, :up => 1..2, :down => 3..4, :left => 1..2, :right => 3..4 }
    
    # Start out by animation frames 0-5 (contained by @animation[:scan])
    @frame_name = :scan
    
    @last_x, @last_y = @x, @y
    update
  end
    
  def holding_left
    @x -= 5
    @frame_name = :left
  end

  def holding_right
    @x += 5
    @frame_name = :right
  end
  
  def holding_up
    @y -= 5
    @frame_name = :up
  end

  def holding_down
    @y += 5
    @frame_name = :down
  end

  def draw
    # Raw Gosu Image.draw(x,y,zorder)-call
    Image["blank.png"].draw(0, 0, 0)
    super
  end

  # We don't need to call super() in update().
  # By default GameObject#update is empty since it doesn't contain any gamelogic to speak of.
  def update
    
    # Move the animation forward by fetching the next frame and putting it into @image
    # @image is drawn by default by GameObject#draw
    @image = @animation[@frame_name].next
    
    #
    # If droid stands still, use the scanning animation
    #
    @frame_name = :scan if @x == @last_x && @y == @last_y

    @x %= $window.width # wrap around the screen
    @y %= $window.height
    
#    @x, @y = @last_x, @last_y if outside_window?  # return to previous coordinates if outside window
    @last_x, @last_y = @x, @y                     # save current coordinates for possible use next time
  end
end

DrdCat.new.show