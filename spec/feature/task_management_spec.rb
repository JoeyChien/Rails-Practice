require "rails_helper"

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
    visit tasks_path(task)

    click_link I18n.t('action.delete')

    expect(page).to have_text(I18n.t('message.delete_success'))
    expect{Task.find(task.id)}.to raise_exception(ActiveRecord::RecordNotFound)    
  end
end
