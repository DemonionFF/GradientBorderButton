Pod::Spec.new do |s|
    s.name             = 'GradientBorderButton'
    s.version          = '1.0.0'
    s.summary          = 'Gradient border button to save some time avoiding boilerplate code'
    s.homepage         = 'https://github.com/DemonionFF/GradientBorderButton'
    s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
    s.author           = { 'Dmytro Antonchenko' => 'da@mrpl.com.ua' }
    s.source           = { :git => 'https://github.com/DemonionFF/GradientBorderButton.git', :tag => s.version.to_s }
    s.ios.deployment_target = '12.0'
    s.swift_version = '5.0'
    s.source_files = 'Sources/**/*'
  end