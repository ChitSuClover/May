require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: 'TITLE', content: 'Test Passed')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', status: "unstarted") }
    let!(:task2) { FactoryBot.create(:task, title: "sample", status: "completed") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.where(title:'task')).to include(task)
        expect(Task.where(title:'task')).not_to include(task2)
        expect(Task.where(title:'task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.where(status:'unstarted')).to include(task)
        expect(Task.where(status:'unstarted')).not_to include(task2)
        expect(Task.where(status:'unstarted').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.where(title:'task').where(status:'unstarted')).to include(task)
        expect(Task.where(title:'task').where(status:'unstarted')).not_to include(task2)
        expect(Task.where(title:'task').where(status:'unstarted').count).to eq 1
      end
    end
  end
end
