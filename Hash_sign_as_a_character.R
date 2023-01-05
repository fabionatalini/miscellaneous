# Hash sign (#) as a character

# There is an argument in read.table which allows to change the comment character:
# read.table( ...., comment.char="", ...)

# If character strings in your data set include the hash sign, this will be read as a character. Let’s see an example.
# We have the following dataset (called “foo.txt” in the working directory):

# NAME    | ADDRESS                   | CITY
# Jhon      | St. Peter Street # 17 | London
# Andrea  | Upper Street # 25     | New York
# Michael | Central Park              | Sydney

# The following command gives an error because R finds the hash sign in two rows of the dataframe and considers them as the start of comments:
read.table("foo.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)

# With the following command we change the comment sign from hash sign to another character (for example an underscore):
read.table("foo.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE, comment.char="_")

# In this case the data set has been successfully read.