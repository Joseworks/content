class Language < ActiveRecord::Base
  include Indexable
  include Reconcile

  belongs_to :review_status

  has_many :document_languages
  has_many :documents, through: :document_languages

  acts_as_indexed

  reconciles(
    find: :name,
    normalize: :default,
    create: ->(context) {
      create!(name: context[:value], review_status: ReviewStatus.not_reviewed)
    }
  )
end
