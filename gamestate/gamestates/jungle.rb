#!/usr/bin/env ruby
require 'rubygems' rescue nil
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
require 'chingu'
include Gosu

#
# Parallax-example
# Images from http://en.wikipedia.org/wiki/Parallax_scrolling
#
class Ex3 < Chingu::Window  # class name changed for ch_loader
  def initialize
    super(600,200)
    self.caption = "gato"
    switch_game_state(Jungle)
  end
end

class Scroller < Chingu::GameState
  
  def initialize(options = {})
    super(options)
    @text_color = Color.new(0xFF000000)
    self.input =  { :holding_left => :camera_left, 
                    :holding_right => :camera_right, 
                    :holding_up => :camera_up,
                    :holding_down => :camera_down,
                    :space => :next_game_state,
                    :escape => :exit
                  }    
  end
    
  def next_game_state
    if current_game_state.class == Jungle
      switch_game_state(Play)
    else
      switch_game_state(Jungle)
    end
  end
  
  def camera_left
    # This is essentially the same as @parallax.x += 2
    @parallax.camera_x -= 2
  end
  
  def camera_right
    # This is essentially the same as @parallax.x -= 2
    @parallax.camera_x += 2
  end  

  def camera_up
    # This is essentially the same as @parallax.y += 2
    @parallax.camera_y -= 2
  end

  def camera_down
    # This is essentially the same as @parallax.y -= 2
    @parallax.camera_y += 2
  end  
end

class Jungle < Scroller
  def initialize(options = {})
    super
    @parallax = Chingu::Parallax.create(:x => 0, :y => 0, :rotation_center => :top_left)
  
    #
    # If no :zorder is given to @parallax.add_layer it defaults to first added -> lowest zorder
    # Everywhere the :image argument is used, these 2 values are the Same:
    # 1) Image["foo.png"]  2) "foo.png"
    #
    # Notice we add layers to the parallax scroller in 3 different ways. 
    # They all end up as ParallaxLayer-instances internally
    #
    @parallax.add_layer(:image => "Parallax-scroll-example-layer-0.png", :damping => 100)
    @parallax.add_layer(:image => "Parallax-scroll-example-layer-1.png", :damping => 10)
    @parallax.add_layer(:image => "cat-layer.png", :damping => -3, :y => 400)
    @parallax << Chingu::ParallaxLayer.new(:image => "Parallax-scroll-example-layer-2.png", :damping => 3, :parallax => @parallax)
    @parallax << {:image => "Parallax-scroll-example-layer-3.png", :damping => 1}
#    @parallax.add_layer(:image => "ocean-layer.png", :damping => 0.9)

    Chingu::Text.create("gato", :x => 0, :y => 0, :size => 30, :color => @text_color)
  end
end

#Game.new.show   hashed out for ch_loader