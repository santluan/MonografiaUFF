import pandas as pd
import matplotlib.pyplot as plt
plt.style.use('seaborn-whitegrid')

path = "D:\\Desktop\\DataScience\\Python\\monografia\\"

# read data
bigdata = pd.read_csv(path + 'data\\BigData_GoogleTrends.csv', skiprows=2)
bigdata.columns = ['month', 'value']
bigdata.index = pd.to_datetime(bigdata.month)

sentiment = pd.read_csv(path + 'data\\SentimentAnalysis_GoogleTrends.csv', skiprows=2)
sentiment.columns = ['month', 'value']
sentiment.index = pd.to_datetime(sentiment.month)

# plot
plt.figure(figsize=[9, 4.5])
plt.plot('value', data=bigdata, color='gray', alpha=0.7)
plt.fill_between(x=bigdata.index, y1=bigdata.value, color='gray', alpha=0.5)
for spine in plt.gca().spines.values():
    spine.set_visible(False)
plt.show()
plt.savefig(path + 'figs\\bigdata_google.pdf')

plt.figure(figsize=[9, 4.5])
plt.plot('value', data=sentiment, color='#FF0000', alpha=0.4)
plt.fill_between(x=sentiment.index, y1=sentiment.value, color='#FF0000', alpha=0.5)
for spine in plt.gca().spines.values():
    spine.set_visible(False)
plt.show()
plt.savefig(path + 'figs\\sentimentanalysis_google.pdf')
