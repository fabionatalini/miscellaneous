# Control flow in R, with an example using user input.


# Let's explore some control flow constructs in R: "break", "next" and "repeat". We will also see an example of control flow involving a user input.


# "break" is used to exit a loop.
# Note the difference:
# this breaks before printing the item:


for (i in 1:10) {
  if (i==5) {break}
  print(i)
}


# while this breaks after printing the item:


for (i in 1:10) {
  print(i)
  if (i==5) {break}
} 


# "next" does not work if located after the sentence, e.g. if we want to skip an item in a sequence:
# this prints the whole sequence:


for (i in 1:10) {
  print(i)
  if (i==5) {next}
}


# while this works:


for (i in 1:10) {
  if (i==5) {next}
  print(i)
} 


# "repeat" must be used together with another control-flow construct to exit the loop:
# e.g. break


x <- 0
repeat {
  x <- x+1
  print(x)
  if (x==10) {break}
}


# e.g. while


x <- 0
while (x < 10) {
  x <- x+1
  print(x)
} 


# Example with a user input
# In an interactive console, a user input can be required using the function readline. 
# In this example, the program prompt the user to enter a name: the request is repeated until the user enter a name.
# This is accomplished with some control flow constructs (i.e. repeat, if and break).


# Try to paste the following script in your R console and run it:


repeat {
  name <- readline('What’s your name? ')
  if (nchar(name)==0) {
    cat ("Please enter a name")}
  if (nchar(name)!=0) {
    cat ("Hello", name)
    rm(name)
    break}
}