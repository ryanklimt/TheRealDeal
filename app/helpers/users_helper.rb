module UsersHelper
  
  # Returns the Gravatar for the given user
  def gravatar_for(user, size = 60)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar", :size => size.to_s )
  end
  
  
  # This is extremely jank
  def user_profile(user)
    "/" + user.username
  end
  
  def capfirst(str)
    str = str.slice(0,1).capitalize + str.slice(1..-1)
  end
  
end
