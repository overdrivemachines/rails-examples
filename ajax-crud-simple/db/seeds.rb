# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'json'

Contact.delete_all

response = open('http://api.uinames.com/?amount=10&region=united%20states').read
# uinames = JSON.parse("[{\"name\":\"Jacob\",\"surname\":\"Mendoza\",\"gender\":\"male\",\"region\":\"United States\"},{\"name\":\"Peter\",\"surname\":\"Gibson\",\"gender\":\"male\",\"region\":\"United States\"}]")
uinames = JSON.parse(response)
# puts uinames.inspect

uinames.each do |uiname|
	em = uiname["name"][0] + "@" + uiname["surname"][0] + ".com"
	em.downcase!
	Contact.create(first_name: uiname["name"], last_name: uiname["surname"], email: em)
end

# [{"name":"Jacob","surname":"Mendoza","gender":"male","region":"United States"},{"name":"Peter","surname":"Gibson","gender":"male","region":"United States"}]



# contacts = Contact.create([
# 	{first_name: "Dipen", last_name: "Chauhan", email: "d@d.com"},
# 	{first_name: "Tammy", last_name: "Meyer", email: "t@t.com"},
# 	{first_name: "Carol", last_name: "Martin", email: "c@m.com"},
# 	{first_name: "Harold", last_name: "Kennedy", email: "h@k.com"},
# 	{first_name: "Albert", last_name: "Berry", email: "a@b.com"}
# ])