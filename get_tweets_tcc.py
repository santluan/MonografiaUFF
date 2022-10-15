# Code to extract tweets from @folha_mercado using snscrape
# author: Luan Santos
# 15-10-2022

import snscrape.modules.twitter as sntwitter
import pandas as pd

# my path
path = "../monografia/Data/"

# query to search tweets
query = "(from:folha_mercado) until:2021-12-31 since:2021-01-01"
tweets = []
limit = 100000

# loop for to extract tweets
for tweet in sntwitter.TwitterSearchScraper(query).get_items():
    if len(tweets) == limit:
        break
    else:
        tweets.append([tweet.date, tweet.user.username, tweet.content])

# storing tweets on dataframe
df = pd.DataFrame(tweets, columns=['date', 'user', 'tweet'])
df['Date'] = df['Date'].apply(lambda a: pd.to_datetime(a).date())

# save in csv file
filename = 'folhamercado_tweets_2021.csv'
df.to_csv(path + filename, index=False, encoding='utf-8-sig')
