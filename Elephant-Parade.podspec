Pod::Spec.new do |s|
  s.name         = "Elephant-Parade"
  s.version      = "1.0.0"
  s.summary      = "iOS Parallax Scroll-Jacking Effects Engine"
  s.homepage     = "https://github.com/HelloElephant/Parade"
  s.license      = 'MIT'
  s.author       = { "Elephant Engineering" => "tech@helloelephant.com" }
  s.source       = { :git => 'https://github.com/HelloElephant/Parade.git', :tag => s.version }

  s.platform     = :ios, "10.0"
  s.platform     = :tvos, "10.0"

  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.source_files = "Sources/*.*", "Sources/Parade/*.*", "Sources/ParadeExtensions/*.*", "Sources/ParadeMaker/*.*"
end
