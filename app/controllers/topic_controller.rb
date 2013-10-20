include Core
class TopicController < UIViewController
  extend IB
  TOPMARGIN = 20
  LEFTPADDING = 20

  attr_accessor :topic,:image

  # outlet :comment_label
  outlet :topic_imageview
  outlet :scrollView

  def viewDidLoad
    image_url = NSURL.URLWithString("#{topic['image']['normal']}")
    @image = topic_imageview.setImageWithURL(image_url,placeholderImage:UIImage.imageNamed("placeholder.png"))
  end 

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