############### calculate the gini index #######################
# groups is a tuple (or a list) of two lists
#(in this context, it is the result of the fuction test_split)
# clasees is a list of the classes of the target variable in the dataset
def indice_gini(groups, classes):
    n_instances = float(sum([len(group) for group in groups]))
    gini = 0.0
    for group in groups:
        size = float(len(group))
        if size == 0:
            continue
        score = 0.0
        for class_val in classes:
            p = [row[-1] for row in group].count(class_val) / size
            score += p * p
        gini += (1.0 - score) * (size / n_instances)
    return gini

"""
gruppi=(
      [[2.771244718,1.784783929,1],
    [1.728571309,1.169761413,1],
    [3.678319846,2.81281357,1],
    [3.961043357,2.61995032,0],
    [2.999208922,2.209014212,0],
      [2.999208922,2.209014212,0]],
 
      [[7.497545867,3.162953546,1],
    [9.00220326,3.339047188,1],
      [9.00220326,3.339047188,1],
    [7.444542326,0.476683375,0],
    [10.12493903,3.234550982,0],
    [6.642287351,3.319983761,0]]
   )

classi=[0,1]

print(indice_gini(gruppi,classi))
"""


############### splitting a dataset #######################
# Split a dataset based on an attribute and an attribute value
# index is the index of the attribute (i.e. a column)
# value is a number
# x is a dataset
def test_split(index, value, x):
    left, right = list(), list()
    for row in x:
        if row[index] < value:
            left.append(row)
        else:
            right.append(row)
    return left, right

"""
dataset = [[2.771244718,1.784783929,0],
           [1.728571309,1.169761413,0],
           [3.678319846,2.81281357,0],
           [3.961043357,2.61995032,0],
           [2.999208922,2.209014212,0],
           [7.497545867,3.162953546,0],
           [9.00220326,3.339047188,0],
           [7.444542326,0.476683375,1],
           [10.12493903,3.234550982,1],
           [6.642287351,3.319983761,1]]

print(test_split(0,9,dataset))
"""


############### find the best split #######################
# Find the best split in a dataset using the functions test_split and indice_gini
# x is a dataset where the target binary variable is the last column on the right
def find_best_split(x):
    class_values = list(set(row[-1] for row in x))
    b_index, b_value, b_score, b_groups = 999, 999, 999, None
    for index in range(len(x[0])-1):
      candidates = list(set(row[index] for row in x))
      #print(candidates)
      for c in candidates:
        groups = test_split(index, c, x)
        gini = indice_gini(groups, class_values)
        #print("index:"+str(index)+"; value:"+str(c)+"; gini:"+str(gini))
        if gini < b_score:
          b_index, b_value, b_score, b_groups = index, c, gini, groups
    return {'index':b_index, 'value':b_value, 'groups':b_groups}

"""
dati = [[2.771244718,1,0],
        [1.728571309,1,0],
        [7,3.162953546,1],
        [7,0.476683375,1],
        [3.678319846,2.81281357,0],
        [3.961043357,2.61995032,0],
        [2.999208922,2.209014212,0],
        [9.00220326,3.339047188,1],
        [10.12493903,3.234550982,1],
        [6.642287351,3.319983761,1]]

import matplotlib.pyplot as plt
x=[row[0] for row in dati]
y=[row[1] for row in dati]
labels=[row[2] for row in dati]
plt.scatter(x, y, c=labels)
plt.show()

divisione=find_best_split(dati)
print()
print("Selected index:"+str(divisione["index"]))
print()
print("Selected value:"+str(divisione["value"]))
print()
print("Selected group 1:"+str(divisione["groups"][0]))
print()
print("Selected group 2:"+str(divisione["groups"][1]))
"""


######## compute the terminal node value as probability of class 1 ########
# x is a dataset where the target binary variable is the last column on the right
def probabilita_1(x):
    risposte = [row[-1] for row in x]
    return risposte.count(1) / len(risposte)

"""
dataset = [[2.771244718,1.784783929,0],
    [1.728571309,1.169761413,0],
    [3.678319846,2.81281357,0],
    [3.961043357,2.61995032,0],
    [2.999208922,2.209014212,0],
    [7.497545867,3.162953546,0],
    [9.00220326,3.339047188,0],
    [7.444542326,0.476683375,1],
    [10.12493903,3.234550982,1],
    [6.642287351,3.319983761,1]]

print(probabilita_1(dataset))
"""


