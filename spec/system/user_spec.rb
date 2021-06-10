require 'rails_helper'
require 'database_cleaner'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規作成機能' do
    context '新規ユーザーを登録した場合' do
      it '新規ユーザーが登録できる' do
        visit new_user_path
        user = FactoryBot.create(:user)
        expect(user).to be_valid
      end
    end
    context 'ログインせずタスク一覧画面に飛ぶ場合' do
      it 'ログイン画面に遷移する'  do
        visit tasks_path
        expect(page).to have_selector 'h2', text: 'Log In'
      end
    end
  end
  describe 'セッション機能' do
    context 'ログインする場合' do
      before do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on 'Log In'
      end
      it 'ログインができる' do
        visit tasks_path
        expect(page).to have_content 'Logout'
      end
      it '詳細画面(マイページ)に飛べる' do
        visit tasks_path
        click_on 'Profile'
        expect(page).to have_selector 'h2', text: 'Profile'
      end
      it '他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        user2 = FactoryBot.create(:user, id:2, email: "user2@email.com")
        visit(user_path(user2.id))
        expect(page).to have_selector 'h1', text: 'Task Management'
      end
      it 'ログアウトができる' do
        visit tasks_path
        click_on 'Logout'
        expect(page).to have_content 'Logged out'
      end
      it '一般ユーザは管理画面にアクセスできない' do
        visit tasks_path
        click_on 'Admin'
        expect(page).to have_content "管理者以外はアクセスできない"
      end
    end
  end
  describe '管理画面機能' do
    context '管理画面にアクセスする場合' do
      before do
        visit new_user_path
        user = FactoryBot.create(:user, role: "admin")
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_on 'Log In'
      end
      it '管理ユーザはアクセスできる' do
        visit tasks_path
        expect(page).to have_content 'Logout'
      end
      it 'ユーザの詳細画面にアクセスできること' do
        user2 = FactoryBot.create(:user, id:2, email: "user2@email.com")
        visit(admin_user_path(user2.id))
        expect(page).to have_selector 'h2', text: 'Profile'
      end
      it 'ユーザの編集画面からユーザを編集できること' do
        user2 = FactoryBot.create(:user, id:2, email: "user2@email.com")
        visit(edit_admin_user_path(user2.id))
        expect(page).to have_selector 'h1', text: 'Edit User by Admin'
      end
      it 'ユーザの削除をできること' do
        user2 = FactoryBot.create(:user, id:2, email: "user2@email.com")
        expect(user2.destroy).to be_valid
      end
    end
    context '管理ユーザは新規ユーザーを登録した場合' do
      it 'ユーザの新規登録ができる' do
        visit new_user_path
        user = FactoryBot.create(:user, role: "admin")
        expect(user).to be_valid
      end
    end
  end
end
