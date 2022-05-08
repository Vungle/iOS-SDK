#
# Be sure to run `pod lib lint VungleSDK-iOS.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
s.name             = "VungleSDK-iOS"
s.version          = "6.11.0"
s.summary          = "Vungle's iOS SDK'"
s.description      = <<-DESC
An SDK for video ad based monetization with the Vungle Network
DESC

s.homepage         = "https://www.vungle.com/"
s.license          = { :type => "Commercial", :file => "LICENSE.md" }
s.author           = { "Vungle" => "tech-support@vungle.com" }

s.platform     = :ios, '10.0'
s.requires_arc = true

s.source           = { :http => "https://vungle2-sdk-dev-scratch.s3.amazonaws.com/ios/6.11.x/vungle6110.zip"}

s.vendored_frameworks = 'VungleSDK.xcframework'
s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

s.frameworks = 'AdSupport', 'AudioToolbox', 'AVFoundation', 'CFNetwork', 'CoreGraphics', 'CoreMedia', 'MediaPlayer', 'QuartzCore', 'StoreKit', 'SystemConfiguration'
s.weak_framework = 'WebKit', 'UIKit', 'Foundation'
s.libraries = 'z'

end
