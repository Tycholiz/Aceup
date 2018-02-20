class AddAspectsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :AspProspecting, :boolean
    add_column :jobs, :AspcoldCall, :boolean
    add_column :jobs, :AspdoorToDoor, :boolean
    add_column :jobs, :AspWarmLeads, :boolean
    add_column :jobs, :AspNetworking, :boolean
    add_column :jobs, :AspPresenting, :boolean
    add_column :jobs, :AspClosing, :boolean
    add_column :jobs, :AspNegotiation, :boolean
    add_column :jobs, :AspacctManagment, :boolean
    add_column :jobs, :AspB2B, :boolean
    add_column :jobs, :AspB2C, :boolean
    add_column :jobs, :AspInSales, :boolean
    add_column :jobs, :AspOutSales, :boolean
    add_column :jobs, :AspInbound, :boolean
    add_column :jobs, :AspOutbound, :boolean
    add_column :jobs, :AspOvernight, :boolean
    add_column :jobs, :AspLocal, :boolean
  end
end
