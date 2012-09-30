class ExperimentController < ApplicationController
  
  before_filter :get_user, except: [:embed, :home, :begin]
  
  COMMAND_SET_SIZE = 6
  
  FAMILIAR_TASKS_COUNT = 30
  PERFORMANCE_TASKS_COUNT = 90

  @@tasks_1 = [3, 7, 22, 3, 15, 46, 3, 11, 7, 11, 46, 3, 7, 15, 15, 11, 11, 22, 22, 7, 3, 46, 46, 22, 22, 15, 46, 11, 15, 7, 11, 22, 3, 7, 22, 46, 22, 11, 3, 22, 46, 46, 46, 22, 7, 11, 15, 46, 22, 15, 22, 15, 46, 15, 46, 22, 11, 3, 7, 11, 46, 11, 7, 22, 3, 46, 7, 22, 11, 46, 15, 22, 15, 7, 7, 11, 3, 3, 15, 22, 15, 15, 22, 46, 3, 11, 11, 11, 7, 3, 3, 3, 7, 3, 15, 3, 22, 7, 46, 46, 15, 22, 46, 3, 11, 46, 15, 15, 7, 15, 15, 3, 11, 7, 11, 3, 7, 7, 11, 7]
  
  @@tasks_2 = [12, 8, 21, 12, 16, 47, 12, 4, 8, 4, 47, 12, 8, 16, 16, 4, 4, 21, 21, 8, 12, 47, 47, 21, 21, 16, 47, 4, 16, 8, 4, 21, 12, 8, 21, 47, 21, 4, 12, 21, 47, 47, 47, 21, 8, 4, 16, 47, 21, 16, 21, 16, 47, 16, 47, 21, 4, 12, 8, 4, 47, 4, 8, 21, 12, 47, 8, 21, 4, 47, 16, 21, 16, 8, 8, 4, 12, 12, 16, 21, 16, 16, 21, 47, 12, 4, 4, 4, 8, 12, 12, 12, 8, 12, 16, 12, 21, 8, 47, 47, 16, 21, 47, 12, 4, 47, 16, 16, 8, 16, 16, 12, 4, 8, 4, 12, 8, 8, 4, 8]

  
  def embed
    @page = get_page
  end

  def home
    @user = User.new
  end

  def begin

    if current_user.nil?
      u = User.new params[:user]
      u.code = SecureRandom.base64(10)
      u.browser = browser.to_s
      u.save

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
    
    total_count = User.where('initial_interface is not null').count
    ribbon_count = User.where(:initial_interface => 'ribbon').count
    if ribbon_count > (total_count/2.0).floor
      session[:ribbon] = false
      current_user.update_attributes :initial_interface => 'commandmap'
    else
      session[:ribbon] = true
      current_user.update_attributes :initial_interface => 'ribbon'
    end
    
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
    @task = Task.new

    render layout: "office"
  end
  
  def commandmaps
    @button = get_button
    render :layout => false
  end

  def task_complete

    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button = get_button
    block = get_block position
    tab_hash = {"home" => 0, "review" => 1, "insert" => 2, "layout" => 3, "view" => 4}
    parent_switch = false
    new_tab_index = tab_hash[button.parent]
    parent_switch = true unless new_tab_index == session[:tab_index]
    session[:tab_index] = tab_hash[button.parent]
    


    Task.create time: params[:task][:time], menu: get_menu, block: block, button_id: button.id, bad_clicks: params[:task][:errors], position: position, user_id: current_user.id, parent_switch: parent_switch
    session[:progress] = session[:progress] + 1

    @button = get_button session[:progress]
    @tab_index = session[:tab_index]
    @remaining = block_size

    return render json: { status: 'complete', url: survey_url } if next_round? or experiment_complete?
    return render json: { status: 'next', button: @button }

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
    @user = current_user
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
    task_set_array = [@@tasks_1,@@tasks_2].shuffle
    session[:r_commands] = task_set_array[0]
    session[:cm_commands] = task_set_array[1]
  end

  def get_block n
    return "familiarization" if n < FAMILIAR_TASKS_COUNT
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

  def get_button progress= session[:progress]

    return Button.find session[:r_commands][progress] if session[:ribbon]
    Button.find session[:cm_commands][progress]
  end

end
