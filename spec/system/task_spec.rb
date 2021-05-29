require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task)}
  let!(:task2) { FactoryBot.create(:task, expired_at: Time.current+2.days)}
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'new_title'
        fill_in 'task[content]', with: 'new_content'
        fill_in 'task[expired_at]', with: (Time.now)
        click_on 'Create Task'
        visit tasks_path
        expect(page).to have_content 'new_title'
      end
    end
    context 'タスクを終了期限でソートする場合' do
      it '終了期限でソートする' do
        visit tasks_path
        Task.order('expired_at').all.should == [task, task2]
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        page.html
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task')
         expect(page).to have_content 'task'
       end
     end
  end
end
