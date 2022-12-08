# using VADER dictionary on @folha_mercado tweets
# author: Luan Santos
# 17-10-2022

import pandas as pd
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
df['pos_sentiment'] = df['scores'].apply(lambda score: score['pos'])
df['neg_sentiment'] = df['scores'].apply(lambda score: score['neg'])
df['compound'] = df['scores'].apply(lambda score: score['compound'])
df['sentiment_index'] = df.pos_sentiment - df.neg_sentiment

df.to_csv(path + 'vader/vader_index.csv')

# month index
vaderIndex_diary = df.groupby(pd.Grouper(freq="MS")).mean(numeric_only=True)
vaderIndex_diary.to_csv(path + "vader/vaderIndex_month.csv")
