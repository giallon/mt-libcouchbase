require File.expand_path("../lib/mt-libcouchbase/version", __FILE__)

Gem::Specification.new do |gem|
    gem.name          = "mt-libcouchbase"
    gem.version       = MTLibcouchbase::VERSION
    gem.license       = 'MIT'
    gem.authors       = ["Giallombardo Nathan"]
    gem.email         = ["nathan.giallombardo@mapotempo.com"]
    gem.homepage      = "https://github.com/Mapotempo/mt-libcouchbase"
    gem.summary       = "mt-libcouchbase bindings for Ruby"
    gem.description   = "A wrapper around mt-libcouchbase for Ruby"

    gem.extensions << "ext/Rakefile"

    gem.required_ruby_version = '>= 2.1.0'
    gem.require_paths = ["lib"]

    gem.add_runtime_dependency     'ffi', '~> 1.9'
    gem.add_runtime_dependency     'concurrent-ruby', '~> 1.0'
    gem.add_runtime_dependency     'mt-libuv', '~> 4.1', '>= 4.1.02'

    gem.add_development_dependency 'rake',         '~> 11.2'
    gem.add_development_dependency 'rspec',        '~> 3.5'
    gem.add_development_dependency 'yard',         '~> 0.9'
    gem.add_development_dependency 'mt-uv-rays',   '~> 2.4', '>= 2.4.7' # for libuv spec
    gem.add_development_dependency 'em-synchrony', '~> 1.0' # for eventmachine spec

    # https://github.com/stakach/ffi-gen
    # gem.add_development_dependency 'ffi-gen'

    gem.files         = `git ls-files`.split("\n")
    gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

    if File.exist? 'ext/libcouchbase.dll'
        gem.files += ['ext/libcouchbase.dll', 'ext/libcouchbase_libuv.dll']
    end 

    # Add the submodule to the gem
    relative_path = File.expand_path("../", __FILE__) + '/'
    `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|

        if (ENV['OS'] == 'Windows_NT') && submodule_path[0] == '/'
            # Detect if cygwin path is being used by git
            submodule_path = submodule_path[1..-1]
            submodule_path.insert(1, ':')
        end

        # for each submodule, change working directory to that submodule
        Dir.chdir(submodule_path) do
            # Make the submodule path relative
            submodule_path = submodule_path.gsub(/#{relative_path}/i, '')

            # issue git ls-files in submodule's directory
            submodule_files = `git ls-files`.split(/\n+|\r+/)

            # prepend the submodule path to create relative file paths
            submodule_files_paths = submodule_files.map do |filename|
                File.join(submodule_path, filename)
            end

            # add relative paths to gem.files
            gem.files += submodule_files_paths
        end
    end

    # Remove sym link (blows up on windows)
    gem.files.delete('ext/libcouchbase/configure.pl')
end
