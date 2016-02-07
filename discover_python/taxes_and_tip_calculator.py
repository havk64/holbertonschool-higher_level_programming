"""
This is the taxes_and_tip_calculator.py, the file for task of the 
"Discover Python" by Alexandro de Oliveira
"""
 
print "Welcome to the taxes and tip calculator!"
price = input("What is the price before tax? ")
tax = input("What are the taxes? (in %) ")
tip = input("What do you want to tip? (in %) ")

#Using two functions to do all the job
#This first function just calculates the percentage
def perc(n):
	return float(n)/100

#This second function calls the first in the second and third lines, adding the price to it and returns the total price in the last line
def taxntips(price,tax,tip):
	price += price * perc(tax)
	price += price * perc(tip)
	return price

#Here I'm using the function taxntips to calculate the total
total = taxntips(price, tax, tip)
#Formating the output to meet requirements
print "The price you need to pay is: $%.6f." % total
