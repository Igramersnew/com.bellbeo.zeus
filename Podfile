platform :ios, '14.0'

target 'match3' do
  use_frameworks!

  #pod 'AppsFlyerFramework'
  #pod 'FBSDKCoreKit', '~> 15.0'
 # pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  #pod 'Firebase/Analytics'
  #pod 'RevenueCat'

  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
   end
  end

end
