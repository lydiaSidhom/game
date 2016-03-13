module ApplicationHelper

def full_title(page_title = '')
	base_title = "TrafficLess"
	if page_title.empty?
		base_title
	else
		"#{page_title} | #{base_title}"
	end
end

def avatar_url(user)
gravatar_id = Digest::MD5::hexdigest(user.email).downcase
"http://gravatar.com/avatar/#{gravatar_id}.png"
end

end
