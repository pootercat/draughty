FactoryGirl.define do

  factory :pick do
    round 1
    pick 1
  end

  factory :team do
    tname "Browns"
    division "AAA"
  end

  factory :player do
    pname "John Smith"
    position "QB"
  end

end
