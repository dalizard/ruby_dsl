require_relative 'smokestack'

World.define do
  factory User do
    name "John Appleseed"
    nickname "johnny"
  end
end

describe World do
  let(:user) { World.build(User) }
  let(:other_user) { World.build(User, name: "Bob Appleseed") }

  describe "#name" do
    it "returns the name of the user" do
      expect(user.name).to eql "John Appleseed"
      expect(other_user.name).to eql "Bob Appleseed"
    end
  end

  describe "#nickname" do
    it "returns the nickname of the user" do
      expect(user.nickname).to eql "johnny"
      expect(other_user.nickname).to eql "johnny"
    end
  end
end
