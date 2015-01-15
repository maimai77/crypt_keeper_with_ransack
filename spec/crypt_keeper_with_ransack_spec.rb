require 'spec_helper'

describe CryptKeeperWithRansack do
  it 'has a version number' do
    expect(CryptKeeperWithRansack::VERSION).not_to be nil
  end

  describe "#search" do
    before :each do
      User.create(name: 'MyText')
    end

    it { expect(User.find_by(name: 'MyText')).to be_nil }
    it { expect(User.search_by_plaintext(:name, 'MyText').count).to eq 1 }

    it { expect(User.where(name: 'MyText').count).to eq 0 }
    it { expect(User.search(name_eq: 'MyText').result.count).to eq 1 }

    it { expect(User.search(name_cont: 'My').result.count).to eq 1 }
    it { expect(User.search(name_cont: 'Your').result.count).to eq 0 }
  end
end
