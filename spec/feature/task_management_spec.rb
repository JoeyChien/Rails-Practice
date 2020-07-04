require "rails_helper"

RSpec.feature "Task list order by created time" do
  let(:old_task) { create(:task, created_at: "2020-07-01 12:27:00") }
  let(:new_task) { create(:task, created_at: "2020-07-02 12:27:00") }

  before do
    old_task
    new_task
  end

  scenario "should order by time desc" do
    visit tasks_path    

    within "thead tr:nth-child(1)" do
      expect(page).to have_text("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.attributes.task.content')} #{I18n.t('action.edit')} #{I18n.t('action.delete')}")
    end
    expect_position_is(1, new_task)
    expect_position_is(2, old_task)
  end 
end

RSpec.feature "Task management" do  
  scenario "User create a new task" do
    visit new_task_path

    fill_in I18n.t('activerecord.attributes.task.title'), with: "My title"
    fill_in I18n.t('activerecord.attributes.task.content'), with: "My content"
    click_button I18n.t('helpers.submit.task.create')

    task_last = Task.last
    
    expect(page).to have_text(I18n.t('message.create_success'))
    expect(task_last.title).to eq ("My title") 
    expect(task_last.content).to eq ("My content")
  end

  scenario "User edit a task" do
    task = Task.create(title: "My title", content: "My conetent")
    visit edit_task_path(task)

    fill_in I18n.t('activerecord.attributes.task.title'), with: "Edit my title"
    fill_in I18n.t('activerecord.attributes.task.content'), with: "Edit my content"
    click_button I18n.t('helpers.submit.task.update')
    
    updated_task = Task.find(task.id)

    expect(page).to have_text(I18n.t('message.update_success'))
    expect(updated_task.title).to eq ("Edit my title")
    expect(updated_task.content).to eq ("Edit my content")
  end

  scenario "User delete a task" do
    task = Task.create(title: "My title", content: "My conetent")
    visit tasks_path

    click_link I18n.t('action.delete')

    expect(page).to have_text(I18n.t('message.delete_success'))
    expect{Task.find(task.id)}.to raise_exception(ActiveRecord::RecordNotFound)
  end
end

def expect_position_is(position, task)
  within "tbody tr:nth-child(#{position})" do
    expect(page).to have_text("#{task.title} #{task.content} #{I18n.t('action.edit')} #{I18n.t('action.delete')}")
  end
end
