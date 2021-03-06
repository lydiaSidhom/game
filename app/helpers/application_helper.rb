module ApplicationHelper

def full_title(page_title = '')
	base_title = "Greenie"
	if page_title.empty?
		base_title
	else
		"#{page_title} | #{base_title}"
	end
end

def avatar_url(user)
    #default_url = "#{root_url}assets/images/profile.png"
    #default_url="http://tr3.cbsistatic.com/fly/360-fly/bundles/techrepubliccore/images/icons/standard/icon-user-default.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    #"http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=https://ask.libreoffice.org/m/default/media/images/nophoto.png?v=20"
    "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=120&d=identicon"
end

end
