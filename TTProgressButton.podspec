Pod::Spec.new do |s|
    s.name             = "TTProgressButton"
    s.version          = "1.0.0"
    s.summary          = "A custom UIButton which has a progress border indicator."
    s.description      = <<-DESC
    A custom circular UIButton which has a progress border indicator. It is designed to animate an array of images while indicating the progress. You can set the speed of the image animation and change the appearance of the button. The example shows how the button can be used while sending a tweet.

    DESC
    s.homepage         = "https://github.com/TriggerTrap/TTProgressButton"
    s.license          = 'MIT'
    s.author           = { "Valentin Kalchev" => "vkalchev@outlook.com" }
    s.source           = { :git => "https://github.com/TriggerTrap/TTProgressButton.git", :tag => "v1.0.0" }

    s.platform     = :ios, '7.0'
    s.requires_arc = true

    s.source_files = 'Source', 'Source/**/*.{h,m}'
    s.resources = ["Assets/*.png"]
    s.resource_bundles = {
        'Assets' => ['Assets/*.{png, jpg}']
    }
end
