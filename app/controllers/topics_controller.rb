class TopicsController < UITableViewController
  extend IB

  attr_accessor :current_topic

  def awakeFromNib
    @topics ||= []
  end  

  def viewDidLoad
    NSLog('sss')
    SVProgressHUD.showWithStatus '正在同步数据，请稍侯'

    url = NSURL.URLWithString 'http://localhost:3000/topics.json'
    request = NSURLRequest.requestWithURL url
    error = Pointer.new_with_type("@")
    operation = AFJSONRequestOperation.JSONRequestOperationWithRequest(request,
      success:->(request,response,jsonData) {
        SVProgressHUD.dismiss
        @topics = jsonData
        self.tableView.reloadData
    },failure:nil)

    operation.start

  end

  #　datasource协议实现
  def tableView(tableView, numberOfRowsInSection:section)
    @topics.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "TopicItemCell"
    
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    topic = @topics[indexPath.row]
    cell.textLabel.text = topic['kind'] == 'text' ? topic['text'] : topic['title']

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    NSLog indexPath.row.to_s
    @current_topic = @topics[indexPath.row] 
    self.performSegueWithIdentifier('topic_detail',sender:nil)
  end

  def prepareForSegue(segue, sender:sender)
    case segue.identifier
    when "topic_detail"
      segue.destinationViewController.topic = @current_topic
    end
  end

end