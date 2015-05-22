class MapsController < ApplicationController
  def new
      @map = Map.new
      @marker  = @map.markers.build
  end

  def index
     Map.where("created_at <= ?",(Time.now.midnight - 30.day)).limit(100).each do |map|
      map.destroy
     end
  end

  def show
    @map = Map.find(params[:id])

    # Получение массива щироты и долготы
    latitudes = []
    longtitudes = []
    @map.markers.each do |marker|
        latitudes = latitudes + [marker.latitude]
        longtitudes = longtitudes + [marker.longtitude]
    end
    ######################################

    ### Получение средней широты и долготы
    @avg_latitude = (latitudes.max + latitudes.min)/2
    @avg_longtitude = (longtitudes.max + longtitudes.min)/2
    # longtitude - [-180;180]
    # latitude - [-90;90]
    ########################################
    

    ## Подсчет масштаба
    del_latitudes = latitudes.max - latitudes.min
    del_longtitudes = longtitudes.max - longtitudes.min

    if del_latitudes < 90 && del_longtitudes < 180
      if del_latitudes < 45 && del_longtitudes < 90
        if del_latitudes < 22 && del_longtitudes < 45
          if del_latitudes < 11 && del_longtitudes < 12
            if del_latitudes < 5 && del_longtitudes < 6
              if del_latitudes < 2 && del_longtitudes < 3
                if del_latitudes < 1 && del_longtitudes < 1
                  if del_latitudes < 0.5 && del_longtitudes < 0.5
                    @scale = 12
                  else
                    @scale = 10
                end
                else
                  @scale = 9
                end
              else
                @scale = 8
              end
            else
              @scale = 7
            end
          else
            @scale = 6
          end
        else 
          @scale = 5
        end
      else
        @scale = 4
      end
    else
      @scale = 3
    end
  
  end

  def destroy
     @map = Map.find(params[:id])
     @map.destroy
     redirect_to root_url
  end

  def edit
    @map = Map.find(params[:id])
    @marker  = @map.markers.build
  end
end
