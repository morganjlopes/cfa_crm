class AddCompanyTypeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :company_type, :integer
  end
end
