platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', generate_multiple_pod_projects: true

target 'SendTreePay' do
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxSwiftExt'
  pod 'RxDataSources', '~> 4.0'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'SnapKit', '~> 5.0.0'
  
  target 'SendTreePayTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end
end
