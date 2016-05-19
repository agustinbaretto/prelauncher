require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 10,
      'html' => 'VIP Fan<br>Pack',
      'class' => 'two',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/x@2x.png')
    },
    {
      'count' => 25,
      'html' => 'VIP Fan<br>Pack',
      'class' => 'three',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/x@2x.png')
    },
    {
      'count' => 100,
      'html' => 'Bluesmart<br>One',
      'class' => 'four',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/x@2x.png')
    },
    {
      'count' => 50,
      'html' => 'Bluesmart<br>Black Edition ($200)',
      'class' => 'five',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/x@2x.png')
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver_later
  end
end
