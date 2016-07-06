module UsersHelper
  def user_avatar_select user
    if user.avatar.exists?
      image_tag user.avatar.url(:small),
        id: "avatar-preview",
        class: "img-responsive img-rounded" 
    else
      image_tag "http://i.imgur.com/OnL5mP2.jpg", 
        id: "avatar-preview",
        class: "img-responsive img-rounded"
    end
  end
end
