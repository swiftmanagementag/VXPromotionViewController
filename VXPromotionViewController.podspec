@version = "1.0.3"

Pod::Spec.new do |s|
  s.name         	= 'VXPromotionViewController'
  s.version      	= @version
  s.summary     	= 'A simple display of promoted apps.'
  s.homepage 	   	= 'https://github.com/swiftmanagementag/VXPromotionViewController'
  s.license			= { :type => 'MIT', :file => 'LICENSE' }
  s.author       	= { 'Graham Lancashire' => 'lancashire@swift.ch' }
  s.source       	= { :git => 'https://github.com/swiftmanagementag/VXPromotionViewController.git', :tag => s.version.to_s }
  s.platform     	= :ios, '7.0'
  s.source_files 	= 'VXPromotionViewController/**/*.{h,m}'
  s.frameworks		= 'StoreKit', 'CoreImage'
  s.resources 		= 'VXPromotionViewController/**/*.{bundle,xib,png,lproj}'
  s.requires_arc 	= true
end
