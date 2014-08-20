# encoding : utf-8 
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Hqlevel.create([{level: 0, parent: 0, ranking: 999, locale: 'zh_TW', chaos: 404, name: '總覽' },{level: 0, parent: 0, ranking: 999, locale: 'zh_CN', chaos: 404, name: '总览' },{level: 0, parent: 0, ranking: 999, locale: 'en', chaos: 404,  name: 'Overview' },{level: 0, parent: 0, ranking: 999, locale: 'ja', chaos: 404, name: '概観' }])


Brlevel.create([{level: 0, parent: 0, ranking: 999, locale: 'zh_TW', chaos: 404, name: '各廠'},{level: 0, parent: 0, ranking: 999, locale: 'zh_CN', chaos: 404, name: '各厂'},{level: 0, parent: 0, ranking: 999, locale: 'en', chaos: 404, name: 'Factory'},{level: 0, parent: 0, ranking: 999, locale: 'ja', chaos: 404, name: '工場'}])

Majorpolicy.create({description: "default"})

Article.create({name: "forFinancialprojection"})

Financialprojection.create({title: "財務預測", article_id: 1})

Admin.create({name: "超級管理員", superadmin: 1, email: "superadmin@example.com.tw", :password => "23219217"})
Admin.create({name: "一般管理員", superadmin: 0, email: "admin@example.com.tw", :password => "23219217"})

