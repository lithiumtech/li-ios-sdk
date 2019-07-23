
Pod::Spec.new do |s|

  s.name               = "LiUIComponents"
  s.version            = "0.3.0"
  s.summary            = "Lithium community iOS SDK UI components."
  s.description        = "LiUIComponents is the UI component of lithium comunity for integrating into partner iOS apps."
  s.homepage           = "https://community.lithium.com"
  s.license            = "Apache License, Version 2.0"
  s.author             = { "Shekhar Dahore" => "shekhar.dahore@lithium.com" }
  s.platform           = :ios, "9.0"
  s.swift_version      = "5"
  s.source             = { :git => "https://github.com/lithiumtech/li-ios-sdk.git", :tag => "0.3.0" }
  s.source_files       = "Sources/LiUIComponents/*", "Sources/LiUIComponents/**/*.{swift,h,m}"
  s.resource_bundles   = { "LiUIComponents" => ["Sources/LiUIComponents/Resources/*", "Sources/LiUIComponents/**/*.{xib,storyboard}", "Sources/LiUIComponents/**/*.xcassets"]}
  s.resources          = ["Sources/LiUIComponents/Resources/*", "Sources/LiUIComponents/**/*.{xib,storyboard}", "Sources/LiUIComponents/**/*.xcassets" ]
  s.dependency "LiCore", "0.3.0"
end
