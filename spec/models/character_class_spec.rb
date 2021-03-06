require 'rails_helper'

RSpec.describe CharacterClass, type: :model do
  before(:example) do
    @new_class = CharacterClass.create(name: "Zoomer", hit_die: 8, bab: "Mid", base_skills: 6, caster: false)
  end
  context "#name" do
    it { should have_valid(:name).when("Fighter", "Mage", "Thief") }
    it { should_not have_valid(:name).when(nil, "") }

    it {should validate_uniqueness_of(:name) }
  end

  context "#hit_die" do
    it { should have_valid(:hit_die).when(6, 8, 10, 12) }
    it { should_not have_valid(:hit_die).when(nil, "", 5, -4) }
  end

  context "#bab" do
    it { should have_valid(:bab).when("Full", "Mid", "Half") }
    it { should_not have_valid(:bab).when(nil, "", 12, "Caster", "Fighter") }
  end

  context "#skill_base" do
    it { should have_valid(:base_skills).when(2, 4, 6, 8) }
    it { should_not have_valid(:base_skills).when(nil, "", 5, -4) }
  end


end
