require "rails_helper"

RSpec.feature "Task management" do
  scenario "User create a new task" do
    visit new_task_path

    fill_in "任務名稱", with: "My title"
    fill_in "任務內容", with: "My content"
    click_button 'Create Task'

    task_last = Task.last
    
    expect(page).to have_text("新增成功")
    expect(task_last.title).to eq ("My title") 
    expect(task_last.content).to eq ("My content") 
  end

  scenario "User edit a task" do
    task = Task.create(title: "My title", content: "My coneten")
    visit edit_task_path(task)

    fill_in "任務名稱", with: "Edit my title"
    fill_in "任務內容", with: "Edit my content"
    click_button 'Update Task'
    
    updated_task = Task.find(task.id)

    expect(page).to have_text("修改成功")
    expect(updated_task.title).to eq ("Edit my title") 
    expect(updated_task.content).to eq ("Edit my content") 
  end

  scenario "User delete a task" do
    task = Task.create(title: "My title", content: "My coneten")
    visit tasks_path(task)

    click_link '刪除'

    expect(page).to have_text("刪除成功")
    expect{Task.find(task.id)}.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
