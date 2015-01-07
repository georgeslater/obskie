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

  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? ENV['DEFAULT_TITLE'] + ' | ' + content_for(:title) : ENV['DEFAULT_TITLE']
    end
  end
	
def meta_keywords(tags = nil)
    if tags.present?
      content_for :meta_keywords, tags
    else
      content_for?(:meta_keywords) ? [content_for(:meta_keywords), ENV['META_KEYWORDS']].join(', ') : ENV['META_KEYWORDS']
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : ENV['META_DESCRIPTION']
    end
  end

end
