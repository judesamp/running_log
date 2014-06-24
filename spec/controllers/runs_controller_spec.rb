require 'spec_helper'

describe RunsController do
	let(:user) { FactoryGirl.create(:user) }
	let(:run) { FactoryGirl.create(:run) }

	describe "GET #index" do

		it "should assign the current user's runs to @runs" do
			login(run.user)
			get :index, user_id: run.user.id
			expect(assigns(:runs)).to include run
		end

		it "should assign the current user's runs count to @run_count" do
			login(run.user)
			get :index, user_id: run.user.id
			expect(assigns(:run_count)).to eq 1
		end

		it "should assign the current_user to @user" do
			login(run.user)
			get :index, user_id: run.user.id
			expect(assigns(:current_user)).to eq run.user
		end

		#still to do: text javascript, json responses

	end

	describe "GET #new" do

		it "should assign a new run to @run" do
			login(user)
			get :new, user_id: user.id
			expect(assigns(:run)).to be_a_new(Run)
		end
	end

	describe "POST #create" do

		it "should create a new run" do
			login(user)
			@run_attributes = FactoryGirl.attributes_for(:run, :user_id => user.id)
			expect{
     	  post :create, user_id: user, run: @run_attributes
      }.to change(Run, :count).by(1)
    end

    it "should redirect to the user runs path" do
    	login(user)
			@run_attributes = FactoryGirl.attributes_for(:run, :user_id => user.id)
     	post :create, user_id: user, run: @run_attributes
     	response.should redirect_to user_runs_path(user)
    end

	end

	describe "GET #show" do

		it "should assign the appropriate run to @run" do
			login(run.user)
			get :show, user_id: run.user.id, id: run
			expect(assigns(:run)).to eq run
		end

		it "should redirect to user runs path" do
			login(run.user)
			get :show, user_id: run.user.id, id: run
			response.should redirect_to user_runs_path(run.user)
		end

	end

	describe "GET #edit" do

		it "should assign the appropriate run to @run" do
			login(run.user)
			get :edit, user_id: run.user.id, id: run
			expect(assigns(:run)).to eq run
		end

	end

	describe "PUT #update" do

		it "should update run with new data" do
			login(run.user)
			put :update, { user_id: run.user.id, id: run, run: FactoryGirl.attributes_for(:run, :distance => 10) }
			updated_run = Run.find(run.id)
			expect(updated_run.distance).to eq 10.0
		end

	end


	describe "DELETE #destroy" do

		it "should delete specified run" do
			login(run.user)
			expect{
	      delete :destroy, user_id: run.user.id, id: run
	    }.to change(Run, :count).by(-1)
	  end

	  it "should delete specified run" do
			login(run.user)
	    delete :destroy, user_id: run.user.id, id: run
	    response.should redirect_to user_runs_path(run.user)
	  end

	end

	describe "GET #filter" do
	end

end

# def edit
#     @run = Run.find(params[:id])
#     respond_to do |format|
#       format.js
#       format.html
#     end
#   end

# @expected = { 
#         :flashcard  => @flashcard,
#         :lesson     => @lesson,
#         :success    => true
# }.to_json
# get :action # replace with action name / params as necessary
# response.body.should == @expected
