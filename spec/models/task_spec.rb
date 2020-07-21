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

  describe "search for task" do
    let(:inprogress_task) { create(:task, title: "My first task title", status: 'inprogress') }
    let(:pending_task) { create(:task, title: "My second task title", status: 'pending') }

    before do
      inprogress_task
      pending_task
    end

    it "find by task title" do
      result = Task.query_by_title("first task")
      expect(result).to eq([inprogress_task])
    end

    it "not found by task title" do
      expect(Task.query_by_title("not")).to be_empty
    end

    it "find by task status" do
      result = Task.filter_by_status('pending')
      expect(result).to eq([pending_task])
    end

    it "not found by task status" do
      expect(Task.filter_by_status('completed')).to be_empty
    end
  end
  describe '.query_by_title' do
    let(:first_task) { create(:task, title: "My first task title") }
    let(:second_task) { create(:task, title: "My second task title") }

    before do
      first_task
      second_task
    end

    it "find by task title" do
      result = Task.query_by_title("first task")
      expect(result).to eq([first_task])
    end

    it "not found by task title" do
      expect(Task.query_by_title("not")).to be_empty
    end   
  end

  describe '.filter_by_status' do   
    let(:inprogress_task) { create(:task, title: "My inprogress task title", status: 'inprogress') }
    let(:pending_task) { create(:task, title: "My pending task title", status: 'pending') }

    before do
      inprogress_task
      pending_task
    end

    it "find by task status" do
      result = Task.filter_by_status('pending')
      expect(result).to eq([pending_task])
    end

    it "not found by task status" do
      expect(Task.filter_by_status('completed')).to be_empty
    end
  end
end
