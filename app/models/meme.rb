class Meme < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  has_many :meme_tags
  has_many :tags, through: :meme_tags
  has_many :reactions
  belongs_to :group

  #paperclip validations; must include for upload
  #POST PROCESSING ADDS ABOUT 50% MORE TIME TO UPLOAD. DELAYED PROCESSING??
  has_attached_file :image, styles: { thumb: ["340"] } 
  before_post_process :skip_for_gif

  # This did not result in any performance improvements...
  # process_in_background :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  #I dont' beleive this is working... return to correct?
  def skip_for_gif
    ! %w(image/gif).include?(image_content_type)
  end

  def update_reactions(user)
    user_reacted?(user) ? unreact(user) : react(user)
  end

  def reactions_message(user)
    if !user_reacted?(user)
      message_helper.html_safe
    else
      other_message_helper.html_safe
    end
  end

  def message_helper
    num = self.reactions.count
    if num > 1
      "<strong>#{num} people</strong> like this"
    elsif num == 0
      "Be the first to like this"
    else
      "<strong>#{num} person</strong> likes this"
    end
  end

  def other_message_helper
    num = self.reactions.count - 1
    if num == 1
      "<strong>You</strong> and <strong>1 other person </strong> like this"
    elsif num == 0
      "<strong>You</strong> like this"
    else
      "<strong>You</strong> and <strong>#{num} other people</strong> like this"
    end
  end

  def heart_class(user)
    #no longer a heart, should probably rename
    if user_reacted?(user)
      "fa fa-thumbs-up"
    else
      "fa fa-thumbs-o-up"
    end
  end

  #MEME DOWNSIZING
  def self.generate_meme(image_uri, filetype_full, filetype, top_text, bottom_text)
    begin
    tempfile = Tempfile.new(['downscaled', filetype]) 
    url = self.decode_base64_image(image_uri, filetype_full, filetype, tempfile).path
    self.create_meme(url, top_text, bottom_text, filetype)
    ensure
      tempfile.unlink #deletes the tempfile
    end
  end

  def self.decode_base64_image(image_uri, filetype_full, filetype, tempfile)
    decoded_data = Base64.decode64(image_uri["data:#{filetype_full};base64,".length .. -1])
    tempfile.binmode
    tempfile.write(decoded_data)
    tempfile.close
    return tempfile
  end

  # GIF processing

  def self.create_meme(url, top_text, bottom_text, filetype)
    open(url, 'rb') do |f|
      i = MemeCaptain.meme(f, [
        MemeCaptain::TextPos.new(top_text, 0.10, 0.10, 0.80, 0.20,
          :fill => 'white', :font => 'Impact-Regular'),
        MemeCaptain::TextPos.new(bottom_text, 0.10, 0.70, 0.80, 0.2,
          :fill => 'white', :font => 'Impact-Regular'),
        # MemeCaptain::TextPos.new('test', 10, 10, 50, 25)
        ])
      # i.write(output_meme.path + 'output' + filetype)
      i.write('temporary_meme' + filetype)
      #can set type to be that of the input
    end
  end

  #needed for nest attributes... added tag
  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_name|
      tag_name.values.each do |tag|
        tag.split(", ").each do |name|
          tag = Tag.find_or_create_by(name: name)
          tag.slug = tag.to_slug
          tag.save
          self.tags << tag
        end
      end
    end
  end

  #adds tags (by slug) to card classes
  def tag_class_list
    tags = self.tags.collect{|tag| tag.slug}
    tags.join(" ")
  end

  #destroy tag relationships when destroying self
  def destroy_tags
    self.meme_tags.each{|mt| mt.destroy}
  end

  private
  def user_reacted?(user)
    self.reactions.where(user: user).any?
  end

  def react(user)
    self.reactions.create(user_id: user.id)
  end

  def unreact(user)
    self.reactions.find_by(user_id: user.id).destroy
  end

end
