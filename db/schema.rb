# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140626122441) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "super",                  default: false
    t.integer  "accessLevel",            default: 2
    t.integer  "superadmin",             default: 0
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ranking",    default: 999, null: false
  end

  create_table "annualreports", force: true do |t|
    t.integer  "fiscal_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.string   "file_name"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "attachment"
    t.integer  "ranking",         default: 999, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brlevel_translations", force: true do |t|
    t.integer  "brlevel_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "brlevel_translations", ["brlevel_id"], name: "index_brlevel_translations_on_brlevel_id"
  add_index "brlevel_translations", ["locale"], name: "index_brlevel_translations_on_locale"

  create_table "brlevels", force: true do |t|
    t.integer  "level"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ranking",    default: 999,   null: false
    t.string   "locale"
    t.boolean  "messup",     default: false, null: false
    t.integer  "chaos",      default: 404
  end

  create_table "brproduct_translations", force: true do |t|
    t.integer  "brproduct_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "brproduct_translations", ["brproduct_id"], name: "index_brproduct_translations_on_brproduct_id"
  add_index "brproduct_translations", ["locale"], name: "index_brproduct_translations_on_locale"

# Could not dump table "brproducts" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "dividend_histories", force: true do |t|
    t.integer  "fiscal_year",                                              null: false
    t.decimal  "sre",               precision: 17, scale: 3, default: 0.0, null: false
    t.decimal  "scap",              precision: 17, scale: 3, default: 0.0, null: false
    t.decimal  "cash",              precision: 17, scale: 3, default: 0.0, null: false
    t.decimal  "total",             precision: 17, scale: 3, default: 0.0, null: false
    t.date     "stock_paymentdate"
    t.date     "cash_paymentdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ranking",                                    default: 999, null: false
  end

  create_table "financialprojections", force: true do |t|
    t.string   "title"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financialreports", force: true do |t|
    t.integer  "fiscal_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historyrevenuereports", force: true do |t|
    t.integer  "fiscal_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hqlevel_translations", force: true do |t|
    t.integer  "hqlevel_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "hqlevel_translations", ["hqlevel_id"], name: "index_hqlevel_translations_on_hqlevel_id"
  add_index "hqlevel_translations", ["locale"], name: "index_hqlevel_translations_on_locale"

  create_table "hqlevels", force: true do |t|
    t.integer  "level"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ranking",    default: 999,   null: false
    t.string   "locale"
    t.boolean  "messup",     default: false, null: false
    t.integer  "chaos",      default: 404
  end

  create_table "hqproduct_translations", force: true do |t|
    t.integer  "hqproduct_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "hqproduct_translations", ["hqproduct_id"], name: "index_hqproduct_translations_on_hqproduct_id"
  add_index "hqproduct_translations", ["locale"], name: "index_hqproduct_translations_on_locale"

# Could not dump table "hqproducts" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "majorpolicies", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majorresolutions", force: true do |t|
    t.integer  "fiscal_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlyrevenuereports", force: true do |t|
    t.integer  "fiscal_year", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_translations", force: true do |t|
    t.integer  "organization_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "org_name"
    t.text     "address"
  end

  add_index "organization_translations", ["locale"], name: "index_organization_translations_on_locale"
  add_index "organization_translations", ["organization_id"], name: "index_organization_translations_on_organization_id"

  create_table "organizations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accessLevel", default: 2
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "representative_translations", force: true do |t|
    t.integer  "representative_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "division"
    t.string   "name"
    t.text     "phone"
    t.text     "fax"
    t.text     "mobile"
    t.string   "email"
  end

  add_index "representative_translations", ["locale"], name: "index_representative_translations_on_locale"
  add_index "representative_translations", ["representative_id"], name: "index_representative_translations_on_representative_id"

  create_table "representatives", force: true do |t|
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revenue_items", force: true do |t|
    t.integer  "fiscal_month",                                                   null: false
    t.string   "item",                                                           null: false
    t.decimal  "value",                   precision: 17, scale: 3, default: 0.0, null: false
    t.integer  "ranking",                                          default: 999
    t.integer  "monthlyrevenuereport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "revenue_items", ["monthlyrevenuereport_id"], name: "index_revenue_items_on_monthlyrevenuereport_id"

end
