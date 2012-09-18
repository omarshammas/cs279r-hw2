class ExperimentController < ApplicationController
  
  before_filter :get_user, except: [:home, :instructions, :begin]
  
  def home
  end

  def instructions
  end

  def begin

    return redirect_to instructions_url, notice: 'You must enter your Turk ID to continue' if params[:turk_id].nil? or params[:turk_id].blank?

    #retrieve the user if they already exist or create a new one
    u = User.where turk_id: params[:turk_id]
    u = u.first unless u.nil?
    u = User.create turk_id: params[:turk_id], ip: request.env['REMOTE_ADDR'] if u.nil?
    
    session[:id] = u.id

  	#generate the command sets for familiarization and performance sections  	
    set = generate_command_set
    familiar = generate_familiarization_set(set).map! { |c| c.id }
    performance = generate_performance_set(set).map! { |c| c.id }
  
    session[:commandset] = set.map { |s| s.id  }
    session[:commands] = familiar + performance
    session[:progress] = 1

    redirect_to intermediate_url
  end

  def intermediate
    p "-=====================-"
    p session[:progress]
    p session[:commands]

    redirect_to survey_url if session[:progress] > 90
  end

  def task
    @button = Button.find session[:commands][session[:progress]]

    render layout: "office"
  end

  def commandmaps
  end

  def task_complete
    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button = session[:commands][position]
    block = get_block position
    Task.create time: params[:time], block: block, button: button, bad_clicks: params[:errors], position: position, user_id: current_user.id

    session[:progress] = session[:progress] + 1

    return redirect_to intermediate_url, notice: "Time to complete #{params[:time]} s with #{params[:errors]} errors."
  end

  def survey
  end

  def thank_you
  end

private

  def get_user
    if session[:id].nil? or session[:id].blank?
      redirect_to root_url
    end
  end

  def current_user
    User.find session[:id]
  end

  #Generates a set of commands in different parents
  def generate_command_set
    n = 6

    commands = Button.home.sample 3
    
    all_parents = ['review', 'insert', 'view', 'layout']
    two_parents = all_parents.sample 2
    commands += Button.send(two_parents.first).sample 2
    commands += Button.send(two_parents.first).sample 1
  end

  def generate_familiarization_set commands
    trials = 5
    set = commands * trials
    set.shuffle
  end


  def generate_performance_set commands
    p "inside performance"
    trials = 15
    begin
      set = commands * trials
      set.shuffle!(random: Random.new(1)) 
    end #while !fifty_percent_switching?(set) #TODO
    set
  end

  def fifty_percent_switching? set 
    switches = 0.0;
    for i in 1..(set.count-1)
      switches += 1 if set[i].parent != set[i-1].parent
    end

    0.45 <= (switches/set.count) and (switches/set.count) <= 0.55 
  end

  def get_block n
    return "familiarization" if n >= 30
    "performance"
  end

end
