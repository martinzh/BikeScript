@everywhere using DistributedArrays

raw_data = readcsv("/home/martin/Documents/datos_ecobici/EcobiciDF/2010.csv") # cubo

# Encuentra viajes con status "A"
trav_A = find( x -> x == "A  ", raw_data[:,7])

# Datos filtrados, solo viajes con status A
data = raw_data[trav_A,:]

# Distribuye datos en procesadores
Ddata = distribute(data)
println(size(Ddata))
println("pass dist")

for i in 1:300
    st_time = DateTime(Ddata[i,3], "y-m-d H:M:S")
    end_time = DateTime(Ddata[i,5], "y-m-d H:M:S")
    println("dur:\t", Dates.Minute(end_time - st_time), "\tsame:\t", Ddata[i,4] == Ddata[i,6] )
end
