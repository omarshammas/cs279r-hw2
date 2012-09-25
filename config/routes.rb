CommandMaps::Application.routes.draw do

  get "/embed" => "experiment#embed"
  get "/home" => "experiment#home", as: :home
  post "/begin" => "experiment#begin", as: :begin

  get "/instructions_ribbon" => "experiment#instructions_ribbon", as: :instructions_ribbon
  get "/instructions_commandmaps" => "experiment#instructions_commandmaps", as: :instructions_commandmaps

  get "/commandmaps" => "experiment#commandmaps", as: :commandmaps
  get "/task" => "experiment#task", as: :task
  post "/task_complete" => "experiment#task_complete", as: :task_complete
  post "/task_complete_ajax" => "experiment#task_complete_ajax", as: :task_complete_ajax
  
  get "/survey" => "experiment#survey", as: :survey
  post "/nasatlx" => "experiment#nasatlx", as: :nasatlx
  get "/thank_you" => "experiment#thank_you", as: :thank_you
  get "/results" => "experiment#results", as: :results

  root :to => "experiment#embed"

end
