require 'rails_helper'

RSpec.describe User, type: :model do
  describe '使用者單元測試' do
    subject { build(:user)}

    it { should validate_presence_of(:username) } 
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }

    it { should validate_presence_of(:email) }  
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_most(100) }

  end
end