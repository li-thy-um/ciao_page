require 'rails_helper'

RSpec.describe User, type: :model do
	fixtures :users
	before(:each) do
		@user = users(:test)
		@user.password = @user.password_confirmation = 'password_another'
	end

	it 'is valid with correct info' do
		expect(@user.valid?).to be_truthy
	end

	it 'is invalid with blank password' do
		@user.password = @user.password_confirmation = ' ' * 6
		expect(@user.valid?).to be_falsey
	end

	it 'is invalid with invalid confirmation password' do
		@user.password_confirmation = 'password_confirmation'
		expect(@user.valid?).to be_falsey
	end

	it 'is invalid with short password' do
		@user.password = @user.password_confirmation = 'p' * 5
		expect(@user.valid?).to be_falsey
	end

	it 'is invalid with too long name' do
		@user.name = 'a' * 51
		expect(@user.valid?).to be_falsey
	end

	it 'is invalid with too long email' do
		@user.email = 'a' * 244 + '@example.com'
		expect(@user.valid?).to be_falsey
	end

	it 'is valid with correct format of email' do
		emails = %w[USER@foo.com name_bar@foo.bar.me first.last@BIG.ORG]
		emails.each do |email|
			@user.email = email
			expect(@user.valid?).to be_truthy
		end
	end

	it 'is invalid with incorrent format of email' do
		emails = %w[a@b user.example.com user*@email.com]
		emails.each do |email|
			@user.email = email
			expect(@user.valid?).to be_falsey
		end
	end
end
