require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package["name"]
  s.version      = package["version"]
  s.summary      = "Get device heading information on iOS or Android. Updated to use TurboModule"
  s.homepage     = "https://github.com/tiempham/react-native-heading"
  s.license      = package["license"]
  s.authors      = package["author"]
  s.platforms    = { ios: "13.0" }

  s.source       = { :path => "." }
  s.source_files = "ios/**/*.{h,mm}"

  install_modules_dependencies(s)

  s.dependency "React-Codegen"

  s.pod_target_xcconfig = {
    "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Public/React-Codegen\""
  }
end

