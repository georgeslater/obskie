class PlaylistsController < ApplicationController
  
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create]

  respond_to :html

  def index
    @playlists = Playlist.all
    respond_with(@playlists)
  end

  def show
    respond_with(@playlist)
  end

  def new
    @playlist = Playlist.new
    respond_with(@playlist)
  end

  def edit
  end

  def create
    @playlist = Playlist.new(playlist_params)
    flash[:notice] = 'Playlist was successfully created.' if @playlist.save
    respond_with(@playlist)
  end

  def update
    flash[:notice] = 'Playlist was successfully updated.' if @playlist.update(playlist_params)
    respond_with(@playlist)
  end

  def destroy
    @playlist.destroy
    respond_with(@playlist)
  end

  private
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    def playlist_params
      params[:playlist]
    end
end
