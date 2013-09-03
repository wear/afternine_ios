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
  app.info_plist['UIMainStoryboardFile'] = 'iPhone_Storyboard'

  app.pods do
    pod 'SVProgressHUD', '0.8'
    pod 'JSONKit'
    pod 'AFNetworking' ,'1.3.2'
    pod 'Reachability', '~> 3.0.0'
  end

end
