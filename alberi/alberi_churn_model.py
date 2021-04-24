############### example with Churn_Modelling #######################
import csv

#read in data file
path_file="/home/fabio/Documents/alberi/Churn_Modelling.csv"

f=open(path_file, mode="rt")
r=csv.reader(f,delimiter=",", quoting=csv.QUOTE_NONNUMERIC)

dati=list()
for row in r:
    dati.append(row)
    del(row)
f.close()
del f, r

#column names are the first row of the csv
#dati={"data":dati, "colnames":dati.pop(0)}
#colnames=dati.pop(0)
