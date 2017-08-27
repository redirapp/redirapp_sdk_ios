#
# Be sure to run `pod lib lint Redirapp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Redirapp'
  s.version          = '0.0.2'
  s.summary          = 'Mobile attribution and distribution platform.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Redirapp SDK is a mobile app attribution and distribution platform. It generates channel wise statistics
    of your customers so you can analyse each channel return of investment (ROI) independently. Redirapp
    also allows deeplinking and member get member strategies. It gathers all events needed to plot the whole
    pirate metrics funnel: Aquisition, Activation, Retention, Revenue and Referral.
    Redirapp SDK implements a router system to make it very easy to open specific contents in your app when
    user opens a deep link.
                       DESC

  s.homepage         = 'https://redirapp.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Redirapp" => "contact@redirapp.com" }
  s.source           = { :git => "https://github.com/redirapp/redirapp_sdk_ios.git", :tag => "#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Redirapp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Redirapp' => ['Redirapp/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.frameworks = 'UIKit'
  s.dependency 'Alamofire', '~> 4.4'
end
