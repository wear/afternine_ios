class TopicController < UIViewController
  extend IB
  TOPMARGIN = 20
  LEFTPADDING = 20

  attr_accessor :topic,:image

  # outlet :comment_label
  outlet :topic_imageview
  outlet :scrollView

  def viewDidLoad
    # comment_label.text = topic[:comment]
    image_url = NSURL.URLWithString("#{topic['image']['normal']}")
    @image = topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.png"))

    # recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self,action:'recognizerDidPan:')
    # view.addGestureRecognizer(recognizer)

    # Create a view of the standard size at the top of the screen.
    # Available AdSize constants are explained in GADAdSize.h.
    origin = CGPointMake(0.0,UIScreen.mainScreen.bounds.size.height-CGSizeFromGADAdSize(KGADAdSizeBanner).height-navigationController.navigationBar.frame.size.height-20);
    banner_view = GADBannerView.alloc.initWithAdSize(KGADAdSizeBanner,origin:origin)

    # Specify the ad's "unit identifier". This is your AdMob Publisher ID.
    banner_view.adUnitID = 'a1522beb8637906'

    # Let the runtime know which UIViewController to restore after taking
    # the user wherever the ad goes and add it to the view hierarchy.
    banner_view.rootViewController = self
    self.view.addSubview banner_view

    # Initiate a generic request to load it with an ad.
    request = GADRequest.request
    request.testDevices = ['8FAA601E-A20C-500D-9136-931E516BF252','db53b06b5c20150b4e8fe3e6b64a354e54f3caa3']
    banner_view.loadRequest request  

    # doubleTapRecognizer = UITapGestureRecognizer.alloc.initWithTarget(self,action:'scrollViewDoubleTapped:')
    # doubleTapRecognizer.numberOfTapsRequired = 2;
    # doubleTapRecognizer.numberOfTouchesRequired = 1;
    # self.scrollView.addGestureRecognizer doubleTapRecognizer
  end

  # def centerScrollViewContents
  #   boundsSize = self.scrollView.bounds.size;
  #   contentsFrame = self.topic_imageview.frame;
 
  #   if (contentsFrame.size.width < boundsSize.width) 
  #     contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0;
  #   else 
  #     contentsFrame.origin.x = 0.0;
  #   end
 
  #   if (contentsFrame.size.height < boundsSize.height) 
  #     contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0;
  #   else 
  #     contentsFrame.origin.y = 0.0;
  #   end
 
  #   self.topic_imageview.frame = contentsFrame;
  # end   

  def viewForZoomingInScrollView(scrollView)
    topic_imageview
  end

  def share_wechat(sender)
    if WXApi.isWXAppInstalled     
      SVProgressHUD.show
      app_delegate = UIApplication.sharedApplication.delegate

      thumb_image_url = NSURL.URLWithString("#{topic['image']['thumb']}")
      SDWebImageDownloader.sharedDownloader.downloadImageWithURL(thumb_image_url,
                                                      options:0,
                                                     progress:->(receivedSize,expectedSize){},
                                                     completed:->(thumb_image,data,error,finished){
                                                        SVProgressHUD.dismiss
                                                        if image && finished
                                                          app_delegate.sendImageContent(topic_imageview.image,thumb_image,@topic['comment']) 
                                                        else
                                                          App.alert error.value
                                                        end
                                                      })
    else
      App.alert '需要安装微信'
    end

       
  end  

end