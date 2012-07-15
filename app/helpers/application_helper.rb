module ApplicationHelper
	def full_title(page_title)
		base_title="Perfect Trax"
		base_title if page_title.empty? 
		"#{base_title} | #{page_title}"
	end
end
