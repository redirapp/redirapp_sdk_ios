Pod::Spec.new do |s|

  s.name         = "Redirapp"
  s.version      = "0.0.1"
  s.summary      = "Mobile attribution and distribution platform."

  s.description  = <<-DESC
    Redirapp SDK is a mobile app attribution and distribution platform. It generates channel wise statistics
    of your customers so you can analyse each channel return of investment (ROI) independently. Redirapp
    also allows deeplinking and member get member strategies. It gathers all events needed to plot the whole
    pirate metrics funnel: Aquisition, Activation, Retention, Revenue and Referral.
    Redirapp SDK implements a router system to make it very easy to open specific contents in your app when
    user opens a deep link.
                   DESC

  s.homepage     = "http://redirapp.com"

  s.license = "MIT"

  s.author             = { "Redirapp" => "contact@redirapp.com" }

  s.source = { :git => "https://github.com/Redirapp/redirapp_sdk_ios.git", :tag => "#{s.version}" }

  s.platform     = :ios, "10.2"

  s.framework  = "UIKit"
  s.dependency 'Alamofire', '~> 4.4'
  s.source_files = "redirapp/**/*.{swift}"

  s.requires_arc = true

end
