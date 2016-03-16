module ApplicationHelper
  def generate_title(title = '')
  	base_title = 'Ciao.moe'
  	if title.strip.empty?
  		base_title
  	else
  		title + ' - ' + base_title
  	end
  end
end
