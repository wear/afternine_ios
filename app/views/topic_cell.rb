class TopicCell < UITableViewCell
  attr_accessor :topic
  extend IB

  outlet :topic_imageview
  outlet :comment_label
  outlet :main_view

  def layoutSubviews 
    super
  end

  def setup_with_topic(topic)
    main_view.layer.cornerRadius = 3
    main_view.layer.masksToBounds = true 
    main_view.layer.borderColor = '#cdcfcd'.to_color.CGColor
    main_view.layer.borderWidth = 0.5

    image_url = NSURL.URLWithString("#{topic['image']['small']}")
    topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.png"))
    # topic_imageview.image = UIImage.imageNamed("placeholder.png")
    comment_label.text = topic['comment']    
  end

end