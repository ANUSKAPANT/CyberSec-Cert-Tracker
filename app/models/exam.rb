class Exam < ApplicationRecord
  belongs_to :cert_voucher
  validates :exam_code, presence: true
end
