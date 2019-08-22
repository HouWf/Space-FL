Pod::Spec.new do |s|
  s.name         = "WaterFallForWorkSpace"
  s.version      = "0.0.1"
  s.summary      = "Redirecting Requests."
  s.description  = < “HouWf” }
  s.platform     = :iOS
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
