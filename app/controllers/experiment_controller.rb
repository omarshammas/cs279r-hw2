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
    session[:commandset] = set
    familiar = generate_familiarization_set set
    performance = generate_performance_set set
    session[:commands] = familiar + performance
    session[:progress] = 0

    redirect_to task_url
  end

  def intermediate 
  end

  def task
    session[:progress] += 1
    @button = session[:commands][session[:progress]]

    render layout: "office"
  end

  def task_complete

    return redirect_to intermediate_url, notice: "Time to complete #{params[:time]} s with #{params[:errors]} errors."

    #:block, :button, :errors, :position, :time, :user_id
    position = session[:progress]
    button = session[:commands][position]
    block = get_block position
    Task.create time: params[:time], block: block, button: button, errors: params[:errors], position: position, user_id: current_user.id

    redirect_to intermediate_url
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

  end

  def generate_familiarization_set set
    trials = 5
    #randomize 
  end


  def generate_performance_set set
    trials = 15
    #randomize 
  end

  def get_block n
    return "familiarization" if n >= 30
    "performance"
  end

end
