Pod::Spec.new do |s|
  s.name         = "LiCore"
  s.version      = "0.6.0"
  s.summary      = "Lithium community Core SDK"
  s.homepage     = "http://community.lithium.com/"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "Shekhar Dahore" => "shekhar.dahore@lithium.com" }
  s.platform     = :ios, "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => 'https://github.com/lithiumtech/li-ios-sdk.git', :tag => '0.6.0' }
  s.source_files = "Sources/LiCore/*", "Sources/LiCore/**/*.{swift,h,m}"
  s.exclude_files = "Sources/LiCore/Info.plist"
  s.resource_bundles = { "LiCore"  => "Sources/LiCore/Resources/*"}
  s.resources = ['Sources/LiCore/Resources/*']
  s.dependency "Alamofire", "~> 4.4"
end
