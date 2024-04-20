require('vcard')
require('pry')
require('faker')

providers = [852, 812, 821, 815, 819, 811, 856, 831, 822, 851, 857, 817, 818, 859, 877, 878, 813, 832, 833, 838]

input_filename = 'Contact.vcf'
input_filepath = File.read(File.dirname(__FILE__) + '/input/' + input_filename)

vcards = Vcard::Vcard.decode(input_filepath)
cards = ""

vcards.each do |vcard|
  phone_number = "+62"
  phone_number += providers.sample.to_s
  phone_number += Faker::Number.number(digits: 8).to_s

  new_vcard = Vcard::Vcard.create
  new_vcard << Vcard::DirectoryInfo::Field.create('n', vcard.instance_variable_get(:@fields)[2].instance_variable_get(:@value))
  new_vcard << Vcard::DirectoryInfo::Field.create('fn', vcard.name.instance_variable_get(:@fullname))
  new_vcard << Vcard::DirectoryInfo::Field.create('tel', phone_number, { "type" => "cell" })

  cards += new_vcard.to_s
end

old_stdout = $stdout
File.open("./output/output.vcf", "w") do |f|
  $stdout = f
  puts cards
end
$stdout = old_stdout
