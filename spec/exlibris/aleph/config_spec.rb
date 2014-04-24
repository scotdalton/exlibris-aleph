module Exlibris
  module Aleph
    describe Config do
      subject(:config) { Config }
      describe '.admin_libraries' do
        subject { Config.admin_libraries }
        it { should be_an Array }
        it 'should contain AdminLibraries' do
          subject.each do |admin_library|
            expect(admin_library).to be_an AdminLibrary
          end
        end
      end
    end
  end
end
