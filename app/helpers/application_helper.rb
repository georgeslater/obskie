module ApplicationHelper

def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def get_pending_submission_count

  	Album.where("published = true AND workflow_state != 'accepted'").count
  end
	
end
