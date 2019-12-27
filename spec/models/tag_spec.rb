require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '標籤單元測試' do
    subject { build(:tag)}

    it { should validate_presence_of(:name) } 
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(15) }
  end
end