######## Create child splits for a node or make terminal nodes ########
# node comes from the function find_best_split
# max_depth and min_size are defined by the user
# depth will be 1 in the implementation
# max_depth can never be less than 1, and if it is 1 the recursive splitting stops
def recursive_split(node, max_depth, min_size, depth):
    left, right = node['groups']
    del(node['groups'])
    # check if there is a missing group
    if not left or not right:
        node['left'] = node['right'] = probabilita_1(left + right)
        return
    # check for max depth
    if depth >= max_depth:
        node['left'], node['right'] = probabilita_1(left), probabilita_1(right)
        return
    # process left child
    if len(left) <= min_size:
        node['left'] = probabilita_1(left)
    else:
        node['left'] = find_best_split(left)
        recursive_split(node['left'], max_depth, min_size, depth+1)
    # process right child
    if len(right) <= min_size:
        node['right'] = probabilita_1(right)
    else:
        node['right'] = find_best_split(right)
        recursive_split(node['right'], max_depth, min_size, depth+1)

"""
foo={"a":1,"b":2,"c":3,"d":1}

def prova(x):
    ultimo=x["d"]
    if not ultimo: #note: "if not" is the same as "if==0"
        x["d"]=0
        return
    if ultimo==0:
        x["d"]="zero"
        return
    if ultimo!=0:
        x["d"]=1

prova(foo)
"""


################ Build the decision tree ################
def albero(train_data, max_depth, min_size):
	decisioni = find_best_split(train_data)
	recursive_split(decisioni, max_depth, min_size, 1)
	return decisioni
"""
# examples
import matplotlib.pyplot as plt

def esempi(z):
    x=[row[0] for row in z]
    y=[row[1] for row in z]
    labels=[row[2] for row in z]
    plt.scatter(x, y, c=labels)
    plt.show()
    return albero(z, 1, 1)

#example 1
dataset = [[2.771244718,1.784783929,0],
	       [1.728571309,1.169761413,0],
	       [3.678319846,2.81281357,0],
	       [3.961043357,2.61995032,0],
	       [2.999208922,2.209014212,0],
           [6.642287351,3.319983761,1],
	       [7.497545867,3.162953546,1],
	       [9.00220326,3.339047188,1],
	       [7.444542326,0.476683375,1],
	       [10.12493903,3.234550982,1]]

print(esempi(dataset))

#example 2
dataset[9][2]=0
print(esempi(dataset))

#example 3
dataset[0][2]=1
print(esempi(dataset))

#example 4
dataset[1][2]=1
print(esempi(dataset))
"""


################ Make predictions ################
# decisioni is the result of the fuction albero
# row is a row of a new dataset
def pronostico(decisioni, row):
	if row[decisioni['index']] < decisioni['value']:
		if isinstance(decisioni['left'], dict):
			return pronostico(decisioni['left'], row)
		else:
			return decisioni['left']
	else:
		if isinstance(decisioni['right'], dict):
			return pronostico(decisioni['right'], row)
		else:
			return decisioni['right']

