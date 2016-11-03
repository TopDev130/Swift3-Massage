platform :ios, '9.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

pod 'Koloda', :git => 'https://github.com/Yalantis/Koloda.git', :branch => 'swift-3'

target 'Massage' do

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
