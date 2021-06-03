require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, pripority: 'high')}
  let!(:task2) { FactoryBot.create(:task, expired_at: Time.current+2.days, pripority: 'low')}
  let!(:task_order) { FactoryBot.create(:task, title: 'task')}
 before do
   visit tasks_path
 end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'new_title'
        fill_in 'task[content]', with: 'new_content'
        fill_in 'task[expired_at]', with: (Time.now)
        find_field ('task[status]')
        click_on 'submit'
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
    context '一覧画面に遷移した場合' do
      it 'ページネーションを追加する' do
        visit tasks_path
        expect{ find_link('2', rel="prev").click }
        expect{ find_link('1', rel="next").click }
      end
    end
  end
    context 'タスクが作成日時の降順に並んでいる場合' do
         it '新しいタスクが一番上に表示される' do
           Task.order('created_at desc').all.should == [task_order, task]
        end
      end
   end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task')
         visit tasks_path
         expect(page).to have_content 'task'
       end
     end
  end
  describe '優先順位' do
    context '優先順位でソートするというリンクを押す場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_link ('Sort By Pripority')
        Task.order('pripority').all.should == [task, task2]
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
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select ('completed')
        click_button('search')
        expect(page).to have_content 'completed'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task'
        select ('unstarted')
        click_button('search')
        expect(page).to have_content ('task')
        expect(page).to have_content ('unstarted')
      end
    end
  end
end
