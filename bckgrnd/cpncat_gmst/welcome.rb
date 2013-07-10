$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "ch_examples")
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..")
# for some reason, on Ruby 1.9.3, I needed to add the second $LOAD_PATH bit
# puts $LOAD_PATH

require 'chingu'
require 'gosu'
include Chingu
include Gosu
require 'CATCORE'
require 'drdcat'

Core.new.show