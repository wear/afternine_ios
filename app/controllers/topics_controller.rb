class TopicsController < UITableViewController
  extend IB

  attr_accessor :current_topic,:topics,:current_page,:total_pages,:total_count,:first_topic,:last_topic,:per_page

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
        @first_topic = @topics.first
        @last_topic = @topics.last
        self.tableView.reloadData
    },failure:nil)

    operation.start

    #setup pull-to-refresh
    self.tableView.addPullToRefreshWithActionHandler ->{insertRowAtTop}

    # setup infinite scrolling
    self.tableView.addInfiniteScrollingWithActionHandler ->{insertRowAtBottom}
  end

  # 拉动更新
  def insertRowAtTop
    url = NSURL.URLWithString "#{AssetHost}/topics/before_at.json?target_topic_id=#{@first_topic['id']}"    
    request = NSURLRequest.requestWithURL url
    operation = AFJSONRequestOperation.JSONRequestOperationWithRequest(request,
      success:->(request,response,jsonData) {
        if jsonData['total_count'] != 0
          if jsonData['total_pages'] <= 1 
            @topics = jsonData['topics'] + @topics
            @first_topic = @topics.first

            tableView.beginUpdates
              paths = []
              jsonData['topics'].each_with_index do |topic,index| 
                paths << NSIndexPath.indexPathForRow(index,inSection:0)
              end
              tableView.insertRowsAtIndexPaths paths,withRowAnimation:UITableViewRowAnimationBottom
            tableView.endUpdates
          else
            # 如果条数多于一页就重新加载整个表格
            @topics = jsonData['topics']
            @first_topic = jsonData['topics'].first
            @last_topic = jsonData['topics'].last
            tableView.reloadData
          end
        end
        tableView.pullToRefreshView.stopAnimating
      },failure:nil)
    operation.start
  end

  def insertRowAtBottom
    url = NSURL.URLWithString "#{AssetHost}/topics/after_at.json?target_topic_id=#{@last_topic['id']}"
    request = NSURLRequest.requestWithURL url
    operation = AFJSONRequestOperation.JSONRequestOperationWithRequest(request,
      success:->(request,response,jsonData) {
        if jsonData['total_count'] != 0
          @topics += jsonData['topics']
          @last_topic = @topics.last

          tableView.beginUpdates
            paths = []
            jsonData['topics'].each_with_index do |topic,index| 
              topic_index = @topics.count-jsonData['topics'].count+index
              paths << NSIndexPath.indexPathForRow(topic_index,inSection:0)
            end
            tableView.insertRowsAtIndexPaths paths,withRowAnimation:UITableViewRowAnimationTop
          tableView.endUpdates
        end
        tableView.infiniteScrollingView.stopAnimating
    },failure:nil)
    operation.start
  end

  #　datasource协议实现
  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @topics.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    topic = @topics[indexPath.row]

    @cellIdentifier ||= "topicItemCell"
    cell = tableView.dequeueReusableCellWithIdentifier(@cellIdentifier)

    image_url = NSURL.URLWithString("#{topic['image']['normal']}")
    cell.topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.gif"))
    cell.comment_label.text = topic['comment']
    cell
  end

  def tableView(tableView,heightForRowAtIndexPath:indexPath)
    topic = @topics[indexPath.row]
    if topic['image']['height'] > 160
      230 + (topic['image']['height'] - 160)
    else
      230
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
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