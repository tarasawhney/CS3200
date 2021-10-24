#IMPORTS 
import matplotlib.pyplot as plt 
import numpy as np 
import pandas as pd 
import plotly.express as px 

#reading the csv file 
df = pd.read_csv('query1.csv')
df

#create figure and axis w subplots()
fig, ax = plt.subplots()
#make the plot
ax.plot(q1.year, q1.forest_percentage, '--',color='green', label='Forest %', linewidth=4)
#set x-axis label 
ax.set_xlabel("Year", fontsize=14)
#set y-axis label
ax.set_ylabel("Forest Percentage", color='black', fontsize=14)
plt.legend(loc="lower left", bbox_to_anchor=(0.5, 1.15), ncol=2)
sns.set()

ax2 = ax.twinx()
ax2.plot(q1.year, q1.population, color='blue', label='Population (billions)', linewidth=4)
#plt.legend()
#plt.title('Forest % vs Jaguar Population in Brazil', fontsize=14)
#plt.show()

#years 
x = ['2013', '2016']
#data for forest percentage 
forest = [60.655, 60.071]
#data for elephant populatoin
pop = [301, 286]
  
X_axis = np.arange(len(x))

#creating the bar graph for forest
plt.bar(X_axis - 0.2, forest, 0.4, label = 'Forest %', edgecolor='black', color='blue')
#creating the bar grah for population
plt.bar(X_axis + 0.2, pop, 0.4, label = 'Population (thousands)', edgecolor='black', color='brown')
  
plt.xticks(X_axis, x)
#labeling x axis 
plt.xlabel("Year", fontsize=12)
#labeling y axis
plt.ylabel("Forest Percentage", fontsize=12)
#adding a title 
plt.title("Forest % vs Jaguar Population (2013 & 2016)", color='black', fontsize=14)

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
