
Pod::Spec.new do |s|

  s.name         = "PDStrategy"
  s.version      = "0.0.8"

  s.platform = :ios
  s.ios.deployment_target = '7.0'

  s.summary      = "Helper for implementation Strategy Pattern"

  s.description  = <<-DESC
Helper for implementation Strategy Pattern
This is testing pod
                   DESC

  s.homepage     = "https://github.com/sindanar/PDStrategy"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDStrategy.git", :tag => "v0.0.8" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"

end
