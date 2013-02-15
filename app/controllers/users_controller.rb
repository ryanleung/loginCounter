class UsersController < ApplicationController

  def login
    inputUser = params[:user]
    inputPassword = params[:password]
    errCode = User.login(inputUser, inputPassword)
    if errCode < 0
      @jsonObj = { :errCode => errCode}
    else
      user = User.where(:user=>inputUser)[0]
      @jsonObj = { :errCode => errCode, :count => user.count }
    end
    respond_to do |format|
      format.json { render :json => @jsonObj }
    end
  end
    
  def add
    inputUser = params[:user]
    inputPassword = params[:password]
    errCode = User.add(inputUser, inputPassword)
    if errCode < 0 
      @jsonObj = { :errCode => errCode }
    else
      user = User.where(:user=>inputUser)[0]
      @jsonObj = { :errCode => errCode, :count => user.count }
    end
    respond_to do |format|
      format.json { render :json => @jsonObj }
    end
  end

  def resetFixture
    errCode = User.resetFixture
    @jsonObj = {:errCode => errCode}
    respond_to do |format|
      format.json { render :json => @jsonObj }
    end
  end
  
  def unitTests
    `rspec > unit.txt`
    fileOutput = File.read("unit.txt")
    test_match = fileOutput[/(.*)example/, 1]
    fail_match = fileOutput[/,(.*)failure/, 1]
    respond_to do |format|
      format.json { render :json => { :totalTests => test_match.to_i, :nrFailed => fail_match.to_i, :output => 'Tests run successfully' }}
    end
  end 
      
      
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
