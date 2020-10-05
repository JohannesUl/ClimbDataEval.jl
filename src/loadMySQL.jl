using MySQL
using DBInterface
using Dates
using YAML


function getOpeningHours(gymName::String, TimeEval::TimeEvalType)
    loadPath = pathof(ClimbDataEval)
    loadPath = loadPath[1:end-16]*"opening_hours.yml"
    openingHoursYaml = YAML.load_file(loadPath)
    
    # Loop over all days 
    openingHours = Array{Time,2}(undef, TimeEval.numberOfDaysToEval, 2)
    for (i, date) in pairs(TimeEval.evalDayArray)
        openingHours[i, 1] =  Time(openingHoursYaml[gymName]["open"][Dates.dayname(date)])
        openingHours[i, 2] =  Time(openingHoursYaml[gymName]["close"][Dates.dayname(date)])
    end
    return openingHours
end

function getPlotTicks(openingHours::Array{Time,2})
    minTime = openingHours[1,1]
    maxTime = openingHours[1,2]
    scaling = Hour(1)

    if size(openingHours,1)>1
        for i = 2:size(openingHours,1)
            if openingHours[i,1] < minTime
                minTime = openingHours[i,1]
            end
            if openingHours[i,2] > maxTime
                maxTime = openingHours[i,2]
            end
        end
    end

    return minTime:scaling:maxTime 
end

function cutDataFrameToOpeningHours(data::DataFrame, openTime::Time, closeTime::Time)
    new_data = data[(data.time.>openTime) .& (data.time.<closeTime), :]
    return new_data
end

function addTimeColumn(data::DataFrame)
    new_data = data
    new_data["time"] = Time(0,0,0)
    for k = 1:size(new_data)[1]
        new_data["time"][k] = Time(data.hour[k], data.minute[k], data.second[k])
    end
    return new_data
end

function loadDataFromDatabase(gymName::String, TimeEval::TimeEvalType)
    # Start database connection
    conn = DBInterface.connect(MySQL.Connection, "192.168.178.31", "rootoutside", ".MyBoulderData"; port=3306)

    # Loop over all days to load and store data in array
    dataArray = Array{DataFrame,1}[]
    for date in TimeEval.evalDayArray
        stmt = DBInterface.prepare(conn, "SELECT * FROM BoulderData.$gymName WHERE year = (?) AND month = (?) AND day = (?) ")
        cursor = DBInterface.execute(stmt, [Dates.year(date), Dates.month(date), Dates.day(date)])
        dataArray = [dataArray; addTimeColumn(DataFrame(cursor))]  
    end
    # Close database connection
    DBInterface.close!(conn)

    return dataArray
end 