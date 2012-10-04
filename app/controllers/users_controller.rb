class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @currently_assigned = User.current_chore_user
    @users = User.order('chore_date DESC')
    if current_user
      @next_chore = Time.now.to_date + (User.where('chore_date < ?', current_user.chore_date).count + 1).days
      @next_chore += 1.day if @next_chore.saturday?
      @next_chore += 1.day if @next_chore.sunday?
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.json { render json: @user }
    @user = User.new
    @user_session = UserSession.new
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
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
    @user.chore_date = Time.now - 1.day

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:users, :notice => 'Registration successfull.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
