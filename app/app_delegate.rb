AssetHost = NSBundle.mainBundle.objectForInfoDictionaryKey('asset_host')

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Theme.customizeAppAppearance
    # TestFlight.takeOff("7039902e-dee0-4cdb-a573-edb6074e2268")
    MobClick.startWithAppkey("522bf3f356240b094e0bf6af")
    WXApi.registerApp("wxdb15ed0a6d757c14")

    true
  end

  def setWindow(new_window)
    @window = new_window
  end

  def window
    @window
  end

  # 微信接口
  def onReq(req)
    # if(req.class == GetMessageFromWXReq)
    #     self.onRequestAppMessage
    # elsif(req.class == ShowMessageFromWXReq)
    #   temp = req
    #   self.onShowMediaMessage temp.message
    # end
  end


  def onResp(resp)
    if(resp.class == SendMessageToWXResp)
      res = resp.errCode == 0 ? '分享成功' : '分享失败'
      App.alert("#{res}")
    elsif(resp.class == SendAuthResp)
      res = resp.errCode == 0 ? '认证成功' : '认证失败'
      App.alert("#{res}")
    end
  end 

  def sendImageContent(image,thumb_image,comment)
    # 发送内容给微信
    message = WXMediaMessage.message
    message.setThumbImage(thumb_image)

    ext = WXImageObject.object
    ext.imageData = UIImagePNGRepresentation(image)
    message.mediaObject = ext;
    
    req = SendMessageToWXReq.alloc.init
    req.message = message;
    req.scene = WXSceneTimeline
    req.bText = false
    
    WXApi.sendReq req 
  end

  def application(application,handleOpenURL:url)
    WXApi.handleOpenURL(url,delegate:self)
  end

  def application(application,openURL:url,sourceApplication:sourceApplication,annotation:annotation)
    WXApi.handleOpenURL(url,delegate:self)
  end

end
