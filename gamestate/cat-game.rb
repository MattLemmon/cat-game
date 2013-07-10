$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "gamestates")
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..")
# for some reason, on Ruby 1.9.3, I needed to add the second $LOAD_PATH bit
# puts $LOAD_PATH

require 'chingu'
require 'gosu'
include Chingu
include Gosu
require 'CORE'
require 'EX'      #possibly eliminate
require 'game'
require 'play'
require 'jungle'
require 'example4_gamestates' #need to eliminate
require 'drdcat'
require 'zoom'
require 'cpncat'

Core.new.show