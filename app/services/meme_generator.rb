class MemeGenerator

  attr_reader :top_text, :bottom_text, :filetype, :params, :tag_params, :group_slug, :title, :current_user, :url, :filetype_extension, :image_uri, :image_size
  attr_accessor :url

  def initialize(params, tag_params, current_user)
    @filetype = params[:filetype]
    @top_text = params[:top_text]
    @bottom_text = params[:bottom_text]
    @tag_params = tag_params
    @title = params[:meme][:title]
    @group_slug = params[:group_slug]
    @current_user = current_user

    case filetype

    when "image/gif"
      @url = params[:meme][:image].tempfile.path
      @filetype_extension = '.' + self.filetype.split('/').last
      @image_size = params[:meme][:image].size / 1000000.0 
    when nil
      @url = "https://s3.amazonaws.com/groupmeme/paired-programming.gif"
      @filetype_extension = '.gif'
    when "image/jpeg", "image/png", "image/tiff"
      @image_uri = params[:images][0]
      @filetype_extension = '.' + self.filetype.split('/').last
    end

  end

  def generate
    case filetype
    when "image/gif"
      generate_meme_gif
    when nil
      generate_meme_default
    when "image/jpeg", "image/png", "image/tiff"
      generate_meme_static
    else
      generate_meme_error
    end
  end

  def generate_meme_gif
    if image_size > 5
      return {meme: nil, notice: "The maximum upload size is 5 MB"}
    else
      create_meme_image #this will dump a meme image into root directory
      new_meme = create_meme_object
      return {meme: new_meme, notice: ""}
    end
  end

  def generate_meme_default
    create_meme_image
    new_meme = create_meme_object
    return {meme: new_meme, notice: ""}
  end

  def generate_meme_static
    generate_downsized_meme_image #this will dump a meme image into root directory
    new_meme = create_meme_object
    return {meme: new_meme, notice: ""}
  end

  def generate_meme_error
    return {meme: nil, notice: "This is not a valid file type"}
  end

  def generate_downsized_meme_image
    begin
      filetype_extension = self.filetype_extension
      tempfile = Tempfile.new(['downscaled', filetype_extension]) 
      self.url = decode_base64_image(tempfile).path
      create_meme_image
      new_meme = create_meme_object
      return {meme: new_meme, notice: ""}
    ensure
      tempfile.unlink #deletes the tempfile
    end
  end

  def decode_base64_image(tempfile)
    filetype = self.filetype
    image_uri = self.image_uri
    decoded_data = Base64.decode64(image_uri["data:#{filetype};base64,".length .. -1])
    tempfile.binmode
    tempfile.write(decoded_data)
    tempfile.close
    return tempfile
  end

  def create_meme_image
    top_text = self.top_text
    bottom_text = self.bottom_text
    open(self.url, 'rb') do |f|
      i = MemeCaptain.meme(f, [
        MemeCaptain::TextPos.new(top_text, 0.10, 0.10, 0.80, 0.20,
          :fill => 'white', :font => 'Impact-Regular'),
        MemeCaptain::TextPos.new(bottom_text, 0.10, 0.70, 0.80, 0.2,
          :fill => 'white', :font => 'Impact-Regular'),
        # MemeCaptain::TextPos.new('test', 10, 10, 50, 25)
        ])
      i.write('temporary_meme' + self.filetype_extension)
    end
  end

  def create_meme_object
    new_meme = Meme.new(self.tag_params)
    new_meme.title = self.title
    new_meme.image = File.open('temporary_meme' + self.filetype_extension)
    new_meme.group = Group.find_by(group_slug: self.group_slug)
    new_meme.creator = current_user
    new_meme
  end

end