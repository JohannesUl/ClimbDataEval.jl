module ClimbDataEval
using Dates
using DataFrames

include("loadMySQL.jl")

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
    gymName::String
end

function getTimeEval(firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    dayRange = firstDay:Day(1):lastDay
    evalDayArray = Array{Date,1}[]

    for day in dayRange
        if Dates.dayofweek(day) in dayOpts
            #println(Dates.dayofweek(day))
            evalDayArray = [evalDayArray; day]   
        end 
    end
    TimeEval = TimeEvalType(firstDay, lastDay, dayOpts, length(evalDayArray), evalDayArray)
    return TimeEval
end

function getDataEval(gymName::String, firstDay::Date, lastDay::Date, dayOpts::Array{Int,1})
    println("1")
    TimeEval = getTimeEval(firstDay, lastDay, dayOpts)
    println("2")
    openingHours = getOpeningHours(gymName, TimeEval)
    println("3")
    rawDataArray = loadDataFromDatabase(gymName, TimeEval)
    println("4")
    dataArray = [ cutDataFrameToOpeningHours(rawDataArray[k], openingHours[k,1], openingHours[k,2]) for k=1:length(rawDataArray) ]
    println("5")
    println(size(dataArray))

    # Build DataEval
    DataEval = DataEvalType(rawDataArray, dataArray, length(rawDataArray), TimeEval, openingHours, gymName)
    return DataEval
end

end
