using ClimbDataEval
using Dates

ClimbDataEval.plotData("Einstein", Date(2020,8,1), Date(2020,10,4), [Dates.Sunday, Dates.Saturday])

ClimbDataEval.plotData("BW_West", Date(2020,8,1), Date(2020,10,4), [Dates.Sunday, Dates.Saturday])