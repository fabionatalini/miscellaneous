import random
import math


#################### create a set of seeds #######################
def init_seeds(n, init_status):
    """
    n : integer; number of seeds to be created
    init_status : integer; initialize the random number generator
    """
    random.seed(init_status)
    return random.sample([i for i in range(0,1000)], n)


#################### extract random subsamples #######################
def create_random_subsets(seed_set, select_rows, dataset):
    """
    seed_set is a set of seeds created with the function init_seeds;
    (a subsample per seed will be created)
    select_rows is the percentage (float, e.g. 0.5) of rows to be extracted from the original dataset;
    dataset is the original dataset you want to extract the sumbsamples from
    """
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


#################### examples ######################
semillas=init_seeds(n=9, init_status=23)
muestras=create_random_subsets(semillas,0.5,dati)



