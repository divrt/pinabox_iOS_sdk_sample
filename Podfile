# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'PinaboxDemoApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PinaboxDemoApp

    pod 'DivrtPinabox'

  target 'PinaboxDemoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
         config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
     end
   end
end
