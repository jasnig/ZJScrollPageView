Pod::Spec.new do |s|
  s.name        = "ZJScrollPageView"
  s.version     = "1.0.0"
  s.summary     = "ZJScrollPageView is written in objective-C and it is useful and easy to do some interesting things with it."
  s.homepage    = "https://github.com/jasnig/ZJScrollPageView"
  s.license     = { :type => "MIT" }
  s.authors     = { "ZeroJ" => "854136959@qq.com" }

  s.requires_arc = true
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source   = { :git => "https://github.com/jasnig/ZJScrollPageView.git", :tag => s.version }
  s.framework  = "UIKit"
  s.source_files = "ZJScrollPageView/ZJScrollPageView/*.h","ZJScrollPageView/ZJScrollPageView/*.m"
end