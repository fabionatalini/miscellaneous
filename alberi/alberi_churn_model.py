############### example with Churn_Modelling #######################
import csv
import random
import math

#read in data file
path_file="/home/fabio/Documents/alberi/Churn_Modelling.csv"

f=open(path_file, mode="rt")
r=csv.reader(f,delimiter=",", quoting=csv.QUOTE_NONNUMERIC)

dataset=list()
for row in r:
    dataset.append(row)
    del(row)
f.close()
del f, r

#column names are the first row of the csv
#dataset={"data":dataset, "colnames":dataset.pop(0)}
colnames=dataset.pop(0)

#function to prepare subsets
def create_random_subsets(seed_set, select_rows):
    #divide into two subsets having response value 1 or 0
    unos, ceros = list(), list()
    for row in dataset:
        if row[-1] == 1:
            unos.append(row)
        else:
            ceros.append(row)
    del(row)
    #initialize a dict to store outputs
    outcome=dict()
    #one process per seed
    for semilla in seed_set:
        #extract random samples without replacement
        random.seed(semilla)
        unos_subset=random.sample(unos, math.ceil(len(unos)*select_rows))
        random.seed(semilla)
        ceros_subset=random.sample(ceros, math.ceil(len(ceros)*select_rows))
        #each should be always a list of lists
        if any([not isinstance(i , list) for i in unos_subset]):
            exit("Some item of unos_subset is not a list")
        if any([not isinstance(i , list) for i in ceros_subset]):
            exit("Some item of ceros_subset is not a list")
        #shuffle the output
        unos_subset.extend(ceros_subset)
        random.seed(semilla)
        random.shuffle(unos_subset)
        #store the output
        nombre="semilla_{0}".format(semilla)
        outcome[nombre]=unos_subset
    return outcome
    

foo=create_random_subsets(seed_set=[1,2,3],select_rows=0.5)














