using PyPlot

cd("/home/martin/Documents/datos_ecobici/EcobiciDF")
pwd()

files = readdir()

travs_files = [files[i] for i in find(x -> ismatch( r"filt_\d+.csv", x), files)]

for file in travs_files

    data = readcsv(file)

    size(data)

    dur_travs = convert(Array{Int64,1}, data[2:end, 6])
    dur_travs_filt = Int64[dur_travs[i] for i in find(x -> x <= 50 && x > 0, dur_travs)]

    bins, counts = hist(dur_travs_filt, 100)
    plt[:plot](collect(midpoints(bins)), counts / length(dur_travs_filt), ".-", label = file)

    # plt[:hist](dur_travs_filt, bins=100, normed=true, label = file)
end

plt[:legend]()
plt[:grid](true)

plt[:clf]()
