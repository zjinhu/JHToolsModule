 
Pod::Spec.new do |s|
  s.name             = 'JHToolsModule'
  s.version          = '0.1.1'
  s.summary          = '工具类组件.'
 
  s.description      = <<-DESC
							工具.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/JHToolsModule.git', :tag => s.version.to_s }
 
  s.platform         = :ios, "9.0"
  s.ios.deployment_target = "9.0" 
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.requires_arc        = true
 
  s.dependency 'Masonry'
  s.dependency 'KafkaRefresh'

    s.subspec 'Define' do |ss|
          ss.source_files = 'JHToolsModule/JHToolsModule/Class/Define/**/*' 
          ss.public_header_files = "JHToolsModule/JHToolsModule/Class/Define/*.{h}"
    end
    s.subspec 'View' do |ss| 
          ss.source_files = 'JHToolsModule/JHToolsModule/Class/ToolView/**/*' 
          ss.public_header_files = "JHToolsModule/JHToolsModule/Class/ToolView/*.{h}"
    end
    s.subspec 'BaseVC' do |ss|
          ss.dependency 'JHToolsModule/Category'
          ss.dependency 'JHToolsModule/Define'
          ss.source_files = 'JHToolsModule/JHToolsModule/Class/BaseVC/**/*' 
          ss.public_header_files = "JHToolsModule/JHToolsModule/Class/BaseVC/*.{h}"
    end
   
  	s.subspec 'Category' do |ss|
          ss.source_files = 'JHToolsModule/JHToolsModule/Class/Category/*.{h,m}' 
          ss.public_header_files = "JHToolsModule/JHToolsModule/Class/Category/*.{h}"

          	ss.subspec 'Safe' do |sss| 
          	sss.source_files = 'JHToolsModule/JHToolsModule/Class/Category/Safe/**/*' 
          	sss.public_header_files = "JHToolsModule/JHToolsModule/Class/Category/Safe/*.{h}"
    		end
        	ss.subspec 'Masonry' do |sss| 
          	sss.source_files = 'JHToolsModule/JHToolsModule/Class/Category/Masonry/**/*' 
          	sss.public_header_files = "JHToolsModule/JHToolsModule/Class/Category/Masonry/*.{h}"
    		end
        	ss.subspec 'Button' do |sss| 
          	sss.source_files = 'JHToolsModule/JHToolsModule/Class/Category/Button/**/*' 
          	sss.public_header_files = "JHToolsModule/JHToolsModule/Class/Category/Button/*.{h}"
    		end
        	ss.subspec 'BaseUI' do |sss| 
          	sss.source_files = 'JHToolsModule/JHToolsModule/Class/Category/BaseUI/**/*' 
          	sss.public_header_files = "JHToolsModule/JHToolsModule/Class/Category/BaseUI/*.{h}"
    		end
    end

end
