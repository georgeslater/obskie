class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def become_contributor
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    @contact.subject = "I want to be a contributor!!"

    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      render :new
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end