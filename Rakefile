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
  app.xcode_dir = "/Applications/Xcode.app/Contents/Developer"
  app.sdk_version = '6.1'
  app.deployment_target = '5.0'

  app.info_plist['UIMainStoryboardFile'] = 'iPhone_Storyboard'

  app.pods do
    pod 'SVProgressHUD', '0.8'
    pod 'JSONKit'
    pod 'AFNetworking' ,'1.3.2'
    pod 'Reachability', '~> 3.0.0'
    pod 'SDWebImage'
    pod 'SVPullToRefresh'
  end

end

Motion::Project::App.scheme('远程') do |app|
  app.info_plist['asset_host'] = 'http://afternine.lavanify.com'
end

Motion::Project::App.scheme('本地测试') do |app|
  app.info_plist['asset_host'] = 'http://localhost:3000'
end
