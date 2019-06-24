require 'sinatra'
require 'slim'
require 'bcrypt'
require 'sqlite3'
require_relative 'model.rb'
include Model

enable :sessions

# Displays landing page
#
get('/') do
  skin_number = "1"
  slim(:index,locals:{skin_number:skin_number})
end

get('/css/theme/:skin_number') do
  css_file = File.read("/css/theme/#{skin_number}" + ".css")
  #css-variabler
  return css_file
end

# Displays a login form
#
post('/login') do 
   username = params["username"].to_s
   password = params["password"].to_s
   if login(username,password) == true
    redirect("/main")
   else
    redirect("/error")    
  end

end

# Displays a register form
#
post('/register') do 
  username = params["username"].to_s
  password = params["password"].to_s
  if register(username,password) == true
    redirect("/main")
  else
    redirect("/error")   
 end

end

# Displays an register form
#
get('/register') do 
   slim(:register)
end

# Displays an error message
#
get('/error') do 
   slim(:error)
end

# Displays an login form
#
get('/login') do 
   slim(:login)
end

# Displays main page with buy/sell
#
get('/main') do 
   slim(:main)
end



