#
# Be sure to run `pod lib lint IXMSDKLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IXMSDKLib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of IXMSDKLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/guojiangzhen74/IXMSDKLib'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '郭江震' => '386912464@qq.com' }
  s.source           = { :git => 'https://github.com/guojiangzhen74/IXMSDKLib.git', :tag => '0.1.0' }


  s.ios.deployment_target = '8.0'

  s.source_files = 'IXMSDKLib/Classes/**/*.{h,m}'
  s.resource_bundles = {
     'IXMSDKLib' => ['IXMSDKLib/Assets/*.png']
  }
  s.public_header_files = 'IXMSDKLib/Classes/Headers/*.h'

  s.ios.vendored_frameworks = 'Pod/IXMSDKLib/**/*.framework'
  s.frameworks = 'Foundation','UIKit'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'FDFullscreenPopGesture', '~> 1.1'
  s.dependency 'Masonry'
  s.dependency 'MJExtension'
  s.dependency 'SVProgressHUD'

end
