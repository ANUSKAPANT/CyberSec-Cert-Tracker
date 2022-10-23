class CertVoucher < ApplicationRecord
  belongs_to :student_course
  has_one :exam
  validates :certification_name, presence: true
end
