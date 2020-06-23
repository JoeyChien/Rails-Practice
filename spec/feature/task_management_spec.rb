require "rails_helper"

RSpec.feature "Task management" do
  scenario "User create a new task" do
    visit new_task_path

    fill_in "任務名稱", with: "My title"
    fill_in "任務內容", with: "My content"
    click_button 'Create Task'

    expect(page).to have_text("新增成功")
  end

  scenario "User edit a task" do
    task = Task.create(title: "My title", content: "My coneten")
    visit edit_task_path(task)

    fill_in "任務名稱", with: "Edit my title"
    fill_in "任務內容", with: "Edit my content"
    click_button 'Update Task'

    expect(page).to have_text("修改成功")
  end

  scenario "User delete a task" do
    task = Task.create(title: "My title", content: "My coneten")
    visit tasks_path(task)

    click_link '刪除'

    expect(page).to have_text("刪除成功")
  end
end
