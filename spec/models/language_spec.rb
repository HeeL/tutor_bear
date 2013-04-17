require 'spec_helper'

describe Language do
  subject { Language }
  
  context 'match found' do
    before :each do
      @lang1 = FactoryGirl.create(:language, name: 'Ruby')
      @lang2 = FactoryGirl.create(:language, name: 'Ruby++')
    end

    context 'exact match on' do
      it "finds matching names" do
        subject.match_names('Ruby', true).should eql([@lang1.name])
      end
    end

    it "finds matching names" do
      subject.match_names('Ru').should eql([@lang2.name, @lang1.name])
      subject.match_names('Ruby').should eql([@lang2.name, @lang1.name])
      subject.match_names('Ruby+').first.should eql(@lang2.name)
    end

    it 'ignores the case of letters' do
      subject.match_names('RuBy++').first.should eql(@lang2.name)
    end
  end
  
  context 'nothing found' do
    let(:result) { subject.match_names('something') }

    it 'returns an empty array' do
      result.should eq([])
    end
  end

end
