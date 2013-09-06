class TopicController < UIViewController
  extend IB
  TOPMARGIN = 20
  LEFTPADDING = 20

  attr_accessor :topic,:image

  # outlet :comment_label
  outlet :topic_imageview

  def viewDidLoad
    # comment_label.text = topic[:comment]
    @image = UIImage.imageWithData NSData.dataWithContentsOfURL(NSURL.URLWithString("#{AssetHost}#{topic['image']['normal']}"))
    topic_imageview.image = @image

    # recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self,action:'recognizerDidPan:')
    # view.addGestureRecognizer(recognizer)
  end

  def layoutSubviews
    super
    # center the image as it becomes smaller than the size of the screen
    boundsSize = self.bounds.size;
    frameToCenter = topic_imageview.frame;

    # center horizontally
    if (frameToCenter.size.width < boundsSize.width)
      frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
      frameToCenter.origin.x = 0;
    end

    # center vertically
    if (frameToCenter.size.height < boundsSize.height)
      frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
      frameToCenter.origin.y = 0;
    end

    tileContainerView.frame = frameToCenter;
  end

  def viewForZoomingInScrollView(scrollView)
    topic_imageview
  end

  # def viewWillAppear(animated)
  #   super
  #   self.navigationController.setNavigationBarHidden(true,animated:true)
  # end

  # def viewWillDisappear(animated)
  #   super
  #   self.navigationController.setNavigationBarHidden(false,animated:true)
  # end

  # def recognizerDidPan(recognizer)
  #   if navigationController
  #     navigationController.popViewControllerAnimated true
  #   end
  # end

end