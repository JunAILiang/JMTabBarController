

Pod::Spec.new do |s|

  s.name         = "JMTabBarController"
  s.version      = "0.1"
  s.summary      = "超强自定义tabBar"

  s.description  = <<-DESC
  					   * 支持自定义tabBar动画
  					   * 支持自定义tabBar样式
  					   * 支持自定义badgeValue动画
  					   * 支持自定义badgeValue样式
  					   * 完美支持横竖屏
  					   * 支持iPhone X
                   DESC

  s.homepage     = "https://github.com/JunAILiang/JMTabBarController"

  s.license      = "MIT"

  s.author             = { "LJM" => "gzliujm@163.com" }

  s.platform	= :ios, "8.0"

  s.source       = { :git => "https://github.com/JunAILiang/JMTabBarController.git", :tag => "#{s.version}" }

  s.source_files  = "JMTabBarController/JMTabBarController/**/*.{h,m}"

  s.requires_arc = true

end
