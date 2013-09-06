class TopicCell < UITableViewCell
  attr_accessor :topic
  extend IB

  outlet :topic_imageview
  outlet :comment_label

  # def setSelected(selected,animated:animated)
  #   if(selected)
  #   end
  #   super
  # end

end