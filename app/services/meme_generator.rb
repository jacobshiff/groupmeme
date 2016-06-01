class MemeGenerator

  attr_reader :top_text, :bottom_text, :filetype, :params

  def initialize
    # top_text = params[:top_text]
    # bottom_text = params[:bottom_text]
    # filetype = params[:filetype]
    @params = params
    @filetype = params[:filetype]
  end

  def generate
    case filetype
    
    when "image/gif"

    when nil
      
    when "image/jpeg", "image/png", "image/tiff"
      
    else

    end
  end

  def gif_generate_meme

  end


  def image_generate_meme
  end


end