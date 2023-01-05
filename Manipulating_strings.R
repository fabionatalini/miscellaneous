# Working with strings in R


# Let's explore some functions in R to manipulate strings, including some functions of the package stringr and regular expressions.

# Use multiple patterns in grep
# Set the pattern to search:
pat <- c("m","h")


# Search the patterns among a list of names (e.g. the names of the data set mtcars):
names(mtcars)[unlist(sapply(pat, grep, names(mtcars)))]

# Upper case of specific positions in strings

# We have the following names:
nation <- c("italy", "new_zealand", "trinidad_and_tobago")


# We want to convert to upper case the first letter after each underscore.
mylist <- list()
for (i in 1:length(strsplit(nation, "_"))) {
  mylist[[i]] <- paste0(
    toupper(substr(strsplit(nation, "_")[[i]], 1, 1)),
    substr(strsplit(nation, "_")[[i]], 2, nchar(strsplit(nation, "_")[[i]])))
}
unlist(lapply(mylist, paste0, collapse="_")) 


# Package stringr

# comparing str_extract and str_extract_all
library(stringr)

# Take the (Italian) names of something:
cose <- c('casa case', 'rosa rose', 'sarto sarti', 'macchina macchine', 'cielo cieli')

# Let’s extract the names containing the pattern “sa”:
# this extracts partial strings:

str_extract(cose,'sa')


# this extracts all the strings and put them in a matrix:
str_extract_all(cose,'sa', TRUE)


# if you remove the logical TRUE, you will have a list.

# Function strsplit


# Store the date and the time:


today_now <- Sys.time()


# this is a string like this: "2018-08-09 16:56:23 CEST"


# Split the string using the space as separator:


strsplit(today_now," ")


# strsplit gives a list; there are 2 strings in the first element of the list.


# Split the string using the colon as separator:


strsplit(today_now,":")


# there are 3 strings in the first element of the list.


# Exact string matching


# Match the beginning and the end of a string


my_strings <- c("abcd", "cdab", "cabd", "cab ")


# extract strings beginning with “c” and ending with “d”:


grep("^c.*d$", my_strings, value = TRUE)


# Exact string matching using \\b


my_string <- c("4911 6282")
grepl("\\b4911\\b", my_string)


# this gives TRUE because there is 4911 in my_string


grepl("\\b491\\b", my_string)


# this gives FALSE because 491 is not in my_string 


# Alphanumeric strings and regular expressions


# Create alphanumeric strings:


my_codes <- c("code_n", "code_1_n", "code_11_n", "code_111_n", "code_2_n", "code_22_n", "code_222_n")


# In my_codes, match "code_" followed by a number between 0 and 9, repeated at least once and max 2 times, followed by "_"


grep("code_[0-9]{1,2}_", my_codes, value=TRUE)


# In my_codes, match "code_" followed by a number between 0 and 9, repeated at least once and max 3 times, followed by "_"


grep("code_[0-9]{1,3}_", my_codes, value=TRUE)