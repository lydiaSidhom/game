require 'csv'

desc "Import teams from csv file"
task :import => [:environment] do

  file = "/Users/lydia/Desktop/Masters/Masters/src/output.txt"

  CSV.foreach(file, :headers => true) do |row|
    MetroStop.create(
      :name => row[0],
      :lat => row[1],
      :lng => row[2]
    )
  end

end