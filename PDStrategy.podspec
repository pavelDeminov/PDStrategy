
Pod::Spec.new do |s|

  s.name         = "PDStrategy"
  s.version      = "0.1.1"

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

  s.source       = { :git => "https://github.com/sindanar/PDStrategy.git", :tag => "v0.1.1" }

  s.subspec "TableView" do |ps|
    ps.source_files = "Classes/TableView/**/*.{h,m}"
  end
  s.subspec "CollectionView" do |ps|
    ps.source_files = "Classes/CollectionView/**/*.{h,m}"
  end
  s.subspec "Models" do |ps|
    ps.source_files = "Classes/Models/**/*.{h,m}"
  end

  s.default_subspec = "Models"

end
