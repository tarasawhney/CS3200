#IMPORTS 
import pandas as pd 
import matplotlib.pyplot as plt 

#list elements for year
year = [1995, 1998, 2002, 2007, 2013, 2016]
#list elements for population
population = [266233, 301733, 402067, 472269, 426293, 415428]

#plot year and population
plt.plot(year, population,linewidth=4)
#add title
plt.title("Elephant Population Size from 1995-2016", color='black', fontsize=14)
#name x axis
plt.xlabel("Year")
#name y axis 
plt.ylabel("Population")
#making the graph pretty
sns.set()
#displaying graph 
plt.show()

#creating regression plot with the same data 
sns.regplot(year, population, color='black')
#setting title of graph 
plt.title('Regression Analysis of Elephant Population', color='black', fontsize=14)
#make the graph pretty
sns.set()
