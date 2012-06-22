%w(
  json
  thread
  readline
  active_support/core_ext
  active_support/dependencies
  active_support/cache
  twitter/json_stream
  notify
  ap
  launchy
  oauth
  twitter_oauth
).each { |lib| require lib }

Thread.abort_on_exception = true
Encoding.default_external = Encoding.find('UTF-8')

%w(
  ext
  core
  cache
  output
  input
  get_access_token
  twitter
  help
  commands
  id_var
).each { |name| require_dependency File.expand_path("../drab/#{name}", __FILE__) }