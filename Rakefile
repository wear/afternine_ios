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
  app.icons = ["Icon.png", "Icon@2x.png"]
  app.name = 'afternine'
  # app.entitlements['get-task-allow'] = false
  app.prerendered_icon = true
  app.scheme = '远程'
  app.version  = "1.0"
  app.short_version  = "1.0"  
  app.interface_orientations = [:portrait]
  app.xcode_dir = "/Applications/Xcode.app/Contents/Developer"
  # app.info_plist['UILaunchImageFile'] = 'Default.png'
  app.deployment_target = '6.0'
  app.weak_frameworks += ['MessageUI','StoreKit','AudioToolbox','SystemConfiguration','CoreGraphics','AdSupport']
  app.info_plist['CFBundleDisplayName'] = '九点一刻'
  app.info_plist['UIMainStoryboardFile'] = 'iPhone_Storyboard'
  app.info_plist['UIMainStoryboardFile~ipad'] = 'iPad_Storyboard'
  
  app.release do
    app.identifier = 'com.qiangda.afternine'
    app.codesign_certificate = 'iPhone Distribution: stephen kong (JKWJT567A9)'
    app.provisioning_profile = "/Users/stephen/Documents/Development/money/ios/distribute/AfternineDistribute.mobileprovision"
  end


  app.libs << "/usr/lib/libz.dylib"  
  app.vendor_project('vendor/Umeng', :static,:products => ["libMobClickLibrary.a"])
  app.vendor_project('vendor/admob', :static,:products => ["libGoogleAdMobAds.a"],:force_load => false)

  app.vendor_project('vendor/weixin', :static,
    :products => ["libWeChatSDK_armv7_armv7s.a"],
    :headers_dir => 'Headers',
    :force_load => false) 

  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => 'weixin',
      'CFBundleURLSchemes' => ['wxdb15ed0a6d757c14'] }
  ]

  app.pods do
    pod 'SVProgressHUD', '0.8'
    pod 'JSONKit'
    pod 'AFNetworking' ,'1.3.2'
    pod 'Reachability', '~> 3.1.1'
    pod 'SDWebImage'
    pod 'SVPullToRefresh'
  end  

end

Motion::Project::App.scheme('远程') do |app|
  app.info_plist['asset_host'] = 'http://afternine.lavanify.com'
end

Motion::Project::App.scheme('本地测试') do |app|
  app.info_plist['asset_host'] = 'http://192.168.1.102:3000'
end
