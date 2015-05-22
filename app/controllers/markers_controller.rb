class MarkersController < ApplicationController

  def create
    if map_id.blank? 
      @map = Map.new
    else
      @map = Map.find(map_id)
    end
    @marker = @map.markers.build(marker_params)
    if @marker.save
      redirect_to @map
    else
      redirect_to root_url
    end
  end
  def marker_params
    params.require(:marker).permit(:latitude,:longtitude, :photo,:description)
  end
  def map_id
    map_status = params.require(:marker).permit(:map_id)
    if !map_status.empty?
      params.require(:marker).fetch(:map_id)
    else
      params.require(:marker).permit(:map_id)
    end
  end
  def destroy
    @marker = Marker.find(params[:id])
    @map = Map.find(@marker.map_id)
    @marker.destroy
    if @map.markers.count != 0
      redirect_to @map
    else
      redirect_to root_url
    end
  end
end
