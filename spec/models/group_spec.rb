require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create(name: 'bilal', email: 'bilal@gmail.com', password: '123456', password_confirmation: '123456',
                        id: 1)
    @group = Group.create(author_id: @user.id, name: 'test', icon: 'http//:test.com')
  end

  it 'is invalid without group name' do
    @group.name = nil
    expect(@group).not_to be_valid
  end

  it 'is invalid without author' do
    @group.author_id = nil
    expect(@group).not_to be_valid
  end

  it 'has association with correct author' do
    expect(@group.author.name).to eq(@user.name)
  end

  it 'is invalid without icon link' do
    @group.icon = nil
    expect(@group).not_to be_valid
  end
end
