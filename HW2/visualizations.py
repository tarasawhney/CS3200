#IMPORTS 
import pandas as pd 
import matplotlib.pyplot as plt 

########

#reading the csv file
neurological = pd.read_csv('neurological_phenos.csv')
neurological

########

#creating dataframe
neurological_df = pd.DataFrame(neurological)

#cleaning the dataset 
#removing any NAN values 
clean_neuro = neurological_df.dropna()
clean_neuro

#########

#initialize the lists for x and y 
x = list(clean_neuro.iloc[:, 0])
y = list(clean_neuro.iloc[:, 1])


#######
#plot data using bar() method
plt.bar(x, y, color='pink')
plt.title('Top 10 Populations with the most Neurological Phenotypes')
plt.xlabel('Population')
plt.ylabel('Count Neurological Phenotypes')
plt.xticks(rotation=45)
plt.show()

