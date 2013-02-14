class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user, :password, :count
  #def initialize(name, password, loginCount)
    #@name = name
    #@password = password
    #@loginCount = loginCount
  #end
  validates :user, :presence => true,
		   :length => { :maximum => 128},
		   :uniqueness => true
  validates :password, :length => { :maximum => 128}

  def self.login(inputUser,inputPassword)
    inputtedPassword = inputPassword
    if not User.exists?(inputUser)
      #ERR_BAD_CREDENTIALS -1
      return -1
    end
    user = User.where(:user => inputUser)
    if user.password != inputPassword
      #ERR_BAD_CREDENTIALS
      return -1
    end
    user.count += 1
    user.save
    return user.count
  end

  def self.add(inputUser,inputPassword)
    inputtedUsername = inputUser
    inputtedPassword = inputPassword
    if inputtedUsername == nil
      return -3
    end
    if User.exists?(:user => inputtedUsername)
      #ERR_USER_EXISTS
      return -2
    end
    if inputtedUsername.length == 0 or inputtedUsername.length > 128
      #ERR_BAD_USERNAME
      return -3
    end
    if inputtedPassword.length > 128
      #ERR_BAD_PASSWORD
      return -4
    end
    newUser = User.new("user"=>inputtedUsername, "password"=>inputtedPassword)
    newUser.save
    return 1
  end

  def self.resetFixture
    User.delete_all
    return 1
  end
  

end
