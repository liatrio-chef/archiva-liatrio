require 'minitest/spec'

def service_is_listening( port, service )
  assert system "sudo netstat -lp --numeric-ports | grep \":#{port}.*LISTEN.*#{service}\""
end

def web_check_match( url, check )
  assert system "wget -q -O - #{url} | grep '#{check}'"
end

describe_recipe 'archiva-liatrio::default' do

  # XXX write tests for connectivity that use default[:archiva][:webport]
  #it "listens for java on tcp port 8080" do
  #  service_is_listening("80", "httpd")
  #end

  #it 'must match the web check Apache' do
  #  web_check_match("http://127.0.0.1/", "Apache")
  #end

  it 'must have created /opt/archiva folder' do
    file("/opt/archiva")
  end

  it "boots on startup" do
    service("archiva").must_be_enabled
  end

  it "runs as a daemon" do
    service("archiva").must_be_enabled
  end

end
