#IMPORTS
import numpy as np 
import matplotlib.pyplot as plt 
  
#years 
x = ['2013', '2016']
#data for forest percentage 
forest = [28.3782, 27.7520]
#data for elephant populatoin
pop = [426, 415]
  
X_axis = np.arange(len(x))

#creating the bar graph for forest
plt.bar(X_axis - 0.2, forest, 0.4, label = 'Forest %', edgecolor='black', color='green')
#creating the bar grah for population
plt.bar(X_axis + 0.2, pop, 0.4, label = 'Population (thousands)', edgecolor='black', color='grey')
  
plt.xticks(X_axis, x)
#labeling x axis 
plt.xlabel("Year", fontsize=12)
#labeling y axis
plt.ylabel("Forest Percentage", fontsize=12)
#adding a title 
plt.title("Forest % vs Elephant Population (2013 & 2016)", color='black', fontsize=14)

#moving the legend 
plt.legend(loc="lower left", bbox_to_anchor=(0.5, 1.15), ncol=2)

#adds the numbers on top of the bar 
for i in range(len(pop)):
    #adding values to top of population bar 
    plt.text(i, pop[i], pop[i], ha= 'left', va='bottom', ma='center')
    #adding values to top of forest percentage bar 
    plt.text(i, forest[i], forest[i], ha='right', va='bottom')

#making the graph pretty
sns.set()
#displaying graph
plt.show()

