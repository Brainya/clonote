class Note < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :note_magazines, dependent: :destroy
  has_many :magazines, through: :note_magazines
  belongs_to :user
  mount_uploader :header_image, ImageUploader
  acts_as_taggable

  def last(limit)
    user.notes.order('created_at DESC').limit(limit)
  end

  def prev
    user.notes.where('(is_draft = false) AND (id < ?)', self.id).order('id DESC').first
  end
 
  def next
    user.notes.where('(is_draft = false) AND (id > ?)', self.id).order('id ASC').first
  end

  def published
    user.notes.where(is_draft: false)
  end

  def created_at_jp
    self.created_at.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[self.created_at.wday]}) %X")
  end
end