"""
############################ example ############################
import matplotlib.pyplot as plt

def esempi(z):
    x=[row[0] for row in z]
    y=[row[1] for row in z]
    labels=[row[2] for row in z]
    plt.scatter(x, y, c=labels)
    for i in range(len(z)):
        plt.text(z[i][0], z[i][1], str(i))
    plt.show()
    return albero(z, 1, 1)

dati = [[2.771244718,1.784783929,0],
        [1.728571309,1.169761413,0],
        [3.678319846,2.81281357,0],
	    [3.961043357,2.61995032,0],
	    [2.999208922,2.209014212,0],
        [6.642287351,3.319983761,1],
	    [7.497545867,3.162953546,1],
	    [9.00220326,3.339047188,1],
	    [7.444542326,0.476683375,1],
	    [10.12493903,3.234550982,1]]

modello=esempi(dati)
print(modello)
for row in dati:
	prediction = pronostico(modello, row)
	print('Expected=%d, Got=%s' % (row[-1], round(prediction,3)))

############################ example ############################
dati[9][2]=0
modello=esempi(dati)
print(modello)
for row in dati:
	prediction = pronostico(modello, row)
	print('Expected=%d, Got=%s' % (row[-1], round(prediction,3)))

############################ example ############################
dati[0][2]=1
modello=esempi(dati)
print(modello)
for row in dati:
	prediction = pronostico(modello, row)
	print('Expected=%d, Got=%s' % (row[-1], round(prediction,3)))

############################ example ############################
dati[1][2]=1
modello=esempi(dati)
print(modello)
for row in dati:
	prediction = pronostico(modello, row)
	print('Expected=%d, Got=%s' % (row[-1], round(prediction,3)))

############################ example ############################
import csv
import matplotlib.pyplot as plt
import pprint

#example data
[[1.0, 11.0, 1.0],
 [3.5, 12.0, 1.0],
 [5.0, 10.5, 1.0],
 [3.5, 9.0, 1.0],
 [2.0, 7.5, 1.0],
 [5.0, 7.5, 1.0],
 [1.0, 5.0, 0.0],
 [4.5, 5.0, 0.0],
 [2.0, 3.0, 0.0],
 [4.0, 2.5, 0.0],
 [2.5, 2.0, 0.0],
 [5.0, 1.0, 0.0],
 [7.5, 12.0, 0.0],
 [7.5, 9.0, 0.0],
 [10.5, 10.0, 1.0],
 [10.0, 7.5, 0.0],
 [11.5, 11.0, 0.0],
 [11.5, 9.0, 0.0],
 [6.5, 5.0, 0.0],
 [8.0, 2.5, 0.0],
 [11.0, 3.5, 1.0],
 [14.0, 5.5, 0.0],
 [13.0, 2.0, 0.0]]

path_file = "/home/fabio/Documents/alberi/example_data.txt"

dataset=list()
with(open(path_file, mode="rt")) as input_stuff:
    foo = csv.reader(input_stuff,delimiter=",", quoting=csv.QUOTE_NONNUMERIC)
    for row in foo:
        dataset.append(row)
    input_stuff.close()
del(foo,input_stuff,row,path_file)

def esempi(z, max_tree_depth, min_node_size):
    x=[row[0] for row in z]
    y=[row[1] for row in z]
    labels=[row[2] for row in z]
    plt.scatter(x, y, c=labels)
    for i in range(len(z)):
        plt.text(z[i][0], z[i][1], str(i))
    plt.show()
    return albero(z, max_tree_depth, min_node_size)

pprint.pprint(esempi(z=dataset,max_tree_depth=2,min_node_size=1))

############################ example ############################
#store initial variables to clean later
not_my_variables = set(dir())

import matplotlib.pyplot as plt

datos=[[1,1,1,1],
[2,2,2,1],
[4,1,1,1],
[5,2,2,1],
[1,1,4,1],
[2,2,5,1],
[4,1,4,1],
[5,2,5,1],
[5,5,5,0],
[4,4,4,0],
[1,4,4,0],
[2,5,5,0],
[5,5,2,1],
[4,4,1,0],
[2,5,2,1],
[1,4,1,1]]

#plot data with grouping markers
#first, add grouping markers
#recursive creation of indexes
def add_2(n,end,lista):
    if n+2 > end:
        return
    else:
        lista.append(n+2)
        add_2(n+2,end,lista)

iii=list()
add_2(-2,14,iii)
jjj=list()
add_2(0,16,jjj)

#add the grouping markers
for item in range(len(iii)):
    a, b = iii[item], jjj[item]
    for row in datos[a:b]:
        row.append(item)
        
#plot the data points with class labels and grouping markers
fig = plt.figure()
ax = fig.add_subplot(projection='3d')

x=[row[0] for row in datos]
y=[row[1] for row in datos]
z=[row[2] for row in datos]
labels=[row[3] for row in datos]

ax.scatter(x, y, z, c=labels)
for i in range(len(datos)):
    ticket='%s, [%s,%s,%s]' % (datos[i][4], datos[i][0], datos[i][1], datos[i][2])
    ax.text(datos[i][0], datos[i][1], datos[i][2], ticket, fontsize=7.5)
plt.show()

#restore data without the grouping markers
for row in range(len(datos)):
    datos[row]=datos[row][0:4]
    
#clean variables
my_variables = set(dir()) - not_my_variables
for i in my_variables:
    if i not in ["datos"]:
        del(globals()[i])
del(i,my_variables)

import pprint
pprint.pprint(albero(train_data=datos, max_depth=3, min_size=1))
"""
