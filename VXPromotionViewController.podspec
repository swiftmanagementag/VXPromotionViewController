Pod::Spec.new do |s|
  s.name         	= 'VXPromotionViewController'
  s.version      	= '1.0'
  s.summary     	= 'A simple display of promoted apps.'
  s.homepage 	   	= 'http://www.swift.ch'
  s.license      	= 'MIT'
  s.author       	= { 'Graham Lancashire' => 'lancashire@swift.ch' }
  s.source       	= { :git => 'https://github.com/swiftmanagementag/VXPromotionViewController.git', :tag => s.version.to_s }
  s.platform     	= :ios, '7.0'
  s.source_files 	= 'VXPromotionViewController/**/*.{h,m}'
  s.resources 		= 'VXPromotionViewController/**/*.{bundle,png,lproj}'
  s.requires_arc 	= true
end
