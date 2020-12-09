using Dates
using YAML
using DataFrames
using CSV

#-----------------------------------------
#  User input
#-----------------------------------------
loadstr = "/Users/jojo/Git/BoulderScrapping/weatherData/tageswerte_KL_03379_akt/produkt_klima_tag_20190405_20201005_03379.txt"
tags_to_upload = [:QN_4, :RSK, :SDK, :TMK, :TXK, :TNK]
first_upload_day = Date(2020,07,11)
last_upload_day = Date(2020,10,5)
#-----------------------------------------
data = CSV.read(loadstr)

#-------------------
# Comment: Data will not be uploaded since it is available online!
for k in size(data,1)
    dataDate = Date(data[k,:MESS_DATUM][1,4],data[k,:MESS_DATUM][5,6],data[k,:MESS_DATUM][7,8])
end