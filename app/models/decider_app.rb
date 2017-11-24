class DeciderApp < ApplicationRecord
  validates_presence_of :name, :web_url, :git_url
  belongs_to :team

  def dsn
    "#{web_url}decide"
  end
end
