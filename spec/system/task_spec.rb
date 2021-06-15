require 'rails_helper'
require 'database_cleaner'
RSpec.describe 'タスク管理機能', type: :system do
  before (:each) do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'
    visit new_label_path
    fill_in 'label[name]', with: "label_test"
    click_on 'Create label'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'new_title'
        fill_in 'task[content]', with: 'new_content'
        fill_in 'task[expired_at]', with: (Time.now)
        find_field ('task[status]')
        find_field ('task[pripority]')
        check ('label_test')
        click_on 'submit'
        visit tasks_path
        expect(page).to have_content 'label_test'
      end
    end
    context 'タスクを終了期限でソートする場合' do
      it '終了期限でソートする' do
        task = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, expired_at: Time.current+2.days)
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
        expect(page).to have_content 'Task Management'
      end
    end
    context '一覧画面に遷移した場合' do
      it 'ページネーションを追加する' do
        visit tasks_path
        expect{ find_link('2', rel="prev").click }
        expect{ find_link('1', rel="next").click }
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
         it '新しいタスクが一番上に表示される' do
           task = FactoryBot.create(:task, title: 'task')
           task_order = FactoryBot.create(:task, title: 'task')
           Task.order('created_at desc').all.should == [task_order, task]
        end
      end
   end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit tasks_path
         expect(page).to have_content 'Task Management'
       end
     end
  end
  describe '優先順位' do
    context '優先順位でソートするというリンクを押す場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, pripority: 'high')
        visit tasks_path
        click_link ('Sort By Pripority')
        Task.order('pripority').all.should == [task2, task]
      end
    end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:task, title: "task", status: "unstarted")
      FactoryBot.create(:task, title: "sample", status: "completed")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task'
        click_button('search')
        expect(page).to have_content (/task/i)
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        Task.search('','completed','')
        expect(page).to have_content ('completed')
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        Task.search('task','unstarted','')
        expect(page).to have_content (/task/i)
        expect(page).to have_content ('unstarted')
      end
    end
    context 'ラベルで検索した場合' do
      it 'ラベルが検索できる' do
        visit tasks_path
        Task.search('','','label_test')
        expect(page).to have_content ('label_test')
      end
    end
  end
end
