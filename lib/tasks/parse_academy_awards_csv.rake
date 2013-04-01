require 'csv'

namespace :parse do
  
  desc "Parse given acadamy awards file (options: START_IDX, END_IDX)."
  # run 'rake parse:academy_awards_csv
  task :academy_awards_csv => :environment do
    start_idx = ENV["START_IDX"] ? ENV["START_IDX"].to_i : nil
    end_idx = ENV["END_IDX"] ? ENV["END_IDX"].to_i : nil
    puts "Starting to read CSV (WILL take some time so make sure internet stays on)"
    csv = CSV.read('lib/data/academy_awards.csv', :encoding => 'windows-1251:utf-8')
    puts "File read, now doing work on each row, inserting into the database"
    csv.each_with_index do |row, idx|
      next if idx == 0
      if start_idx != nil then if idx < start_idx then next end end
      if end_idx != nil then if idx > end_idx then next end end
      did_win = /(WIN)/.match(row[4]) ? true : false
      /(\d\d\d\d)/ =~ row[0]
      year = $1.to_i
      
      next if /\".\"/.match(row[1])
      next if /Honorary Award/.match(row[1])
      is_acting_nom = /(Actor)|(Actress)/.match(row[1]) ? true : false
      category = row[1]
      begin
        o = Oscar.create(category: category)
      rescue ActiveRecord::RecordNotUnique
        puts "duplicate record (not inserting): #{category}"
        o = Oscar.find_by_category(category)
      end
      
      if is_acting_nom # nom is with actor
        fullname = row[2].to_ascii.downcase.tr('.', '')
        /([a-zA-Z\d]*'?[-a-zA-Z\d]*)
         (\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*
         (.*\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))*/x =~ fullname
        fname = $1 ? $1 : ''
        mname = $3 ? $3 : ''
        lname = $5 ? $5 : ''
        next if fname == '' && mname == '' && lname == ''
        p = Person.where('fname=? AND mname=? AND lname=?', fname, mname, lname)
        if p.length == 1    # found person
          p = p[0]
        else
          # create new person b/c it was not found
          begin
            p = Person.create(fname: fname, mname: mname, lname: lname)
          rescue ActiveRecord::RecordNotUnique
            puts "duplicate record (not inserting): #{fname} #{mname} #{lname}"
            next
          end
        end
        /( ([a-zA-Z\d]*'?[-a-zA-Z\d]*)(\s([a-zA-Z\d]*'?[-a-zA-Z\d]*))* )\s*{?/x =~ row[3]
        m_name = $1
        m = Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', m_name, "#{year-1}-01-01", "#{year+1}-12-31")
        if m.length == 1     # found movie
          m = m[0]
        else
          # create new movie b/c it was not found
          begin
            m = Movie.create(name: m_name, release_date: DateTime.strptime(year.to_s, "%Y"))
          rescue ActiveRecord::RecordNotUnique
            puts "duplicate record (not inserting): #{m_name}"
            next
          end
        end
        begin
          n = PNominated.create(oid: o.id, pid: p.id, mid: m.id, year: year, win: did_win)
        rescue ActiveRecord::RecordNotUnique
          next
        end
      else # nom is movie only
        begin
          m_name = row[2].to_ascii.downcase
        rescue Exception
          next
        end
        next if m_name.length > 255
        m = Movie.where('LOWER(name)=? AND release_date BETWEEN ? AND ?', m_name, "#{year-1}-01-01", "#{year+1}-12-31")
        if m.length == 1     # found movie
          m = m[0]
        else
          # create new movie b/c it was not found
          begin
            m = Movie.create(name: m_name, release_date: DateTime.strptime(year.to_s, "%Y"))
          rescue ActiveRecord::RecordNotUnique
            puts "duplicate record (not inserting): #{m_name}"
            next
          end
        end
        begin
          n = MNominated.create(oid: o.id, mid: m.id, year: year, win: did_win)
        rescue ActiveRecord::RecordNotUnique
          next
        end
        
      end
    end
  end
end