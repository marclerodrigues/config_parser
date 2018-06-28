RSpec.describe ConfigParser::Parser do
  let(:file_path) { "spec/testfile" }

  subject { described_class.new(file_path: file_path).perform }

  it 'returns the correct hash' do
    expect(subject).to match({
      "host"=>"test.com",
      "server_id"=>"55331",
      "server_load_alarm"=>"2.5",
      "user"=>"john",
      "verbose"=>true,
      "test_mode"=>true,
      "debug_mode"=>false,
      "log_file_path"=>"/tmp/logfile.log",
      "send_notifications"=>true
    })
  end

  it 'uses the appropriate data type' do
    debug_mode = subject["debug_mode"]
    expect(debug_mode).to be false
  end
end
