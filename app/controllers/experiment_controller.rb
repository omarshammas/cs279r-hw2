class ExperimentController < ApplicationController
  
  before_filter :get_user, except: [:embed, :home, :begin]
  
  COMMAND_SET_SIZE = 6
  
  FAMILIAR_TASKS_COUNT = 5
  PERFORMANCE_TASKS_COUNT = 15
  
  FAMILIAR_TRIALS = 1
  PERFORMANCE_TRIALS = 1
  
  @@tasks_1 = ["bold-btn", "align_center-btn", "web_lyt_btn", "outline_btn", "bold-btn", "next-comment-btn", "previous-change-btn", 
    "next-comment-btn", "align_center-btn", "bold-btn", "previous-change-btn", "next-comment-btn", "bold-btn", "outline_btn", 
    "align_center-btn", "previous-change-btn", "next-comment-btn", "web_lyt_btn", "outline_btn", "web_lyt_btn"] 

  @@tasks_2 = ["bullet-btn", "macros-btn", "zoom_btn", "italic-btn", "bullet-btn", "italic-btn", "add-change-btn", 
    "spelling-btn", "zoom_btn", "macros-btn", "zoom_btn", "italic-btn", "macros-btn", "spelling-btn", "add-change-btn", 
    "zoom_btn", "italic-btn", "bullet-btn", "macros-btn", "zoom_btn"]   
  
  # @@icon_set_1 = ['align_center-btn', 'next-comment-btn', 'previous-change-btn','bold-btn','web_lyt_btn','border-btn']
  # @@icon_set_2 = ['italic-btn','spelling-btn','add-change-btn','zoom_btn','bullet-btn','orientation-btn',]
  
  def embed
    @page = get_page
  end

  def home
    @user = User.new
  end

  def begin

    if current_user.nil?
      u = User.create
      session[:id] = u.id
      session[:progress] = 0
      session[:roundtwo] = false
      session[:tab_index] = 0
      generate_all_sets
    end

    if params[:user][:age].nil? or params[:user][:age].blank? or 
      params[:user][:gender].nil? or params[:user][:gender].blank? or 
      params[:user][:input_device].nil? or params[:user][:input_device].blank?
        return redirect_to home_url, notice: "You must complete all fields."
    end
    current_user.update_attributes params[:user]
    initial_interface = ['ribbon','commandmap'].sample
    session[:ribbon] = initial_interface == 'ribbon' ? true:false
    current_user.update_attributes :initial_interface => initial_interface
    
    session[:stage] = 'middle'
    if(session[:ribbon])
      redirect_to instructions_ribbon_url
    else
      redirect_to instructions_commandmaps_url
    end

  end

  def instructions_ribbon
    session[:tab_index] = 0
  end

  def instructions_commandmaps
    session[:tab_index] = 0
  end

  def task
    return redirect_to survey_url if experiment_complete?

    @ribbon = session[:ribbon]
    @button = get_button
    @tab_index = session[:tab_index]
    @remaining = block_size

    render layout: "office"
  end
  
  def commandmaps
    @button = get_button
    render :layout => false
  end

  def task_complete
    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button = get_button()
    block = get_block position
    tab_hash = {"home" => 0, "review" => 1, "insert" => 2, "layout" => 3, "view" => 4}
    parent_switch = false
    new_tab_index = tab_hash[button.parent]
    parent_switch = true unless new_tab_index == session[:tab_index]
    session[:tab_index] = tab_hash[button.parent]
    
    Task.create time: params[:time], menu: get_menu, block: block, button_id: button.id, bad_clicks: params[:errors], position: position, user_id: current_user.id, parent_switch: parent_switch

    session[:progress] = session[:progress] + 1

    return redirect_to survey_url if next_round? or experiment_complete?

    redirect_to task_url, notice: "Previous Task - Time to complete #{params[:time]} ms with #{params[:errors]} errors."
  end

  def survey
    session[:stage] = 'survey'

    @questions = {}
    @questions['mental'] = 'How mentally demanding was the task?'
    @questions['physical'] = 'How physically demanding was the task?'
    @questions['temporal'] = 'How hurried or rushed was the pace of the task?'
    @questions['performance'] = 'How successful were you in accomplishing what you were asked to do?'
    @questions['effort'] = 'How hard did you have to work to accomplish your level of performance?'
    @questions['frustration'] = 'How insecure, discouraged, irritated, stressed and annoyed were you?'

    @nasatlx = Nasatlx.new
  end

  def nasatlx

    #store nasatlx for the menu
    @nasatlx = Nasatlx.new params[:nasatlx]
    @nasatlx.user_id = current_user.id
    @nasatlx.menu = get_menu
    @nasatlx.save

    if experiment_complete?
      session[:stage] = 'thank_you'
      return redirect_to thank_you_url
    end

    #time for the next round, the experiment is not complete
    session[:stage] = 'middle'
    session[:roundtwo] = true
    session[:progress] = 0
    session[:ribbon] = !session[:ribbon] #toggle so now we start the next round
    if session[:ribbon] 
      return redirect_to instructions_ribbon_url
    else
      return redirect_to instructions_commandmaps_url        
    end    
  end

  def thank_you
  end

  def results
    @user = current_user
    @ribbon = @user.tasks.where(menu: 'ribbon').order('block asc, position asc ')
    @ribbon_nasa = @user.nasatlx.where(menu: 'ribbon').first
    @cm = @user.tasks.where(user_id: current_user.id, menu: 'command maps').order('block asc, position asc ')
    @cm_nasa = @user.nasatlx.where(menu: 'command maps').first
  end

