class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username

  after_create :skip_conf!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :albums
  has_many :comments
  has_many :playlists

	validates :username,
  		:uniqueness => {
    	:case_sensitive => false
  		},
      :length => {
        minimum: 1,
        maximum: 25
      }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :avatar,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  do_not_validate_attachment_file_type :avatar
  
  def skip_conf!
    self.confirm! if Rails.env.development?
  end

  def forem_name
    username
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def forem_avatar
    unless self.avatar.nil?
      self.avatar
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    
    #this is a nasty hack, but it's the only way I've been able to solve http://stackoverflow.com/questions/26695166/devise-activemodelforbiddenattributeserror-when-sending-reset-password-instr
    begin  
      conditions = warden_conditions.permit!.dup

    rescue NoMethodError

      conditions = warden_conditions.dup
    end

    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
end

end
