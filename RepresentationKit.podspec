#
# Be sure to run `pod lib lint RepresentationKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RepresentationKit'
  s.version          = '2.5'
  s.summary          = 'Create representation of objects.'

  s.description      = <<-DESC
RepresentationKit permits objects to represent themselves through key-values to
arbitrary representations. Thus objects become `Representable`.
                       DESC

  s.homepage         = 'https://github.com/averello/RepresentationKit'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Georges Boumis' => 'developer.george.boumis@gmail.com' }
  s.source           = { :git => 'https://github.com/averello/RepresentationKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.macos.deployment_target = '10.9'
  s.source_files = 'RepresentationKit/Classes/**/*'
  s.frameworks = 'Foundation'
end
