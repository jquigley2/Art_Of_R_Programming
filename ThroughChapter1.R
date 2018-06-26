###The Art of R Programming
### Chapter 1: Getting Started ####
#We can operate in 2 modes: interative mode, or batch mode.

###1.1.1 Interactive Mode ########
#Take the mean of the absolute value of 100 random normally distributed variates: 
mean(abs(rnorm(100)))
#The [1] in the result means this is the first line of the output.  This is more meaningful
#when there is more output, spread over many lines:
rnorm(10)

#We can store R commands in a file.  If we create a code file z.R, we can call the contents:
source("z.R")

###1.1.1 Batch Mode ########
#Batch mode is useful for production jobs which must be run regularly, because we can automete the process.
#For example, if we want to run an R script to create a graph without launching R and 
#running the script manually.

#For example, let's put our graph making code in a file names z.R with the following content:
pdf("xh.pdf") #set graphical output file
hist(rnorm(100)) #generate 100 N(0,1) variates and plot their histogram
dev.off() #close the graphical output file

#We could run this code automatically by invoking R via a shell command:
#"C:\Users\jquigley\Documents\R\R-3.4.3\bin\Rscript" z.R

###1.2 A First Session ########
#Make a simple data set - called a vector in R:
x <- c(1,2,4)
#Note there are no fixed types associated with variables.
#the "c" stands for concatenate.

#Now, we can do this:
q <- c(x,x,8)

#Now, confirm these data are there:
q

#We can access individual elements with []:
q[3]

#Subsetting is a very important operation on vectors:
q[2:4]
#The expression q[2:4] refers to a subvector of q containing elements 2 through 4

#Easily find the mean and standard deviation of our data set:
mean(q)
sd(q)

#If we want to save the the answer to a variable instead of just printing:
y <- mean(q)

#We can get a list of R's internal data sets by typing 
data()

#Nile is one of the data sets:
mean(Nile)
sd(Nile)

#We can plot a histogram of the data set:
hist(Nile)

#When finished, type q() to quit R.  If you select y for "Save Workspcae image?"
#R will load all variables the next time you run R.


###1.3 Introduction to Functions ########
#A function is a group of instructions that take inputs, uses them to compute 
#other variables, and returns a result.

#As an introductory example, let's create a function to count the number of 
#off numbers in a vector:

#Counts the number of odd integers in x:
oddcount <- function(x) {
  k <- 0 #assign 0 to k
  for (n in x) {
    if (n %% 2 ==1) k <- k+1 #%% is the modulo operator
  }
  return(k)
}

oddcount(c(1,3,5))

oddcount(c(1,2,3,4,5,7))
#First, we told R we were defining a function named oddcount with one argument, x.

#The modulo operator for R is %%:
38 %% 5

#For instance, watch what happens with this code:
k <- 0
for (n in x) {
  if(n %% 2 ==1) k <- k+1
}

#Here, x is known as the formal argument, of the function oddcount().  In the first function call above, 
#c(1,3,5) is known as the actual argument. The x in the function is just a placeholder.

###1.3.1 Variable Scope 
#A variable which is visible only within a function is said to be local to that function.
#In oddcount(), n and k are local variables; they disappear after the function returns:
oddcount(c(1,2,3,7,9))
n

#Variables created outside a function are global and are available within a function as well.  For example:
f <- function(x) return(x+y)
y <- 3
f(5)


###1.3.2 Default Arguments 
#Consider a function like this:
g <- function(x,y=2,z=T)
#Here, y will be initialized to 2 if the programmer does not specify y in the call.

g(12, z=FALSE)


###1.4 Preview of Some Important R Data Structures ########
###1.4.1 Vectors, the R Workhorse
#The elements of a vector must all have the same type.

###1.4.1.1 Scalars
#Scalars, or individual numbers, do not really exist in R.  Instead, these are actually one element vectors.  Consider:
x <- 8
x
#Remember, [1] means the following row of numbers begins with element 1 of a vector

###1.4.2 Character Strings
#Character strings are single-element vectors of character mode:

x <- c(5,12,13)
x
length(x)
mode(x)

y <- "abc"
y
length(y)
mode(y)

z <- c("abc", "29 88")
z
length(z)
mode(z)

#R has various functions to manipulate strings.  For example:
u <- paste("abc", "def", "g") #concatenate the strings
u

v <- strsplit(u, " ") #split the string according to blanks
v

###1.4.3 Matrices
#Matrices are rectangular array of numbers.  Technically, a vector with additional attributes:
#Number of rows, number of columns:
m <- rbind(c(1,4), c(2,2)) #rbind, or row bind, creates a matrix of from vectors with serve as rows.
m

m <- cbind(c(1,4), c(2,2)) #column bind
m

m %*% c(1,1)
m

#Matrices are indexed using double subscripting:
m[1,2] #first row, second column
m[2,1] #second row, first column

#We can extract submatrices:
m[1,] #entire first row
m[,2] #entire second column

###1.4.4 Lists
#Like an R vector, an R list is a container for values - but a list can contain different variable types
x <- list(u=2, v="abc")
x

#Values are accessed in two-part names:
x$v

#Lists are often used to combine multiple values into a single package which can be returned via a function:
hn <- hist(Nile) #stores all of the date in the histogram function
hn

#A more compact way to print lists like this is str():
str(hn)
#str() stands for structure


###1.4.5 Data Frames
#A matrix cannot mix data types.  Instead of a matrix, we use a data frame.
#A data frame is a list, with each component of the list being a vector corresponding to a column in our matrix of data.
d <- data.frame(list(kids=c("Jack", "Jill"),ages=c(12,10)))
d
str(d)


###1.4.6 Classes
summary(hn)
#Classes are used to organize objects.


###1.5 Extended Example: Regression Analysis of Exam Grades ########
#First, read in the data file:
examsquiz <- read.table("ExamsQuiz.txt", header=FALSE)

#Our data is now in examsquiz, which is an R object of class data frame
class(examsquiz)

#Let's check out the first few rows to make sure it loaded correctly
head(examsquiz)

#Let's predict exam 2 score from the results of exam 1 (first column):
lma <- lm(examsquiz[,2] ~ examsquiz[,1]) #lm means linear model function

#We could have written this as:
lma <- lm(examsquiz$V2 ~ examsquiz$V1)

#The results are now in an object we've stored in the variable lma, which is an instance of the class lm.
#We can list its components by calling attributes():
attributes(lma)

str(lma) #For more detail
lma$coefficients #call a single component
lma$coef #we can also shorten the reference

lma #Here, R uses the print() fnct, which hands off the work to a function which prints objects of calss lm

summary(lma)


lmb <- lm(examsquiz$V2 ~ examsquiz$V1 + examsquiz$V3)
lmb

###1.6 Startup and Shutdown ########
getwd() #To check your current working directory

setwd() #To set your working directory

?Startup

###1.7 Getting Help ########


###1.7.1 The help() function


###1.7.2 The example() Function
#Each of the help entries comes with examples we can run:
example(seq)

#Works for graphics examples, too!
example("persp")


###1.7.3 If You Don't Know Quite What You're Looking for
#Use help.search() for Google-like functionality:
help.search("multivariate normal")
#?? is a shortcut for help.search()

#Get help on a package by:
help(package=MASS)

###1.7.5 Help For Batch Mode
R CMD --help
R CMD INSTALL --help



