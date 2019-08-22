 #s.name：名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
 #s.version：版本号
 #s.ios.deployment_target:支持的pod最低版本
 #s.summary: 简介
 #s.homepage:项目主页地址
 #s.license:许可证
 #s.author:作者
 #s.social_media_url:社交网址
 #s.source:项目的地址
 #s.source_files:需要包含的源文件
 #s.resources: 资源文件
 #s.requires_arc: 是否支持ARC
 #s.dependency：依赖库，不能依赖未发布的库
 #s.dependency：依赖库，如有多个可以这样写


Pod::Spec.new do |s|
  s.name         = "WaterFallForWorkSpace"
  s.version      = "0.0.1"
  s.summary      = "Redirecting Requests."
  s.description  = < “HouWf” }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/HouWf/Space-FL.git", :tag =>"0.0.1" }
  s.source_files  = "WaterFallForWorkSpace", "WaterFallForWorkSpace/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
