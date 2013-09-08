AssetHost = NSBundle.mainBundle.objectForInfoDictionaryKey('asset_host')

class AppDelegate
  def sharedDelegate
    return UIApplication.sharedApplication.delegate
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Theme.customizeAppAppearance
    TestFlight.takeOff("7039902e-dee0-4cdb-a573-edb6074e2268")
    MobClick.startWithAppkey("522bf3f356240b094e0bf6af")
    true
  end

  def setWindow(new_window)
    @window = new_window
  end

  def window
    @window
  end
end
