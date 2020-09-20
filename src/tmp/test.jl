using Dates
using Plots

b = Date(2020,9,12)
println(typeof(b))

dr = Date(2014,1,29):Day(1):Date(2014,2,3)

for day in dr
    println(day)
end
# A nice wy to filter certain weekdays
# weekdays = filter(dy -> Dates.dayname(dy) != "Saturday" && Dates.dayname(dy) != "Sunday" , d)


a = getTimeEval(Date(2020,9,1),Date(2020,9,11), [Dates.Sunday, Dates.Thursday, Dates.Friday])

# loadFromDatabase("BW_West", a)
# getOpeningHours("KBToelz", a)

dataEval = getDataEval("BW_West",Date(2020,9,1),Date(2020,9,11), [Dates.Sunday, Dates.Thursday, Dates.Friday])

data = loadDataFromDatabase("BW_West",a)

plot(dataEval.dataArray[1].percent)

plot([Time(1,5),Time(2,30),Time(4,1)],[1,0,3])


plotData("BW_West", Date(2020,9,1), Date(2020,9,11), [Dates.Sunday, Dates.Thursday, Dates.Friday])