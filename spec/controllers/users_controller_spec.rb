require 'spec_helper'

describe UsersController do
	let(:user) { FactoryGirl.create(:user)}
	let(:invalid_user) { FactoryGirl.create(:invalid_user)}

	describe "GET #new" do

		it "renders the new template" do
			get :new
			response.should render_template(:new)
		end

	end

	describe "POST #create" do

		it 'should create a new user' do
			expect{
        post :create, user: FactoryGirl.attributes_for(:user)
      }.to change(User, :count).by(1)
		end

		it "should log the user in after creation" do
			post :create, user: FactoryGirl.attributes_for(:user)
			(session[:user_id]).should_not be_nil

		end

		it 'should redirect to the runs index page' do
			post :create, user: FactoryGirl.attributes_for(:user)
			response.should redirect_to user_runs_path(User.last)
		end

	end

end