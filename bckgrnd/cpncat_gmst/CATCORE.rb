#
#  PAUSE CLASS
#
class Pause < Chingu::GameState
  def initialize(options = {})
    super
    @title = Chingu::Text.create(:text=>"PAUSED (press 'p' to un-pause)", :x=>200, :y=>200, :size=>20, :color => Color.new(0xFF00FF00))
    self.input = { :p => :un_pause, :q => DrdCat, :r => :reset }
  end
  def un_pause
    pop_game_state(:setup => false)    # Return the previous game state, dont call setup()
  end  
  def reset
    pop_game_state(:setup => true)
  end
  def draw
    previous_game_state.draw    # Draw prev game state onto screen (in this case our level)
    super                       # Draw game objects in current game state, this includes Chingu::Texts
  end  
end


#
#     WINDOW CLASS        WINDOW CLASS        WINDOW CLASS     WINDOW CLASS   
#
class Core < Chingu::Window
  def initialize
    super(800,600)
    self.input = {:esc => :exit, :enter => :next, :return => :next, :q => :pop, :z => :status, :f=>:fart}
    push_game_state(Welcome)
  end

  def pop
    if $window.current_game_state.to_s != "Welcome" then
      pop_game_state
    else
      puts "chill"
    end
  end

  def next
    if current_game_state.class == Welcome
      switch_game_state(DrdCat)
    else
      switch_game_state(Welcome)
    end
  end
  

  def status
    puts $window.current_game_state
  end

  def fart
    @fart = "&xo|kee<92ujjsllo8!!!"
    puts @fart
  end
end


#
#   WELCOME   WELCOME   WELCOME   WELCOME   WELCOME   WELCOME   WELCOME
#
class Welcome < Chingu::GameState
  def initialize
    super
    $window.caption = "Chingu Example Loader - WELCOME"
    self.input = { :b => :boom, :enter => DrdCat, :return => DrdCat }
    @t1 = Chingu::Text.create(:text=>"Chingu Example Loader" , :x=>98, :y=>70, :size=>70)
    @t2 = Chingu::Text.create(:text=>"Global Controls:       Q  -  Previous Menu" , :x=>134, :y=>185, :size=>36)
    @t3 = Chingu::Text.create(:text=>"W  -  Previous Menu" , :x=>382, :y=>235, :size=>36)
    @t4 = Chingu::Text.create(:text=>"Z  -  Status Log" , :x=>388, :y=>335, :size=>36)
    @t4 = Chingu::Text.create(:text=>"F  -  Fart Feature" , :x=>391, :y=>285, :size=>36)
    @t5 = Chingu::Text.create(:text=>"Press Enter to Continue" , :x=>240, :y=>420, :size=>40)
    puts "Welcome"
  end

  def boom
    puts $window.current_game_state
    puts "Boom!"
    push_game_state(DrdCat)
  end

  def setup
    $window.caption = "Chingu Example Loader - WELCOME"
  end

end


