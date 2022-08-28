# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# scrap the real data for this app
agent = Mechanize.new
page =agent.get('https://www.museumsusa.org/museums/?k=1271407%2cCategoryID%3a200050%3bState%3aCA%3bDirectoryID%3a200454')

data = []
items = page.search("//div[@class='basic item']")
items.each { |item|
  data << {
    'name': item.children[1].text.strip,
    'city': item.children[3].text.strip.split(',')[0],
    'destination_type': item.children[5].text.strip,
    'description': item.children[7].text.strip,
  }
}

Destination.create(data)




