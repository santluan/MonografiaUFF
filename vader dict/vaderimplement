# using VADER dictionary on @folha_mercado tweets
# author: Luan Santos
# 17-10-2022

import pandas as pd
import matplotlib.pyplot as plt
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# Vader Sentiment Model
sid = SentimentIntensityAnalyzer()

# read database
path = r'D:/Desktop/DataScience/Python/monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv', usecols=['date', 'tweetTranslated'])

# transform index to date format
df.index = pd.to_datetime(df['date'])

# columns to scores, compound, comp_scores and sentiment index
df['scores'] = df.tweetTranslated.apply(lambda x: sid.polarity_scores(x))
df['compound'] = df['scores'].apply(lambda score_dict: score_dict['compound'])
df['comp_score'] = df['compound'].apply(lambda c: 'pos' if c >= 0 else 'neg')
df['sentiment_index'] = df['scores'].apply(lambda score: score['pos'] - score['neg'])

df.to_csv(path + 'vader/vader_index.csv')

# descriptive stats from compound and sentiment index
df.compound.describe()
df.sentiment_index.describe()

# diary index
vaderIndex_diary = df.groupby(pd.Grouper(freq="D")).mean()
vaderIndex_diary.to_csv(path + "vader/vaderIndex_diary.csv")

# month index
vaderIndex_month = df.groupby(pd.Grouper(freq="M")).mean()
vaderIndex_month.to_csv(path + "vader/vaderIndex_month.csv", encoding='utf-8-sig')

# quarter index
vaderIndex_quarter = df.groupby(pd.Grouper(freq="QS")).mean()
vaderIndex_quarter.to_csv(path + "vader/vaderIndex_quarter.csv", encoding='utf-8-sig')

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

# compound and sentiment index by day
plt.plot('compound', data=vaderIndex_diary, label='Compound')
plt.plot('sentiment_index', data=vaderIndex_diary, label='Sentiment Index')
plt.title('Compound x Sentiment Index by Day')
plt.legend()
plt.show()
plt.savefig(path + 'vader/sentimentIndex_diary.png')

# compound and sentiment index by month
plt.plot('compound', data=vaderIndex_month, label='Compound')
plt.plot('sentiment_index', data=vaderIndex_month, label='Sentiment Index')
plt.title('Compound x Sentiment Index by Month')
plt.legend()
plt.show()
plt.savefig(path + 'vader/sentimentIndex_month.png')

# compound and sentiment index by quarter
plt.plot('compound', data=vaderIndex_quarter, label='Compound')
plt.plot('sentiment_index', data=vaderIndex_quarter, label='Sentiment Index')
plt.title('Compound x Sentiment Index by Quarter')
plt.legend()
plt.show()
plt.savefig(path + 'vader/sentimentIndex_quarter.png')
