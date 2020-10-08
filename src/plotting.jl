using Plots
using Plots.PlotMeasures

function plotData(gymName::String, firstDay::Date, lastDay::Date=firstDay, dayOpts::Array{Int,1}=[0])
    dataEval = getDataEval(gymName, firstDay, lastDay, dayOpts)
    if gymName in ["BW_West", "BW_Ost"]
        plotBWData(dataEval)
    end
    if gymName in ["Einstein"]
        plotEinsteinData(dataEval)
    end
    if gymName in ["KBGilching", "KBFreimann", "KBThalkirchen", "KBToelz"]
        plotKBData(dataEval)
    end
end

function plotData!(gymName::String, firstDay::Date, lastDay::Date=firstDay, dayOpts::Array{Int,1}=[0])
    dataEval = getDataEval(gymName, firstDay, lastDay, dayOpts)
    if gymName in ["BW_West", "BW_Ost"]
        plotBWData!(dataEval)
    end
    if gymName in ["Einstein"]
        plotEinsteinData!(dataEval)
    end
    if gymName in ["KBGilching", "KBFreimann", "KBThalkirchen", "KBToelz"]
        plotKBData(dataEval)
    end
end

function replaceMissingByZero(input)
    output = input
    for k=1:length(input)
        if ismissing(output[k])
            output[k] = 0
        end
    end
    return output
end

function plotBWData(dataEval::DataEvalType)
    cols = [:red,:orange,:black,:cyan,:magenta,:green,:blue]
    
    p = plot(dataEval.dataArray[1].time,
                dataEval.dataArray[1].percent,
                linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
                label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
                xticks = dataEval.plotTicks,
                xrotation=60,
                bottom_margin = 25px,
                ylims = (0.0, 100.0))
    plot!(p, dataEval.dataArray[1].time,
                replaceMissingByZero(dataEval.dataArray[1].waiting),
                linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
                linestyle=:dash,
                label="waiting")
    
    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
                plot!(p, dataEval.dataArray[k].time, replaceMissingByZero(dataEval.dataArray[k].waiting), linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], linestyle=:dash, label = "waiting")
            else
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
                plot!(p, dataEval.dataArray[k].time, replaceMissingByZero(dataEval.dataArray[k].waiting), linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], linestyle=:dash, label="")
            end
        end
    end
    title!(p, dataEval.gymName)
    #xticks!(p, dataEval.plotTicks)
    display(p)
end

function plotBWData!(dataEval::DataEvalType)
    cols = [:red,:orange,:black,:cyan,:magenta,:green,:blue]
    
    p = plot!(dataEval.dataArray[1].time,
                dataEval.dataArray[1].percent,
                linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
                label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
                xticks = dataEval.plotTicks,
                xrotation=60,
                bottom_margin = 25px,
                ylims = (0.0, 100.0))
    plot!(p, dataEval.dataArray[1].time,
                replaceMissingByZero(dataEval.dataArray[1].waiting),
                linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
                linestyle=:dash,
                label="waiting")
    
    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
                plot!(p, dataEval.dataArray[k].time, replaceMissingByZero(dataEval.dataArray[k].waiting), linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], linestyle=:dash, label = "waiting")
            else
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
                plot!(p, dataEval.dataArray[k].time, replaceMissingByZero(dataEval.dataArray[k].waiting), linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], linestyle=:dash, label="")
            end
        end
    end
    title!(p, dataEval.gymName)
    #xticks!(p, dataEval.plotTicks)
    display(p)
end

function plotEinsteinData(dataEval::DataEvalType)
    cols = [:red,:orange,:black,:cyan,:magenta,:green,:blue]
    
    p = plot(dataEval.dataArray[1].time,
            dataEval.dataArray[1].percent,
            linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
            label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
            xticks = dataEval.plotTicks,
            xrotation=60,
            bottom_margin = 25px,
            ylims = (0.0, 100.0))
    
    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
            else
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
            end
        end
    end
    title!(p, dataEval.gymName)
    display(p)
end

function plotEinsteinData!(dataEval::DataEvalType)
    cols = [:red,:orange,:black,:cyan,:magenta,:green,:blue]
    
    p = plot!(dataEval.dataArray[1].time,
            dataEval.dataArray[1].percent,
            linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
            label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
            xticks = dataEval.plotTicks,
            xrotation=60,
            bottom_margin = 25px,
            ylims = (0.0, 100.0))
    
    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
            else
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].percent, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
            end
        end
    end
    title!(p, dataEval.gymName)
    display(p)
end

function plotKBData(dataEval::DataEvalType)
    cols = [:red,:orange,:black,:cyan,:magenta,:green,:blue]
    
    # Plot frei_klettern
    p = plot(dataEval.dataArray[1].time,
            dataEval.dataArray[1].frei_klettern,
            linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
            label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
            xticks = dataEval.plotTicks,
            xrotation=60,
            bottom_margin = 25px)
    
    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].frei_klettern, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
            else
                plot!(p, dataEval.dataArray[k].time, dataEval.dataArray[k].frei_klettern, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
            end
        end
    end
    title!(p, dataEval.gymName * " Frei Klettern")
    display(p)

    println("Press Enter... ")
    n = readline()
    # Plot frei_bouldern
    q = plot(dataEval.dataArray[1].time,
            dataEval.dataArray[1].frei_bouldern,
            linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])],
            label = Dates.dayname(dataEval.TimeEval.evalDayArray[1]),
            reuse=false,
            xticks = dataEval.plotTicks,
            xrotation=60,
            bottom_margin = 25px)

    leg = [Dates.dayofweek(dataEval.TimeEval.evalDayArray[1])]
    
    if dataEval.nEntrys>1
        for k = 2:dataEval.nEntrys
            if !(Dates.dayofweek(dataEval.TimeEval.evalDayArray[k]) in leg)
                leg = [leg; Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])]
                plot!(q, dataEval.dataArray[k].time, dataEval.dataArray[k].frei_bouldern, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label = Dates.dayname(dataEval.TimeEval.evalDayArray[k]))
            else
                plot!(q, dataEval.dataArray[k].time, dataEval.dataArray[k].frei_bouldern, linecolor = cols[Dates.dayofweek(dataEval.TimeEval.evalDayArray[k])], label="")
            end
        end
    end
    title!(q, dataEval.gymName * " Frei Bouldern")
    display(q)

end