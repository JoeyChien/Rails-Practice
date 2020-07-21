require "rails_helper"

RSpec.feature 'Task management' do
  feature 'Task order' do
    context 'should order by time desc' do
      let(:old_task) { create(:task, created_at: "2020-07-01 12:27:00") }
      let(:new_task) { create(:task, created_at: "2020-07-02 12:27:00") }

      before do
        old_task
        new_task
      end

      scenario 'when by time asc' do
        visit tasks_path

        expect_order('title', new_task.title, old_task.title)
        expect_order('content', new_task.content, old_task.content)
      end
    end
    context 'click sort by end time' do
      let(:earlier_end_task) { create(:task, end_time: "2020-07-10 12:27:00") }
      let(:later_end_task) { create(:task, end_time: "2020-07-12 12:27:00") }

      before do
        earlier_end_task
        later_end_task
      end

      scenario "should order by end time asc" do 
        visit tasks_path    
    
        click_link I18n.t('activerecord.attributes.task.end_time')
        
        expect_order('title', earlier_end_task.title, later_end_task.title)
        expect_order('content', earlier_end_task.content, later_end_task.content)
      end 
    end   
  end

  feature 'Task CRUD' do
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
  
      click_link(I18n.t('action.delete'), href: task_path(task))
  
      expect(page).to have_text(I18n.t('message.delete_success'))
      expect{Task.find(task.id)}.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  feature 'Task search' do
    context 'Search by title & status' do
      let(:inprogress_task) { create(:task, title: "My inprogress task", status: 1) }
      let(:pending_task) { create(:task, title: "My pending task", status: 0) }

      before do
        inprogress_task
        pending_task
      end

      scenario "Search by title & status" do
        visit tasks_path
       
        find("input.query-title").set "task"
        select I18n.t("enums.task.statuses.pending"), from: 'status'
        click_button I18n.t('helpers.search')

        expect_search('title', pending_task.title)
        expect_search('content', pending_task.content)
      end

      scenario "Search by status" do
        visit tasks_path
       
        select I18n.t("enums.task.statuses.inprogress"), from: 'status'
        click_button I18n.t('helpers.search')

        expect_search('title', inprogress_task.title)
        expect_search('content', inprogress_task.content)
      end

      scenario "Search by title" do
        visit tasks_path
       
        find("input.query-title").set "inprogress task"
        click_button I18n.t('helpers.search')

        expect_search('title', inprogress_task.title)
        expect_search('content', inprogress_task.content)
      end
    end   
  end

  private
  
  def expect_order(column, fisrt_task, second_task)
    @tasks = []
    page.all(".task-#{column}").each do | element |
      @tasks << element.text
    end
    expect(@tasks).to eq [fisrt_task, second_task]
  end

  def expect_search(column, task)
    @tasks = []
    page.all(".task-#{column}").each do | element |
      @tasks << element.text
    end
    expect(@tasks).to eq [task]
  end

end
