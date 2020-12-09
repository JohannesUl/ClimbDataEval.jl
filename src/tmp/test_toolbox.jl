using ClimbDataEval
using Dates

ClimbDataEval.plotData("Einstein", Date(2020,9,1), Date(2020,10,14), [1,2,3,4,5])

ClimbDataEval.plotData("Einstein", Date(2020,8,1), Date(2020,10,4))

ClimbDataEval.plotData("KBGilching", Date(2020,7,24), Date(2020,10,9), [1,2,3,4,5])

ClimbDataEval.plotData("BW_West", Date(2020,8,1), Date(2020,10,4), [Dates.Sunday, Dates.Saturday])

ClimbDataEval.plotData("BW_West", Date(2020,8,1), Date(2020,10,4), [Dates.Monday, Dates.Tuesday, Dates.Wednesday, Dates.Thursday])

ClimbDataEval.plotData("BW_West", Date(2020,10,7), Date(2020,10,7))

ClimbDataEval.plotData("BW_West", Date(2020,8,1), Date(2020,10,4), [Dates.Monday, Dates.Tuesday, Dates.Wednesday, Dates.Thursday])