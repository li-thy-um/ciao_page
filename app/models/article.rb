class Article < ActiveRecord::Base
  has_and_belongs_to_many :tags, autosave: true
  validates :title, presence: true
  validates_associated :tags
  before_save { self.content_html = Article.markdown(content) }

  def Article.markdown(text)
  	extensions = {
  		autolink: true,
  		space_after_headers: true,
  		fenced_code_blocks: true,
  		no_intra_emphasis: true,
  		hard_wrap: true,
  		strikethrough: true
  	}
  	renderer = Redcarpet::Markdown.new(HTMLwithCodeRay, extensions)
  	html = renderer.render(text).html_safe
    html.gsub(/<script>/,'&lt;script&gt;')
    html.gsub(/<\/script>/,'&lt;/script&gt;')
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
  	def block_code(code, language)
  		CodeRay.scan(code, language).div(:tab_width => 2)
  	end
  end  
end
