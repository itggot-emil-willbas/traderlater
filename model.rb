module Model

  # Makes a connection to database
  # @return [Hash]
  # * db [Hash] The database as a Hash
  def connect()
    db = SQLite3::Database.new('db/database.db')
    db.results_as_hash = true
    return db
  end

  # Attempts to login user
  # 
  # @param [String] username The username
  # @param [String] password The password
  def login(username,password)
    db = connect()
    puts username 
    puts password
    hashed_password = get_hashed_password(username)
    if BCrypt::Password.new(hashed_password) == password
      #insert session here!
      return true
    else
      return false
    end
    
  end

  # Get the hashed password given a certain username
  #
  # @param [String] username The username
  # @return [String] 
  # * hashed_password [String] The hashed (by BCrypt) password
  def get_hashed_password(username)
    db = connect()
    hashed_password = db.execute("SELECT hashed_password FROM user WHERE username = ?",username)
    hashed_password = hashed_password.first["hashed_password"]
    return hashed_password
  end
  
  # Attempts to register user
  # 
  # @param [String] username The username
  # @param [String] password The password
  def register(username,password)
    db = connect()
    hashed_password = BCrypt::Password.create(password)
    insert_new_user(username,hashed_password)
    #Insert validateion/error-hantering here!
    return true
    
  end

  # This function inserts values to database
  #
  # @param [String] tablename The name of the table
  # @param [String] column The name of the column
  # @param [String] value The value
  def insert_new_user(username,hashed_password)
    db = connect()
    db.execute("INSERT INTO user(username,hashed_password) VALUES(?,?)",username,hashed_password)


  end



  

end