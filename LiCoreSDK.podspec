#
#  Be sure to run `pod spec lint LiCoreSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "LiCoreSDK"
  s.version      = "0.1.0"
  s.summary      = "Lithium community Core SDK"
  s.homepage     = "http://community.lithium.com/"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Shekhar Dahore" => "shekhar.dahore@lithium.com" }
  s.platform     = :ios, "9.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => 'https://github.com/lithiumtech/li-ios-sdk-core.git', :tag => '0.1.0' }

  s.source_files  = "LiCoreSDK", "LiCoreSDK/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.dependency "Alamofire", "~> 4.4"
end
