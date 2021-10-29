require 'sinatra'
plan_filename = 'plan.json'
shopping_list_filename = 'shopping_list.json'

post '/plan' do
  begin
    json = request.body.read
    plan = JSON.parse json
    File.open(plan_filename, 'w') { |file| file.write(json) }
    return { result: "success" }.to_json
  rescue JSON::ParserError
    content_type :json
    return { result: "fail" }.to_json
  end    
end

post '/shopping_list' do
  begin
    json = request.body.read
    plan = JSON.parse json
    File.open(shopping_list_filename, 'w') { |file| file.write(json) }
    return { result: "success" }.to_json
  rescue JSON::ParserError
    content_type :json
    return { result: "fail" }.to_json
  end    
end

get '/plan' do
  file = File.read(plan_filename)
  begin
    data_hash = JSON.parse(file)
    start_date = data_hash['start_date']
    end_date = data_hash['end_date']
    output = "<html><body>"
    output += "<h1>Meal plan from #{start_date} to #{end_date}</h1>"
    days = data_hash['days']
    days.each do |day| 
      date = day['date']
      output += "<h2>#{date}</h2>"
      menus = day['menus']
      if menus.count > 0 then
        day['menus'].each do |menu| 
          meal = menu['meal']
          output += "<p><b>#{meal}: </b>"
          recipe_names = menu['recipes'].map { |recipe| 
            if recipe.key?('url') then
              "<a href='#{recipe['url']}'>#{recipe['name'] }</a>"
            else
              recipe['name'] 
            end
          }
          recipe_list = recipe_names.join(", ")
          output += "#{recipe_list}</p>"
        end
      else
        output += "<p><em>Nothing planned</em></p>"
      end
    end
    output += "</body></html>"
    return " #{output}"
  rescue JSON::ParserError
    "JSON error"
  end
end

get '/shopping_list' do
  file = File.read(shopping_list_filename)
  begin
    data_hash = JSON.parse(file)
    start_date = data_hash['start_date']
    end_date = data_hash['end_date']
    output = "<html><head><style>ul {
  list-style-type: none; /* Remove bullets */
  padding: 0; /* Remove padding */
  margin: 0; /* Remove margins */
}</style></head><body>"
    output += "<h1>Shopping list from #{start_date} to #{end_date}</h1>"
    sections = data_hash['sections']
    sections.each do |section| 
      aisle_name = section['aisle_name']
      output += "<h2>#{aisle_name}</h2>"
      lines = section["lines"]
      output += "<ul>"
      lines.each do |line|
        main_string = line["main_string"]
        is_checked = line["is_checked"]
        bullet = is_checked ? "●" : "○"
        output += "<li>#{bullet} #{main_string}</li>"
      end
      output += "</ul>"
    end
    output += "</body></html>"
    return " #{output}"
  rescue JSON::ParserError
    "JSON error"
  end
end
