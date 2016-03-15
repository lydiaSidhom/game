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
    default_url = "#{root_url}assets/images/profile.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
end

end
