########## PLOTS ##############

import pandas as pd
import matplotlib.pyplot as plt

path = 'D:/Desktop/DataScience/Python/monografia/vader/'
vaderIndex_diary = pd.read_csv(path + 'vaderIndex_diary.csv')
vaderIndex_diary.index = pd.to_datetime(vaderIndex_diary['date'])

vaderIndex_month = pd.read_csv(path + 'vaderIndex_month.csv')
vaderIndex_month.index = pd.to_datetime(vaderIndex_diary['date'])

vaderIndex_quarter = pd.read_csv(path + 'vaderIndex_quarter.csv')
vaderIndex_quarter.index = pd.to_datetime(vaderIndex_diary['date'])

df = pd.read_csv(path + 'vader_index.csv')

# plot compound index
plt.plot(df.compound)
plt.title('compound index for folha_mercado tweets - using all tweets')
plt.draw()
plt.show()
plt.savefig(path + 'vader/compound_index.png')

# plot sentiment index
plt.plot(df.sentiment_index)
plt.title('sentiment index for folha_mercado tweets - using all tweets')
plt.draw()
plt.show()
plt.savefig(path + 'vader/sentiment_index.png')

# function to plot index
def plot_index(data, period):
    plt.plot('compound', data=data, label='Compound')
    plt.plot('sentiment_index', data=data, label='Sentiment Index')
    plt.title('Compound x Sentiment Index by ' + period)
    plt.legend()
    plt.show()


plot_index(vaderIndex_diary, 'day')
plt.savefig(path + 'vader/sentimentIndex_diary.png')

plot_index(vaderIndex_month, 'month')
plt.savefig(path + 'vader/sentimentIndex_month.png')

plot_index(vaderIndex_quarter, 'quarter')
plt.savefig(path + 'vader/sentimentIndex_quarter.png')
