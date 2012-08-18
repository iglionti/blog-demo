class Author::Image < Attachment
  has_attached_file :attachment,
    :url => "/system/:class/:attachment/:id_partition/:style/:id.:extension",
    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:id.:extension",
    :styles => {:large => "188x188",
    :small => "115x95", :thumb => "16x16"},
    :default_url => APP_CONFIG["urlserver"] + "/images/no_image.png"
end
