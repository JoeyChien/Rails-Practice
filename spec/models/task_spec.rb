require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  before do
    task
  end

  it "it contain title & content" do
    expect(task.title).to be_present
    expect(task.content).to be_present
  end

  it "is not valid without a title" do
    task.title = nil
    expect(task).to_not be_valid
    expect(task.errors.full_messages.first).to match("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
  end
end
