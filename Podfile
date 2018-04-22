platform :ios, '11.0'
inhibit_all_warnings!

target 'Levels' do
  use_frameworks!

  pod 'AlertTransition/Trolley', '~> 2.1.0'
  pod 'Cloudinary', '~> 2.0'
  pod 'CodableAlamofire', '~> 1.1.0'
  pod 'Kingfisher', '~> 4.1.0'
  pod 'Presentr'
  pod 'PromiseKit/MapKit', '~> 6.2.3'
  pod 'SCLAlertView', '0.7.0'
  pod 'UITextField+Shake', '~> 1.1'
  pod 'VerticalSteppedSlider'

  target 'Shelter' do
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = "NO"
            if target.name == 'Presentr'
                config.build_settings['SWIFT_VERSION'] = '4.0'
                else
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = "NO"
        end
    end
end
