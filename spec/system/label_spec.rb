require 'rails_helper'
require 'database_cleaner'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'
    visit new_label_path
    fill_in 'label[name]', with: "label_test"
    click_on 'Create label'
  end
  describe 'ラベル機能' do
      it '作成したレベルが確認できる' do
        expect(page).to have_content 'label_test'
      end
      it 'ラベルが削除できる' do
        user = FactoryBot.create(:user, id:7)
        label2 = FactoryBot.create(:label, name: "label2", user_id: 7)
        expect(label2.destroy).to be_valid
      end
    end
  end
