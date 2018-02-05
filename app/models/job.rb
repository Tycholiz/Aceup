class Job < ApplicationRecord

      belongs_to :employer
      has_many :applications, dependent: :destroy
      has_many :saved_jobs, dependent: :destroy

      serialize :languages
      serialize :benefits, Array
      serialize :certifications

      is_impressionable

      before_validation do |model|
        model.languages.reject!(&:blank?) if model.languages
        model.certifications.reject!(&:blank?) if model.certifications
      end

      # before_save :fix_benefits

      # def fix_benefits
      #   if self.benefits.is_a?(String)
      #           logger.info self.benefits
      #           self.benefits = self.benefits.split(',')
      #           logger.info self.benefits
      #   end
      # end

      validates :employer_id,
        presence: true

      validates :title,
        presence: true
     
      validates :title,
        presence: true

      # validates :temp,
      #   presence: true

      validates :languages,
        presence: true

      validates :salary, 
        presence: {message: "Must choose either Salary or Hourly"}

      validates :payLow,
        presence: true,
        numericality: { only_integer: true }

      validates :payHigh,
        presence: true,
        numericality: { only_integer: true }

      validates :inSalesSoft,
        presence: true
        # numericality: { only_integer: true }

      validates :inSalesHard,
        presence: true
        # numericality: { only_integer: true }

      validates :outSalesSoft,
        presence: true
        # numericality: { only_integer: true }

      validates :outSalesHard,
        presence: true
        # numericality: { only_integer: true }

      validates :functions,
        presence: true

      validates :skills,
        presence: true

      # validates :summary,
      #   presence: true

      # validates :competencies,
      #   presence: true

      validates :deptSize,
        presence: true,
        numericality: { only_integer: true }

      validates :benefits,
        presence: true

      validates :educationLevel,
      presence: true

      def self.filter(filter_years, filter_salary)
        if filter_years && filter_salary
          where('"inSalesHard" >= ? AND "payLow" >= ?', "#{filter_years}", "#{filter_salary}")
        elsif filter_years
          where('"inSalesHard" > ?', "#{filter_years}")
        elsif filter_salary
          where('"payLow" >= ?', "#{filter_salary}")
        else
          all
        end
      end
end