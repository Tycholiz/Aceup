class Job < ApplicationRecord

      validates :title,
        presence: true
     
      validates :title,
        presence: true

      validates :temp,
        presence: true

      validates :salary,
        presence: true

      validates :payLow,
        presence: true,
        numericality: { only_integer: true }

      validates :payHigh,
        presence: true,
        numericality: { only_integer: true }

      validates :inSalesSoft,
        presence: true,
        numericality: { only_integer: true }

      validates :inSalesHard,
        presence: true,
        numericality: { only_integer: true }

      validates :outSalesSoft,
        presence: true,
        numericality: { only_integer: true }

      validates :outSalesHard,
        presence: true,
        numericality: { only_integer: true }

      validates :functions,
        presence: true

      validates :skills,
        presence: true

      validates :summary,
        presence: true

      validates :competencies,
        presence: true

      validates :deptSize,
        presence: true,
        numericality: { only_integer: true }

      validates :benefits,
        presence: true
end