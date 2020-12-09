using Dates

function convertTimeToNumber(time::Time)
    return decimal_time = hour(time) + (minute(time) / 60.0) + (second(time) / (60.0 * 60.0))
end

function convertNumberToTime(time::Number)
    xhour = floor(time)
    xminute = floor((time - xhour) * 60.0)
    xsecond = round((time - xhour - xminute/60.0) * 60.0 * 60.0)
    return Time(xhour, xminute, xsecond) 
end

function getDateFromNumber(number::Integer)
    xYear = floor(number/10000)
    xMonth = floor((number - xYear * 10000)/100)
    xDay = round((number - xYear * 10000 - xMonth * 100))
    return Date(xYear, xMonth, xDay) 
end

function getNumberFromDate(date::Date)
    return year(date)*10000 + month(date)*100 + day(date)
end