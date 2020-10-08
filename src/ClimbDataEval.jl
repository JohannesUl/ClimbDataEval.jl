module ClimbDataEval
using Dates
using DataFrames

abstract type AbstractTimeEvalType end

abstract type AbstractDataEvalType end
# Write your package code here.

mutable struct  TimeEvalType <:AbstractTimeEvalType
    firstDay::Date
    lastDay::Date
    dayOpts::Array{Int,1}
    numberOfDaysToEval::Integer
    evalDayArray::Array{Date,1}
end

mutable struct  DataEvalType <:AbstractDataEvalType
    rawDataArray::Array{DataFrame,1}
    dataArray::Array{DataFrame,1}
    nEntrys::Integer
    TimeEval::TimeEvalType
    openingHours::Array{Time,2}
    plotTicks::StepRange{Time,Hour}
    gymName::String
end

include("loadMySQL.jl")

function getTimeEval(firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    if (length(dayOpts) == 1) & (dayOpts[1] === 0)
        evalDayArray = firstDay:Day(1):lastDay
    else
        dayRange = firstDay:Day(1):lastDay
        evalDayArray = Array{Date,1}[]

        for day in dayRange
            if Dates.dayofweek(day) in dayOpts
                #println(Dates.dayofweek(day))
                evalDayArray = [evalDayArray; day]   
            end 
        end
    end
    TimeEval = TimeEvalType(firstDay, lastDay, dayOpts, length(evalDayArray), evalDayArray)
    return TimeEval
end

function getDataEval(gymName::String, firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    TimeEval = getTimeEval(firstDay, lastDay, dayOpts)
    openingHours = getOpeningHours(gymName, TimeEval)
    plotTicks = getPlotTicks(openingHours)
    rawDataArray = loadDataFromDatabase(gymName, TimeEval)
    dataArray = [ cutDataFrameToOpeningHours(rawDataArray[k], openingHours[k,1], openingHours[k,2]) for k=1:length(rawDataArray) ]

    # Build DataEval
    DataEval = DataEvalType(rawDataArray, dataArray, length(rawDataArray), TimeEval, openingHours, plotTicks, gymName)
    return DataEval
end


include("plotting.jl")

end
