# expectations, not assertions
describe 'TennisScorer', 'basic scoring' do

  let(:ts) {Time.now}

  before(:each) do
    puts 'before each'
    ts.should == 1
  end

  after(:each) do
    puts 'after each'
  end

  it 'should do aaaa' do
    1.should == 2
  end

  it 'should do bbbb' do

  end

  it 'should do ccc'

  it 'should do dddd'
end
