munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

merger = {}

munsters.each do |k, v|
	case v["age"]
	when 0..17
		merger["age_group"] = "kid"
		v.merge!(merger)
	when 18..64
		merger["age_group"] = "adult"
		v.merge!(merger)
	else
		merger["age_group"] = "senior"
		v.merge!(merger)	
	end
end

puts munsters["Marilyn"]