require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { create(:task) }

  before do
    task
  end

  it "it contain title & content" do
    task.title
    task.content
  end

  it "is not valid without a title" do
    task.title = nil
    expect(task).to_not be_valid
  end
end
