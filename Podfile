platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target 'Massage' do

	pod 'Realm', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', :submodules => true
	pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa.git', :branch => 'master', :submodules => true
	pod 'KVNProgress'
	pod 'Fabric'
	pod 'Crashlytics'
	pod 'URLNavigator', :git => 'https://github.com/devxoul/URLNavigator.git', :branch => 'master', :submodules => true
	pod 'Analytics', '~> 3.1.0'
	pod 'Alamofire', '~> 4.0'
	pod 'ObjectMapper', '~> 2.1'
	pod 'SwiftyJSON'
	pod 'GestureRecognizerClosures', '~> 3'
	pod 'Localize-Swift', '~> 1.6'

	pod 'GooglePlaces'
	pod 'GooglePlacePicker'
	pod 'GoogleMaps'

	pod 'Koloda', :git => 'https://github.com/Yalantis/Koloda.git', :branch => 'swift-3'
	pod 'DropDown'
	pod 'SideMenu', :git => 'https://github.com/jonkykong/SideMenu.git', :branch => 'swift3'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
