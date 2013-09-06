class TopicsController < UITableViewController
  extend IB

  attr_accessor :current_topic,:topics

  def awakeFromNib
    @topics = []
  end

  def viewDidLoad
    SVProgressHUD.showWithStatus '正在同步数据，请稍侯'

    url = NSURL.URLWithString "#{AssetHost}/topics.json"
    request = NSURLRequest.requestWithURL url
    error = Pointer.new_with_type("@")
    operation = AFJSONRequestOperation.JSONRequestOperationWithRequest(request,
      success:->(request,response,jsonData) {
        SVProgressHUD.dismiss
        @topics = jsonData['topics']
        self.tableView.reloadData
    },failure:nil)

    operation.start

  end

  #　datasource协议实现
  def tableView(tableView, numberOfRowsInSection:section)
    @topics.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    topic = @topics[indexPath.row]

    @cellIdentifier ||= "topicItemCell"
    cell = tableView.dequeueReusableCellWithIdentifier(@cellIdentifier)

    image_url = NSURL.URLWithString("#{topic['image']['normal']}")
    image_data = NSData.dataWithContentsOfURL(image_url)

    cell.topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.gif"))

    # if topic['image']['content_type'] == 'image/gif'
    #   cell.topic_imageview.image = UIImage.animatedImageWithAnimatedGIFData(image_data)
    # else
    #   cell.topic_imageview.image = UIImage.imageWithData image_data
    # end
    cell.comment_label.text = topic['comment']
    cell
  end

  def tableView(tableView,heightForRowAtIndexPath:indexPath)
    topic = @topics[indexPath.row]
    if topic['image']['height'] > 160
      230 + (topic['image']['height'] - 160)
    end
  end

  # def tableView(tableView, didSelectRowAtIndexPath:indexPath)
  #   @current_topic = @topics[indexPath.row]
  #   # self.performSegueWithIdentifier('topic_detail',sender:nil)
  # end


  # def prepareForSegue(segue, sender:sender)
  #   case segue.identifier
  #   when "topic_detail"
  #     segue.destinationViewController.topic = @current_topic
  #   end
  # end

end