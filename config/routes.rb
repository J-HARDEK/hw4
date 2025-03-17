Rails.application.routes.draw do
  
  # Login/logout
  get("/login", { :controller => "sessions", :action => "new" })
  get("/logout", { :controller => "sessions", :action => "destroy" })

  get("/", { :controller => "places", :action => "index" })
  resources "entries"
  resources "places"
  resources "sessions"
  resources "users"

end
