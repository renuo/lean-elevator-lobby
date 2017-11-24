RSpec.describe PlayMasterService do
  let(:service) { described_class.new([]) }

  describe '#configure_round' do
    pending 'runs through' do
      expect(HerokuService).to receive(:new).and_return(double(create_build: 'sample.herokuapp.com'))
      service.run
    end
  end
end