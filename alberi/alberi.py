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


######## compute the terminal node value as probability of class 1 ########
# x is a dataset where the target binary variable is the last column on the right
def probabilita_1(x):
    risposte = [row[-1] for row in x]
    return risposte.count(1) / len(risposte)


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


################ Build the decision tree ################
def albero(train_data, max_depth, min_size):
	decisioni = find_best_split(train_data)
	recursive_split(decisioni, max_depth, min_size, 1)
	return decisioni


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
