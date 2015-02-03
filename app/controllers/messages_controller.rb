class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token  

  # GET /messages
  # GET /messages.json
  def index
    #{:symbol => 'value'}  = old way, but needed for where syntax containing restrictions
    #{symbol: 'value'} = new way
    #params.require(:last_received_at)

    last_received_at = params[:last_received_at].blank? ? 10.minutes.ago : params[:last_received_at]
    puts last_received_at.inspect

    @rooms = Room.all

    #make a change to include room id if one is given
    @messages = Message.where("created_at > ?", last_received_at.to_time.utc.iso8601)
    @message_json = @messages.to_json
    respond_to do |format|
      format.html {
        @message = Message.new
      }
      format.json {
        render status: 200, data: @message_json
      }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.author_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:room_id, :author_id, :body)
    end
end
