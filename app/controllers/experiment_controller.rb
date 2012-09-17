class ExperimentController < ApplicationController

  def begin
  	#get_user_info

  	#generate the command sets for familiarization and performance sections  	
    set = generate_command_set
    session[:commandset] = set
    session[:familiar] = generate_familiarization_set set
  	session[:performance] = generate_performance_set set
    session[:progress] = 0

  end

  def ribbon_task
    @progress = session[:progress] 
    render layout: "office"
  end

  def command_maps_task
    render layout: "office"
  end

  def intermediate
      	
  end

private

  #Generates a set of commands in different parents
  def generate_command_set
    N = 6

  end


  def generate_familiarization_set set
    trials = 5
    #randomize 
  end


  def generate_performance_set set
    trials = 15
    #randomize 
  end

end
