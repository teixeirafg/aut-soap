Before do |scenario|
  @test_start = time_now
  day = Time.now.strftime('%Y%m%d')
  time = Time.now.strftime('%Hh%Mm%Ss%L')
  scenario_name = scenario.name.remover_acentos.titleize.gsub(/\W/, '')
  $folder_path = "reports/evidencias/#{day}/#{time}_#{scenario_name}"
  FileUtils.mkdir_p($folder_path) unless Dir.exist?($folder_path)
end

After do |scenario|
  puts "Início: #{@test_start}"
  puts "Término: #{time_now}"
  i = 0
  Dir[File.join(File.dirname(__FILE__), "../../#{$folder_path}/*.txt")].sort.each do |f|
    i += 1
    file_name = f.split('/').last.split('.').first
    embed(f, 'text/plain', "    #{file_name}_evidencia_#{i}    ")
  end

  if scenario.failed?
    File.open("reports/#{BANDEIRA}_failed_scenarios.txt", 'a') do |f|
      f << "#{scenario.name}\n"
    end
  end
end
