Pod::Spec.new do |s|
  s.name             = 'MahaStorageKit'
  s.version          = '0.1.4'
  s.summary          = 'A lightweight sandbox file storage utility used by the app.'

  s.description      = <<-DESC
MahaStorageKit extracts the existing MHFileHandle capability into a private pod.
It keeps the current sandbox directory behavior while exposing renamed public APIs.
  DESC

  s.homepage         = 'https://github.com/wangweiqi864-hue/MahaStorageKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangweiqi864-hue' => 'wangweiqi864-hue@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/wangweiqi864-hue/MahaStorageKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'MahaStorageKit/Classes/**/*'
  s.dependency 'MahaLogCore'
end
