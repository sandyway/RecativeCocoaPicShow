platform :ios, '6.1'
inhibit_all_warnings!

pod 'AFNetworking', '~> 2.5.3'
pod 'NYXImagesKit', '~> 2.3'
pod 'FXKeychain', '~> 1.5'
pod 'BlocksKit', '~> 2.2.0'
pod 'NSString-Hashes', '~> 1.2.1'
pod 'FrameAccessor', '~> 1.3.2'
pod 'MWFeedParser', '~> 1.0.1'
pod 'RegexKitLite', '~> 4.0'
pod 'MBProgressHUD', '~> 0.8'
pod 'MJRefresh', '~> 2.3.2'
pod 'SDWebImage', '~> 3.7.3'
pod 'libextobjc', '~> 0.4.1'
pod 'ReactiveCocoa', '2.5'AFNetworking-RACExtensions
pod 'ReactiveViewModel', '~> 0.3'
pod 'Mantle', '~> 2.0.4'
#pod 'RestKit', '~> 0.25.0'
pod 'AFNetworking-RACExtensions', '~> 0.1.8'
#pod 'ReactiveMantle', '~> 0.1.0'
#pod 'OCMock', '~> 3.1.5'
#pod 'EAIntroView', '~> 2.7.0'
pod '500px-iOS-api'
pod 'SVProgressHUD', '~> 1.1.3'
pod 'AFImageDownloader', '~> 1.1.0'

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = 'armv7 arm64'
        end
    end
end