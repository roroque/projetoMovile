source 'https://github.com/CocoaPods/Specs'
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!
target "united Series", :exclusive => true do
    pod 'Alamofire'
    pod 'Result'
    pod 'Kingfisher', '~> 1.4'
    pod 'TUSafariActivity', '~> 1.0'
    pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
end



target :unit_tests, :exclusive => true do
    link_with 'UnitTests'
    pod 'Nimble'
    pod 'OHHTTPStubs'
end