# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180127023557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "seeker_id"
    t.bigint "job_id"
    t.string "resume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["seeker_id"], name: "index_applications_on_seeker_id"
  end

  create_table "employers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "compName"
    t.integer "compSize"
    t.string "city"
    t.string "logo"
    t.string "compDesc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "employer_id"
    t.string "title"
    t.string "jobType"
    t.datetime "expiry"
    t.string "status"
    t.boolean "temp"
    t.boolean "driversLicence"
    t.boolean "hasVehicle"
    t.string "salary"
    t.integer "payLow"
    t.integer "payHigh"
    t.integer "inSalesSoft"
    t.integer "inSalesHard"
    t.integer "outSalesSoft"
    t.integer "outSalesHard"
    t.text "summary"
    t.text "functions"
    t.text "skills"
    t.text "competencies"
    t.text "certifications"
    t.text "languages"
    t.integer "deptSize"
    t.text "benefits"
    t.boolean "coldCall"
    t.boolean "doorToDoor"
    t.boolean "custService"
    t.boolean "acctManagment"
    t.boolean "negotiation"
    t.boolean "presenting"
    t.boolean "leadership"
    t.boolean "closing"
    t.boolean "hunterBased"
    t.boolean "farmerBased"
    t.boolean "commBased"
    t.boolean "B2C"
    t.boolean "B2B"
    t.boolean "consSales"
    t.boolean "directSales"
    t.boolean "solutionSales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "CompUrl"
    t.text "commDirect"
    t.text "commResidual"
    t.text "commLead"
    t.index ["employer_id"], name: "index_jobs_on_employer_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.bigint "seeker_id"
    t.string "file"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seeker_id"], name: "index_resumes_on_seeker_id"
  end

  create_table "saved_jobs", force: :cascade do |t|
    t.bigint "seeker_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_saved_jobs_on_job_id"
    t.index ["seeker_id"], name: "index_saved_jobs_on_seeker_id"
  end

  create_table "seekers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "postalCode"
    t.string "educationLevel"
    t.text "certifications"
    t.string "degree"
    t.boolean "driversLicence"
    t.boolean "hasVehicle"
    t.integer "inSales"
    t.integer "outSales"
    t.boolean "inboundSales"
    t.boolean "outboundSales"
    t.boolean "coldCall"
    t.boolean "doorToDoor"
    t.boolean "custService"
    t.boolean "acctManagment"
    t.boolean "negotiation"
    t.boolean "presenting"
    t.boolean "leadership"
    t.boolean "closing"
    t.boolean "hunterBased"
    t.boolean "farmerBased"
    t.boolean "commBased"
    t.boolean "B2C"
    t.boolean "B2B"
    t.boolean "consSales"
    t.boolean "directSales"
    t.boolean "solutionSales"
    t.text "languages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_seekers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "firstName"
    t.string "lastName"
    t.string "phoneNo"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "seekers"
  add_foreign_key "employers", "users"
  add_foreign_key "jobs", "employers"
  add_foreign_key "resumes", "seekers"
  add_foreign_key "saved_jobs", "jobs"
  add_foreign_key "saved_jobs", "seekers"
  add_foreign_key "seekers", "users"
end
