using YAML
using Dates

dr = Date(2020,9,12):Day(1):Date(2020,9,18)

for datum1 = dr
    #println(datum1)
    println(Dates.dayname(datum1))
end

data = YAML.load_file("/Users/jojo/.julia/dev/ClimbDataEval.jl/src/tmp/opening_hours.yml")

data = YAML.load_file("/Users/jojo/.julia/dev/ClimbDataEval.jl/src/tmp/opening_hours_copy.yml")

println(Time(data["KBToelz"]["open"]["Monday"]))

pwd()
