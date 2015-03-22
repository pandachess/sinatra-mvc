require 'sinatra'

def setup_index_view
	birthdate = params[:birthdate]
	birth_path_num = Person.birth_path_number(birthdate)
	@message = Person.numerology_message(birth_path_num)
	erb :index
end

get '/' do
	erb :form
end

post '/' do
	birthdate = params[:birthdate].gsub("-","")
	if Person.valid_birthdate(birthdate)
		birth_path_num = Person.birth_path_number(params[:birthdate])
		redirect "/message/#{birth_path_num}"
	else
		@error = "You should enter a valid birthdate in the form of mmddyyyy."
		erb :form
	end
end

get '/:birthdate' do 
	setup_index_view
end

get '/message/:birth_path_num' do
	birth_path_num = params[:birth_path_num].to_i
	@message = Person.numerology_message(birth_path_num)
	erb :index
end
