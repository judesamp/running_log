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
   
    context "the last week filter" do
    	let(:run1) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today, run_time: 45, distance: 3.8)) }
    	let(:run2) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 1, run_time: 45, distance: 3.8)) }
    	let(:run3) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 8, run_time: 65, distance: 5.8)) }

    	it "should return all user runs that match filter (last_seven)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "last_seven" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should return all user runs that match filter (weekly)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "weekly" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should not return all user runs that do not match filter" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "last_seven" }, :format => "js"
    		expect(assigns(:filtered_runs)).to_not include run3
  		end

  	end

  	context "the last month filter" do
  		let(:run1) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today, run_time: 45, distance: 3.8)) }
    	let(:run2) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 1, run_time: 45, distance: 3.8)) }
    	let(:run3) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 32, run_time: 65, distance: 5.8)) }


    	it "should return all user runs that match filter (last_thirty)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "last_thirty" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should return all user runs that match filter (monthly)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "monthly" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should not return all user runs that do not match filter" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "last_thirty" }, :format => "js"
    		expect(assigns(:filtered_runs)).to_not include run3
  		end

  	end

  	context "the last year filter" do
    	let(:run1) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today, run_time: 45, distance: 3.8)) }
    	let(:run2) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 1, run_time: 45, distance: 3.8)) }
    	let(:run3) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 366, run_time: 65, distance: 5.8)) }


    	it "should return all user runs that match filter (year)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "year" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should return all user runs that match filter (monthly)" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "yearly" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2]
    	end

    	it "should not return all user runs that do not match filter" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "year" }, :format => "js"
    		expect(assigns(:filtered_runs)).to_not include run3
  		end
  	end

  	context "the lifetime filter" do

  		let(:run1) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today, run_time: 45, distance: 3.8)) }
    	let(:run2) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 1, run_time: 45, distance: 3.8)) }
    	let(:run3) { user.runs.create!(FactoryGirl.attributes_for(:run, run_date: Date.today - 366, run_time: 65, distance: 5.8)) }

    	it "should return all user runs that match filter" do
    		login(user)
    		xhr :get, :filter, user_id: user, :filter => { :type => "lifetime" }, :format => "js"
    		expect(assigns(:filtered_runs)).to eq [run1, run2, run3]
    	end

  	end

	end

end