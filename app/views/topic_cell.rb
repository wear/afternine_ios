class TopicCell < UITableViewCell
  attr_accessor :topic
  extend IB

  outlet :topic_imageview
  outlet :comment_label

end