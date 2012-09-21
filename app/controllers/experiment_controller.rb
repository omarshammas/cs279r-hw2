class ExperimentController < ApplicationController
  
  before_filter :get_user, except: [:embed, :home, :instructions, :begin]
  
  COMMAND_SET_SIZE = 6
  FAMILIAR_TRIALS = 1
  PERFORMANCE_TRIALS = 1

  def embed
    @page = get_page
  end

  def home
  end

  def instructions_ribbon
  end

  def instructions_commandmaps
  end

  def begin
    return redirect_to home_url, notice: 'You must enter your Turk ID to continue' if params[:turk_id].nil? or params[:turk_id].blank?

    #retrieve the user if they already exist or create a new one
    u = User.where turk_id: params[:turk_id]
    u = u.first unless u.nil?

    if u.nil?
      u = User.create turk_id: params[:turk_id], ip: request.env['REMOTE_ADDR'] 
      
      session[:id] = u.id
      session[:progress] = 0
      session[:roundtwo] = false
      generate_all_sets      
    elsif session[:stage].nil?
      #cookie was erased but this user is on file
      session[:stage] = 'thank_you'
      return redirect_to thank_you_url
    end

    session[:stage] = 'middle'
    if session[:ribbon]
      redirect_to instructions_ribbon_url
    else
      redirect_to instructions_commandmaps_url
    end
  end

  def intermediate

    redirect_to survey_url if experiment_complete?

    if next_round?
      session[:roundtwo] = true
      session[:progress] = 0
      session[:ribbon] = !session[:ribbon] #toggle so now we start the next round
      if session[:ribbon] 
        redirect_to instructions_ribbon_url
      else
        redirect_to instructions_commandmaps_url        
      end
    end
    
  end

  def task
    return redirect_to survey_url if experiment_complete?

    @ribbon = session[:ribbon]
    @button = get_button

    render layout: "office"
  end
  
  def commandmaps
    @button = get_button
    render :layout => false
  end

  def task_complete
    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button_id = get_button().id
    block = get_block position
    Task.create time: params[:time], menu: get_menu, block: block, button_id: button_id, bad_clicks: params[:errors], position: position, user_id: current_user.id

    session[:progress] = session[:progress] + 1

    return redirect_to intermediate_url, notice: "Time to complete #{params[:time]} ms with #{params[:errors]} errors."
  end

  def survey
    session[:stage] = 'survey'
  end

  def preference
    if params[:preference].nil? or params[:preference].blank?
      return redirect_to survey_url, notice: "You have to select either command maps or ribbons. It cannot be left blank."
    end
    current_user.update_attribute :preference, params[:preference]
    session[:stage] = 'thank_you'
    redirect_to thank_you_url
  end

  def thank_you
  end

  def results
    @user = current_user
    @tasks = Task.where(user_id: current_user.id).order('menu asc, block asc, position asc ')
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
    session[:ribbon] = true   #TODO for now sets ribbons first

    #creates ribbon set
    set = generate_command_set
    familiar = generate_familiarization_set(set).map! { |c| c.id }
    performance = generate_performance_set(set).map! { |c| c.id }
  
    session[:r_commandset] = set.map { |s| s.id  }
    session[:r_commands] = familiar + performance

    #creates commandmap set
    set = generate_command_set
    familiar = generate_familiarization_set(set).map! { |c| c.id }
    performance = generate_performance_set(set).map! { |c| c.id }
  
    session[:cm_commandset] = set.map { |s| s.id  }
    session[:cm_commands] = familiar + performance
  end

  #Generates a set of commands in different parents
  def generate_command_set
    commands = Button.home.sample 3
    
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
    return "familiarization" if n <= (COMMAND_SET_SIZE*FAMILIAR_TRIALS)-1
    "performance"
  end

  def get_menu
    return "ribbon" if session[:ribbon]
    "command maps"
  end

  def block_size
    COMMAND_SET_SIZE*(FAMILIAR_TRIALS+PERFORMANCE_TRIALS)
  end

  def get_page
    return home_path if session[:stage].nil?
    return survey_path if session[:stage] == 'survey'
    return thank_you_path if session[:stage] == 'thank_you'

    return instructions_ribbon_path if session[:progress] == 0 and session[:ribbons]
    return instructions_commandmaps_path if session[:progress] == 0 and !session[:ribbons]
    intermediate_path
  end

  def experiment_complete?
    session[:roundtwo] and session[:progress] >= block_size
  end

  def next_round?
    !session[:roundtwo] and session[:progress] >= block_size
  end

  def get_button
    return Button.find session[:r_commands][session[:progress]] if session[:ribbon]
    Button.find session[:cm_commands][session[:progress]]
  end

end
