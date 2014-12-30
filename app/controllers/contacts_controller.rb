class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def become_contributor
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])

    if @contact.name.nil?

      @contact.name = current_user.username+" - Contributor request"
      @contact.email = current_user.email
    end

    @contact.request = request

    @contact.deliver!
    redirect_to root_path
  end
end