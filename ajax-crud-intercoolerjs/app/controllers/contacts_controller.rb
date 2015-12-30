class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
    render :layout => params['ic-request'].blank?
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    render :layout => params['ic-request'].blank?
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    render :layout => params['ic-request'].blank?
  end

  # GET /contacts/1/edit
  def edit
    # Set browser URL to /contacts/1/edit
    headers['X-IC-SetLocation'] = edit_contact_path(@contact)
    render :layout => params['ic-request'].blank?
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:notice] = 'Created Contact'
      # Set browser URL to /contacts/1
      headers['X-IC-SetLocation'] = contact_path @contact
      render action: :show, :layout => params['ic-request'].blank?      
    else
      flash[:error] = 'Could not create Contact'
      render action: :new, :layout => params['ic-request'].blank?
    end

  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if @contact.update(contact_params)
      flash[:notice] = "Updated Contact"
      # Set browser URL to /contacts/1
      headers['X-IC-SetLocation'] = contact_path(@contact)
      render action: :show, :layout => params['ic-request'].blank?
    else
      flash[:error] = "Could not update Contact"
      render action: :edit, :layout => params['ic-request'].blank?
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:firstname, :lastname, :email)
    end
end
