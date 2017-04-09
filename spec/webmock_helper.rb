require 'webmock'
require 'yaml'
require 'json'

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)

def load_stub_from_json(path)
  file_path = File.join(FIXTURES_PATH, "#{path}.json")
  File.exist?(file_path) ? File.read(file_path) : raise("#{file_path} is not found.")
end

def hash_stub_from_json(path)
  JSON.parse(load_stub_from_json(path), symbolize_names: true)
end

NIS_URL = 'http://127.0.0.1:7890'.freeze
routes  = YAML.load_file(File.join(FIXTURES_PATH, 'webmock_routes.yml'))

WebMock.enable!
routes.each do |path, opts|
  stub_method = (opts['method'] || :get).to_sym
  stub_status = (opts['status'] || 200).to_i
  stub_path   = (opts['stub']   || path).tr('/', '_')
  stub_body   = load_stub_from_json(stub_path)
  stub_params = opts['params']

  webmock = WebMock.stub_request(stub_method, "#{NIS_URL}/#{path}").to_return(
    body:    stub_body,
    status:  stub_status,
    headers: { 'Content-Type' => 'application/json' }
  )

  unless stub_params.nil?
    if stub_method == :post
      webmock.with(
        body: stub_params,
        headers: { 'Content-Type' => 'application/json' }
      )
    else
      webmock.with(
        query: stub_params
      )
    end
  end
end
