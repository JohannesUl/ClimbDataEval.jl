using YAML

data = YAML.load_file("/Users/jojo/.julia/dev/ClimbDataEval.jl/src/tmp/opening_hours.yml")

data = YAML.load_file("/Users/jojo/.julia/dev/ClimbDataEval.jl/src/tmp/opening_hours_copy.yml")

println(Time(data["KBToelz"]["open"]["Monday"]))

pwd()
