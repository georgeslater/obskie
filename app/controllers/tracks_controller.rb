class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tracks = Track.all
    respond_with(@tracks)
  end

  def show
    respond_with(@track)
  end

  def new
    @track = Track.new
    respond_with(@track)
  end

  def edit
  end

  def create
    @track = Track.new(track_params)
    @track.save
    respond_with(@track)
  end

  def update
    @track.update(track_params)
    respond_with(@track)
  end

  def destroy
    @track.destroy
    respond_with(@track)
  end

  private
    def set_track
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:name, :album_id, :order)
    end
end
