Gem::Specification.new do |gem|
  gem.name        = 'digital-river-ruby'
  gem.version     = '0.0.1'
  gem.authors     = [ 'Matthias Zirnstein' ]
  gem.email       = [ 'matthias.zirnstein@gmail.com' ]
  gem.description = 'Ruby wrapper for the Digital River shopper API'
  gem.summary     = "Ruby Digital River wrapper"
  gem.homepage    = 'https://github.com/zirni/digital-river-ruby'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")

  gem.add_runtime_dependency("typhoeus",      "~> 0.6.2" )
  gem.add_runtime_dependency("adamantium",    "~> 0.0.7" )
  gem.add_runtime_dependency("concord",       "~> 0.0.3" )
  gem.add_runtime_dependency("anima",         "~> 0.0.6" )
  gem.add_runtime_dependency("activesupport", "~> 3.2.13")
  gem.add_runtime_dependency("awesome_print", "~> 1.0.2" )
end