private

  def get_user
    if session[:id].nil? or session[:id].blank?
      redirect_to root_url
    end
  end

  def current_user
    return nil if session.nil? or session[:id].blank?
    User.find session[:id]
  end

  def generate_all_sets
    commands_array = [];
    task_set_array = [@@tasks_1,@@tasks_2].shuffle
    task_set_array.each do |task_array|
      commands = []
      task_array.each do |button_abr|
        commands.append(Button.find_by_abr(button_abr))
      end
      commands_array.append(commands)
    end
    ribbon_commands = [];
    session[:r_commands] = commands_array[0]
    session[:cm_commands] = commands_array[1]
  end

  #Generates a set of commands in different parents
  # def generate_command_set
    # commands = Button.home.sample 3
#     
    # all_parents = ['review', 'insert', 'view', 'layout']
    # two_parents = all_parents.sample 2
    # commands += Button.send(two_parents.first).sample 2
    # commands += Button.send(two_parents.first).sample 1
  # end
# 
  # def generate_familiarization_set commands
    # set = commands * FAMILIAR_TRIALS
    # set.shuffle
  # end
# 
  # def generate_performance_set commands
    # begin
      # set = commands * PERFORMANCE_TRIALS
      # set.shuffle!
    # end #while !fifty_percent_switching?(set) #TODO
    # set
  # end

  def fifty_percent_switching? set 
    switches = 0.0;
    for i in 1..(set.count-1)
      switches += 1 if set[i].parent != set[i-1].parent
    end

    0.45 <= (switches/set.count) and (switches/set.count) <= 0.55 
  end

  def get_block n
    return "familiarization" if n <= (FAMILIAR_TASKS_COUNT)
    "performance"
  end

  def get_menu
    return "ribbon" if session[:ribbon]
    "command maps"
  end

  def block_size
    FAMILIAR_TASKS_COUNT+PERFORMANCE_TASKS_COUNT
  end

  def get_page
    return home_path if session[:stage].nil?
    return survey_path if session[:stage] == 'survey'
    return thank_you_path if session[:stage] == 'thank_you'

    return instructions_ribbon_path if session[:progress] == 0 and session[:ribbons]
    return instructions_commandmaps_path if session[:progress] == 0 and !session[:ribbons]
    task_path
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
