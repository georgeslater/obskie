class PlaylistsController < ApplicationController
  
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create]
  after_action :allow_spotify_iframe

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
    @playlist.user_id = current_user.id
    @playlist.save
    
    if @playlist.spotify_uri.present?
        SpotifyPlaylistJob.new.perform(@playlist)
    end
    
    respond_with(@playlist)
    
  end

  def update
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
      params.require(:playlist).permit(:spotify_uri, :blurb)
    end

    def allow_spotify_iframe
      response.headers['X-Frame-Options'] = 'ALLOW-FROM https://developer.spotify.com'
    end

end
