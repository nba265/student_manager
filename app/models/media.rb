# frozen_string_literal: true

# == Schema Information
#
# Table name: media
#
#  id         :bigint           not null, primary key
#  audio      :string(255)
#  avatar     :string(255)
#  video      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_media_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class Media < ApplicationRecord
  belongs_to :student

  mount_uploader :audio, AudioUploader
  mount_uploader :video, VideoUploader
  mount_uploader :avatar, AvatarUploader
end
