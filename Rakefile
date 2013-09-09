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
  app.device_family = [:iphone]
  app.icons = ["AppIcon60x60.png", "AppIcon60x60@2x.png"]
  app.name = 'afternine'
  # app.identifier = 'com.qiangda.afternine'
  # app.entitlements['get-task-allow'] = false
  app.prerendered_icon = true
  app.scheme = '本地测试'
  app.interface_orientations = [:portrait]
  app.xcode_dir = "/Applications/Xcode.app/Contents/Developer"
  app.info_plist['UILaunchImageFile'] = 'default.png'
  app.deployment_target = '5.1'
  app.weak_frameworks += ['MessageUI','StoreKit','AudioToolbox','SystemConfiguration','CoreGraphics','AdSupport']
  app.info_plist['CFBundleDisplayName'] = '九点一刻'
  app.info_plist['UIMainStoryboardFile'] = 'iPhone_Storyboard'
  app.provisioning_profile = "/Users/stephen/Documents/Development/money/ios/distribute/afternine.mobileprovision"

  app.pods do
    pod 'SVProgressHUD', '0.8'
    pod 'JSONKit'
    pod 'AFNetworking' ,'1.3.2'
    pod 'Reachability', '~> 3.1.1'
    pod 'SDWebImage'
    pod 'SVPullToRefresh'
  end

   app.vendor_project('vendor/weixin', :static,
    :products => ["libWeChatSDK_armv7_armv7s.a"],
    :headers_dir => 'Headers',
    :force_load => false) 

  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => 'weixin',
      'CFBundleURLSchemes' => ['wxdb15ed0a6d757c14'] }
  ]

  app.vendor_project('vendor/admob', :static)
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
  app.info_plist['asset_host'] = 'http://192.168.1.102:3000'
end
