require 'rails_helper'

describe 'User', type: :system do
  before { driven_by :selenium_chrome_headless }

  # ユーザー情報入力用の変数
  let(:email) { 'test@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { password }

  describe 'ユーザー登録機能の検証' do
    before { visit '/users/sign_up' }

    context '正常' do
      it 'ユーザーを作成できる' do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button 'ユーザー登録'
      end
    end
  end
end
