class TopicController < UIViewController
  extend IB
  TOPMARGIN = 20
  LEFTPADDING = 20

  attr_accessor :topic,:image

  # outlet :comment_label
  outlet :topic_imageview

  def viewDidLoad
    # comment_label.text = topic[:comment]
    image_url = NSURL.URLWithString("#{topic['image']['normal']}")
    @image = topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.gif"))

    # recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self,action:'recognizerDidPan:')
    # view.addGestureRecognizer(recognizer)

    # Create a view of the standard size at the top of the screen.
    # Available AdSize constants are explained in GADAdSize.h.
    origin = CGPointMake(0.0,self.view.frame.size.height-CGSizeFromGADAdSize(KGADAdSizeBanner).height);
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

  def recognizerDidPan(recognizer)
    if navigationController
      navigationController.popViewControllerAnimated true
    end
  end

end