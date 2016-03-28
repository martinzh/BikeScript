@everywhere using DistributedArrays

# raw_data = readcsv("/home/martin/Documents/datos_ecobici/EcobiciDF/2010.csv") # cubo
raw_data = readcsv("/home/martin/datos_ecobici/EcobiciDF/2010.csv") # comadreja

file = open("filt_2010.csv", "w")

# Encuentra viajes con status "A"
trav_A = find( x -> x == "A  ", raw_data[:,7])

# Datos filtrados, solo viajes con status A
data = raw_data[trav_A,:]

# Distribuye datos en procesadores
Ddata = distribute(data)
#println(size(Ddata))
println("pass dist")

for i in 1:10000
#for i in 1:size(data,1)
    st_time = DateTime(Ddata[i,3], "y-m-d H:M:S")
    end_time = DateTime(Ddata[i,5], "y-m-d H:M:S")
    #println("dur:\t", Dates.Minute(end_time - st_time), "\tsame:\t", Ddata[i,4] == Ddata[i,6] )
    println(file, Ddata[i,4],",",Ddata[i,6],",",Int(Dates.Minute(end_time - st_time)),",",Dates.dayofweek(st_time),",",Dates.month(st_time))
end

close(file)
println("done")
