
Pod::Spec.new do |s|

  s.name         = "PDStrategy"
  s.version      = "0.2.1"

  s.platform = :ios
  s.ios.deployment_target = '7.0'

  s.summary      = "Template for implementation Strategy Pattern"

  s.description  = <<-DESC
Template for implementation Strategy Pattern
This is testing pod
                   DESC

  s.homepage     = "https://github.com/sindanar/PDStrategy"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDStrategy.git", :tag => "v0.2.1" }

  s.frameworks = 'CoreData'

  s.public_header_files = 'Classes/PDStrategy.h'
  s.source_files = 'Classes/PDStrategy.h'

  s.subspec 'Models' do |m|    
    m.source_files = "Classes/Models/**/*.{h,m}"
  end
  
  s.subspec "UI" do |ui|
    ui.source_files = "Classes/UI/**/*.{h,m}"
  end

  s.subspec "TableView" do |tv|
    tv.source_files = "Classes/TableView/**/*.{h,m}"
    tv.dependency 'PDStrategy/Models'
    tv.dependency 'PDStrategy/UI'
  end

  s.subspec "CollectionView" do |cv|
    cv.source_files = "Classes/CollectionView/**/*.{h,m}"
    cv.dependency 'PDStrategy/Models'
    cv.dependency 'PDStrategy/UI'
  end

end
