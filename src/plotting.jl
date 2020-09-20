using Plots

function plotBWData(gymName::String, firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    dataEval = getDataEval(gymName, firstDay, lastDay,dayOpts)
    

end

function plotEinsteinData(gymName::String, firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    dataEval = getDataEval(gymName, firstDay, lastDay,dayOpts)

end

function plotKBData(gymName::String, firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    dataEval = getDataEval(gymName, firstDay, lastDay,dayOpts)

end