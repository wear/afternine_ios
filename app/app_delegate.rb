AssetHost = NSBundle.mainBundle.objectForInfoDictionaryKey('asset_host')

class AppDelegate
  def init
    # 标记分享场景为朋友圈
    super.tap do
      @scene = WXSceneTimeline
    end
  end

  def sharedDelegate
    return UIApplication.sharedApplication.delegate
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Theme.customizeAppAppearance
    TestFlight.takeOff("7039902e-dee0-4cdb-a573-edb6074e2268")
    MobClick.startWithAppkey("522bf3f356240b094e0bf6af")
    WXApi.registerApp("wxa2b61f8b4e622d27")
    true
  end

  def setWindow(new_window)
    @window = new_window
  end

  def window
    @window
  end

  # 微信接口
  def sendImageContent(image_data,title)
    # 发送内容给微信
    message = WXMediaMessage.message
    target_image = UIImage.imageWithData(image_data)
    message.setThumbImage target_image
    
    ext = WXImageObject.object
    ext.imageData = image_data
    message.mediaObject = ext
    req = SendMessageToWXReq.alloc.init
    req.bText = false
    req.message = message
    req.scene = WXSceneTimeline

    WXApi.sendReq req
  end

  def onReq(req)
    if(req.class == GetMessageFromWXReq)
        self.onRequestAppMessage
    elsif(req.class == ShowMessageFromWXReq)
      temp = req
      self.onShowMediaMessage temp.message
    end
  end

  def onShowMediaMessage(message)
    # 微信启动， 有消息内容。
    self.viewContent message
  end

  def viewContent(msg)
    # 显示微信传过来的内容    
    obj = msg.mediaObject
    
    strTitle = "消息来自微信"
    strMsg = "标题：#{msg.title} \n内容：#{msg.description} \n附带信息：#{obj.extInfo} \n缩略图:#{msg.thumbData.length} bytes\n\n"
    App.alert(strMsg)
  end

  def onRequestAppMessage
    # 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
    controller = RespForWeChatViewController.alloc.init
    controller.delegate = self;
    self.viewController.presentModalViewController controller,animated:true
  end


  def onResp(resp)
    if(resp.class == SendMessageToWXResp)
      res = resp.errCode == 0 ? '发送成功' : '发送失败'
      App.alert("#{res}")
    elsif(resp.class == SendAuthResp)
      res = resp.errCode == 0 ? '认证成功' : '认证失败'
      App.alert("#{res}")
    end
  end  

  def application(application,handleOpenURL:url)
    WXApi.handleOpenURL(url,delegate:self)
  end

  def application(application,openURL:url,sourceApplication:sourceApplication,annotation:annotation)
    WXApi.handleOpenURL(url,delegate:self)
  end

end
