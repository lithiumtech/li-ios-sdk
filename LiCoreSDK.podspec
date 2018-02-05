Pod::Spec.new do |s|
  s.name         = "LiCoreSDK"
  s.version      = "0.1.0"
  s.summary      = "Lithium community Core SDK"
  s.homepage     = "http://community.lithium.com/"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "Shekhar Dahore" => "shekhar.dahore@lithium.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/lithiumtech/li-ios-sdk-core.git', :tag => '0.1.0' }
  s.source_files = "LiCoreSDK/*", "LiCoreSDK/**/*.{swift,h,m,json}"
  s.dependency "Alamofire", "~> 4.4"
end
