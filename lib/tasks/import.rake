require 'csv'

namespace :import do
  @data_dir = Rails.root.join('import/')
  desc 'Import Draft Data'
  task :all => [:teams, :players, :picks]

  task :picks => :environment do
    filename = 'order.csv'
    abort_missing_file(filename) unless File.exist?(@data_dir + filename)
    CSV.foreach(@data_dir + filename, :headers => true) do |row|
      r = row.to_hash
      begin
        Pick.create!(
          :round   => cleanup(r['Round']).to_i,
          :pick    => cleanup(r['Pick']).to_i,
          :team_id => Team.find_by_tname(cleanup(r['Team Name'])).id
        )
      rescue ActiveRecord::RecordInvalid
        puts "WARNING: Data appears to have already been imported"
      end
    end
  end

  task :teams => :environment do
    filename = 'teams.csv'
    abort_missing_file(filename) unless File.exist?(@data_dir + filename)
    CSV.foreach(@data_dir + filename, :headers => true) do |row|
      r = row.to_hash
      begin
        Team.create!(
          :tname    => cleanup(r['Team Name']),
          :division => cleanup(r['Division'])
        )
      rescue ActiveRecord::RecordInvalid
        puts "WARNING: Data appears to have already been imported"
      end
    end
  end

  task :players => :environment do
    filename = 'players.csv'
    abort_missing_file(filename) unless File.exist?(@data_dir + filename)
    CSV.foreach(@data_dir + filename, :headers => true) do |row|
      r = row.to_hash
      begin
        Player.create!(
          :pname    => cleanup(r['Player Name']),
          :position => cleanup(r['Position'])
        )
      rescue ActiveRecord::RecordInvalid
        puts "WARNING: Data appears to have already been imported"
      end
    end
  end

  task :reset => :environment do
    %w(Player Team Pick).each do |r|
      klass = r.constantize
      cnt   = klass.all.count
      klass.delete_all
      puts "#{cnt} #{r} records removed"
    end
  end

  def abort_missing_file(fname)
    puts "ERROR: missing file #{filename}"
    return
  end

  def cleanup(field)
    field.start_with?("NY") ? field.strip.sub("NY", "New York") : field.strip
  end

end
