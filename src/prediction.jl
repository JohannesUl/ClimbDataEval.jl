using DataFrames
using CSV

mutable struct TrainDataset
    InputNames::Array{String,1}
    gymName::String
    xNormalizing::Array{Real,1}
    xTrain::Array{Real,2}
    yTrain::Array{Real,1}
    xTest::Array{Real,2}
    yTest::Array{Real,1}
    xCrossvalidate::Array{Real,2}
    yCrossvalidate::Array{Real,1}
    name::String = "Training_" * Dates.format(DateTime(now()), "yyyy_mm_dd-HH_MM_SS")
end

function getElements(data::DataFrame, date::Date, tagList)
    data_return = zeros(length(tagList))
    data_at_date = filter(row -> row.MESS_DATUM ==  getNumberFromDate(date), data)
    for i in 1:length(tagList)
        data_return[i] = data_at_date[tagList[i]][1]
    end
    return data_return
end

function loadWeatherData(loadstr::String)
    return data = CSV.read(loadstr)
end

function aggregateData(DataEval::DataEvalType)
    data = dataEval.dataArray[1]
    for k = 2:length(dataEval.dataArray)
        data = vcat(data, dataEval.dataArray[k])
    end
    filter!(row -> !ismissing(row.percent), data)
    return data
end

function addTimeNumber(data::DataFrame)
    # Try the following
    #insertcols!(d, 1, :b => 'a':'c')
    #df3 = hcat(df1, df2, makeunique=true)

end

function createTrainDataset(DataEval::DataEvalType, train_split, test_split)
    weatherData = loadWeatherData("/Users/jojo/Git/BoulderScrapping/weatherData/tageswerte_KL_03379_akt/produkt_klima_tag_20190405_20201005_03379.txt")
    data = aggregateData(DataEval)

end

function downloadWeatherData(storeStr::String)
    # TBD
    # Download from https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/daily/kl/recent/tageswerte_KL_03379_akt.zip
end


