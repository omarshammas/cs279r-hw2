class ExperimentController < ApplicationController
  
  before_filter :get_user, except: [:home, :instructions, :begin]
  
  COMMAND_SET_SIZE = 6
  FAMILIAR_TRIALS = 1
  PERFORMANCE_TRIALS = 1

  def home
  end

  def instructions
  end

  def commandmap_instructions
  end

  def begin

    return redirect_to instructions_url, notice: 'You must enter your Turk ID to continue' if params[:turk_id].nil? or params[:turk_id].blank?

    #retrieve the user if they already exist or create a new one
    u = User.where turk_id: params[:turk_id]
    u = u.first unless u.nil?

    if u.nil?
      u = User.create turk_id: params[:turk_id], ip: request.env['REMOTE_ADDR'] 
      
      session[:id] = u.id
      session[:progress] = 0
      session[:roundtwo] = false
      generate_all_sets
    end

    redirect_to intermediate_url
  end

  def intermediate
    redirect_to survey_url if session[:roundtwo] and session[:progress] >= 2*(COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS))
    
    if !session[:roundtwo] and session[:progress] >= (COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS))
      session[:roundtwo] = true
      generate_all_sets
      redirect_to commandmap_instructions_url
    end
  end

  def task
    @ribbon = true;
    if(session[:roundtwo])
      @ribbon = false;
    end
    @button = Button.find session[:commands][session[:progress]%(COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS))]

    render layout: "office"
  end
  
  def commandmaps
    @button = Button.find session[:commands][session[:progress]%(COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS))]
    render :layout => false
  end

  def task_complete
    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button_id = session[:commands][position%(COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS))]
    block = get_block position
    Task.create time: params[:time], block: block, button_id: button_id, bad_clicks: params[:errors], position: position, user_id: current_user.id

    session[:progress] = session[:progress] + 1

    return redirect_to intermediate_url, notice: "Time to complete #{params[:time]} ms with #{params[:errors]} errors."
  end

  def survey
  end

  def results
    @tasks = Task.where(user_id: current_user.id).order('position asc')
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

  def generate_all_sets
    #generate the command sets for familiarization and performance sections   
    set = generate_command_set
    familiar = generate_familiarization_set(set).map! { |c| c.id }
    performance = generate_performance_set(set).map! { |c| c.id }
  
    session[:commandset] = set.map { |s| s.id  }
    session[:commands] = familiar + performance
  end

  #Generates a set of commands in different parents
  def generate_command_set
    commands = Button.home.samplex 3
    
    all_parents = ['review', 'insert', 'view', 'layout']
    two_parents = all_parents.sample 2
    commands += Button.send(two_parents.first).sample 2
    commands += Button.send(two_parents.first).sample 1
  end

  def generate_familiarization_set commands
    set = commands * FAMILIAR_TRIALS
    set.shuffle
  end


  def generate_performance_set commands
    begin
      set = commands * PERFORMANCE_TRIALS
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
    return "familiarization" if n%(COMMAND_SET_SIZE*(PERFORMANCE_TRIALS+FAMILIAR_TRIALS)) <= (COMMAND_SET_SIZE*FAMILIAR_TRIALS)-1
    "performance"
  end

end
