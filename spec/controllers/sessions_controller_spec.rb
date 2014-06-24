require 'spec_helper'

describe SessionsController do
	let(:user) { FactoryGirl.create(:user)}
	
	describe 'POST #create' do

		it 'should create a new session if credentials valid' do
			login(user)
			(session[:user_id]).should_not be_nil
		end

	end

	describe 'DELETE #destroy' do

		it "should destroy a session" do
			logout(user)
			(session[:user_id]).should be_nil
		end

	end

end