Pod::Spec.new do |s|
	s.name     = 'WaterFallForWorkSpace'
	s.version  = '0.0.1'
	s.license  = 'MIT'
	s.summary  = ‘Rset'
	# s.homepage = 'https://github.com/AFNetworking/AFNetworking'
	# s.social_media_url = 'https://twitter.com/AFNetworking'
	s.authors  = { 'Mattt Thompson' => 'm@mattt.me' }
	s.source   = { :git => 'https://github.com/HouWf/Space-FL.git', :tag => s.version, :submodules => true }
	s.requires_arc = true
	# s.public_header_files = 'AFNetworking/AFNetworking.h'
	# s.source_files = 'AFNetworking/AFNetworking.h'
end