source 'https://github.com/ADModulization/ADSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

target 'ADFLiOS' do 
	pod 'ADFLiOSResource', '0.7'
end

def parse_KV_file(file, separator='=')
    file_abs_path = File.expand_path(file)
    if !File.exists? file_abs_path
        return [];
    end
    pods_ary = []
    skip_line_start_symbols = ["#", "/"]
    File.foreach(file_abs_path) { |line|
        next if skip_line_start_symbols.any? { |symbol| line =~ /^\s*#{symbol}/ }
        plugin = line.split(pattern=separator)
        if plugin.length == 2
            podname = plugin[0].strip()
            path = plugin[1].strip()
            podpath = File.expand_path("#{path}", file_abs_path)
            pods_ary.push({:name => podname, :path => podpath});
            else
            puts "Invalid plugin specification: #{line}"
        end
    }
    return pods_ary
end

# Plugin Pods
plugin_pods = parse_KV_file('./Pods/ADFLiOSResource/ADFLiOSResource/ADFLiOSResource/.flutter-plugins')
plugin_pods.map { |p|
    pod p[:name], :path => File.join(p[:path], 'ios')
}

# ENABLE_BITCODE
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
