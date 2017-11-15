
Pod::Spec.new do |s|

  s.name         = "PDStrategy"
  s.version      = "0.2.2"

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.summary      = "Template for implementation Strategy Pattern"

  s.description  = <<-DESC
Template for implementation Strategy Pattern
This is testing pod
                   DESC

  s.homepage     = "https://github.com/sindanar/PDStrategy"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDStrategy.git", :tag => "v0.2.2" }

  s.frameworks = 'CoreData'

  s.subspec 'Protocols' do |protocols|    
    protocols.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Protocols/**/*.{swift}"
  end
  
  s.subspec "Models" do | models |
    models.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Models/**/*.{swift}"
    models.dependency 'PDStrategy/Protocols'
  end

  s.subspec "Adapters" do | adapters |
    adapters.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Adapters/**/*.{swift}"
    adapters.dependency 'PDStrategy/Protocols'

  end

  s.subspec "Views" do | views |
    views.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Views/**/*.{swift}"
  end

  s.subspec "Builders" do | builders |
    builders.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Builders/**/*.{swift}"
    builders.dependency 'PDStrategy/Views'
  end
  
  s.subspec "CollectionView" do |collectionView |
    collectionView.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/CollectionView/**/*.{swift}"
    collectionView.dependency 'PDStrategy/Protocols'
    collectionView.dependency 'PDStrategy/Models'
    collectionView.dependency 'PDStrategy/Adapters'
    collectionView.dependency 'PDStrategy/Views'
  end
	
  s.subspec "TableView" do | tableView |
    tableView.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/TableView/**/*.{swift}"
    tableView.dependency 'PDStrategy/Protocols'
    tableView.dependency 'PDStrategy/Models'
    tableView.dependency 'PDStrategy/Adapters'
    tableView.dependency 'PDStrategy/Views'
  end

  s.subspec "Extensions" do | extensions |
    builders.source_files = "Example/PDStrategy/PDStrategy/PDStrategy/Extensions/**/*.{swift}"
    builders.dependency 'PDStrategy/Protocols'
  end

end
