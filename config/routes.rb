Rails.application.routes.draw do
  # Routes for the Response resource:

  # CREATE
  post("/insert_response", { :controller => "responses", :action => "create" })
          
  # READ
  get("/responses", { :controller => "responses", :action => "index" })
  
  get("/responses/:path_id", { :controller => "responses", :action => "show" })
  
  # UPDATE
  
  # post("/modify_response/:path_id", { :controller => "responses", :action => "update" })
  
  # DELETE
  # get("/delete_response/:path_id", { :controller => "responses", :action => "destroy" })

  #------------------------------

  get("/", { :controller => "questions", :action => "index" })
  # Routes for the Question resource:

  # CREATE
  post("/insert_question", { :controller => "questions", :action => "create" })
          
  # READ
  get("/questions", { :controller => "questions", :action => "index" })
  
  get("/questions/:path_id", { :controller => "questions", :action => "show" })
  
  # UPDATE
  
  post("/modify_question/:path_id", { :controller => "questions", :action => "update" })
  
  # DELETE
  get("/delete_question/:path_id", { :controller => "questions", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
