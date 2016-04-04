require 'rails_helper'

RSpec.describe Article, type: :model do
	before(:each) do
	  @article = Article.create(title: 'title',
	  											 		author: 'platokon',
	  											 		content: <<-EOF.gsub(/^\s+|/, ''))
	  											 			|##title
	  											 			|here is some content 
	  											 		EOF
	end

	it 'is valid with correct content' do
		expect(@article.valid?).to be_truthy
	end

	it 'is invalid with blank title' do
		@article.title = ' ' * 10
		expect(@article.valid?).to be_falsey
	end

	it 'should contains script tag' do
		@article.content += "\n<script>alert(0)</script>"
		@article.save
		expect(@article.content_html).not_to match(/<script>|<\/script>/)
	end
end
