# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'afternine'
  app.scheme = '本地测试'
  app.interface_orientations = [:portrait]
  app.xcode_dir = "/Applications/Xcode.app/Contents/Developer"
  app.sdk_version = '6.1'
  app.deployment_target = '5.0'
  app.weak_frameworks += ['MessageUI','StoreKit','AudioToolbox','SystemConfiguration','CoreGraphics','AdSupport']

  app.info_plist['UIMainStoryboardFile'] = 'iPhone_Storyboard'

  app.pods do
    pod 'SVProgressHUD', '0.8'
    pod 'JSONKit'
    pod 'AFNetworking' ,'1.3.2'
    pod 'Reachability', '~> 3.0.0'
    pod 'SDWebImage'
    pod 'SVPullToRefresh'
  end

  app.vendor_project('vendor/admob', :static, :products => ["libGoogleAdMobAds.a"])
  app.vendor_project('vendor/Umeng', :static,:products => ["libMobClickLibrary.a"])

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = '6afbd71ce97e3a1bcfae3182abce573a_OTUxMjMxMjAxMy0wMy0yNSAwOToxOTowNi4xMjI5MTI'
  app.testflight.team_token = 'e63cacbd34ec507ebef58ff6cd6196a2_MjAzNTk0MjAxMy0wMy0yNSAxMDoxNzoxMy4zOTY4NzQ'
  app.testflight.distribution_lists = ['core']

end

Motion::Project::App.scheme('远程') do |app|
  app.info_plist['asset_host'] = 'http://afternine.lavanify.com'
end

Motion::Project::App.scheme('本地测试') do |app|
  app.info_plist['asset_host'] = 'http://localhost:3000'
end
