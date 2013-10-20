class TopicsController < UITableViewController
  extend IB

  attr_accessor :current_topic,:topics,:current_page,:total_pages,:total_count,:first_topic,:last_topic,:per_page

  def awakeFromNib
    @topics = []
  end

  def viewDidAppear(animated)
    adjustHeightOfTableview
  end

  def viewDidLoad
    self.tableView.backgroundColor = "#E8E8E8".to_color
    insertRowAtTop    
    #setup pull-to-refresh
    self.tableView.addPullToRefreshWithActionHandler ->{
      insertRowAtTop
    }

    # setup infinite scrolling
    self.tableView.addInfiniteScrollingWithActionHandler ->{
      insertRowAtBottom if @last_topic
    }
  end

  # 拉动更新
  def insertRowAtTop
    url = if @first_topic
      NSURL.URLWithString "#{AssetHost}/topics/before_at.json?target_topic_id=#{@first_topic['id']}"    
    else
      NSURL.URLWithString "#{AssetHost}/topics/before_at.json"
    end    
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
          adjustHeightOfTableview
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

    cell.setup_with_topic topic
    cell
  end

  def tableView(tableView,heightForRowAtIndexPath:indexPath)
    topic = @topics[indexPath.row]

    # font = UIFont.fontWithName "STHeitiK-Medium",size:14
    # commentText = topic['comment']
    
    # commentSize = commentText.sizeWithFont font,constrainedToSize:CGSizeMake(279, 4000)
    # imageHeight = topic['image']['height']
    
  #   #  if deployment target is iOS7 and you want to get rid of the warning above
  #   #  comment the line above and uncomment the following section
    
  #   #  ios 7 only
  #   # CGRect boundingRect = [newAboutText boundingRectWithSize:CGSizeMake(268, 4000)
  #   #                                      options:NSStringDrawingUsesLineFragmentOrigin
  #   #                                   attributes:@{NSFontAttributeName:font}
  #   #                                      context:nil];
  #   # 
  #   # CGSize boundingSize = boundingRect.size;
  #   #  end ios7 only

    
  #   # return (280-15+aboutSize.height);    
    # return imageHeight + commentSize.height + 40

    if topic['image']['height'] > 150
      230 + (topic['image']['height'] - 150)
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

  def adjustHeightOfTableview
    height = self.tableView.contentSize.height;
    maxHeight = self.tableView.superview.frame.size.height - self.tableView.frame.origin.y;

    # if the height of the content is greater than the maxHeight of
    # total space on the screen, limit the height to the size of the
    # superview.

    height = maxHeight if (height > maxHeight)

    # now set the frame accordingly

    UIView.animateWithDuration 0.25,animations:->{
      frame = self.tableView.frame;
      frame.size.height = height;
      self.tableView.frame = frame;
      # if you have other controls that should be resized/moved to accommodate
      # the resized tableview, do that here, too
    }
  end

  def networkOpration(&opt)
    reach = Reachability.reachabilityWithHostname "www.baidu.com"
    
    reach.reachableBlock = lambda {|info|
      main_queue = Dispatch::Queue.main
      main_queue.async { opt.call }      
    }

    reach.unreachableBlock = lambda {|info|
      main_queue = Dispatch::Queue.main
      main_queue.async { App.alert('无网络连接') }
    }

    reach.startNotifier      
  end 

end