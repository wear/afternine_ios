AssetHost = NSBundle.mainBundle.objectForInfoDictionaryKey('asset_host')

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    true
  end

  def setWindow(new_window)
    @window = new_window
  end

  def window
    @window
  end
end
