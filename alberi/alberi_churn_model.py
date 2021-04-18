############### example with Churn_Modelling #######################
import csv
import random
import math

#read in data file
path_file="C:/Users/fabnatal/Documents/Python Scripts/Nueva carpeta/Churn_Modelling.csv"

f=open(path_file, mode="rt")
r=csv.reader(f,delimiter=",", quoting=csv.QUOTE_NONNUMERIC)

dataset=list()
for row in r:
    dataset+=[row]
    del(row)
f.close()

#column names are the first row of the csv
#dataset={"data":dataset, "colnames":dataset.pop(0)}
colnames=dataset.pop(0)

#divide into two subsets having response value 1 or 0
unos, doss = list(), list()
for row in dataset:
    if row[-1] == 1:
        unos.append(row)
    else:
        doss.append(row)
#extract random samples without replacement
random.seed(1)
unos_subset=random.sample(unos, math.ceil(len(unos)/2))
doss_subset=random.sample(doss, math.ceil(len(doss)/2))













