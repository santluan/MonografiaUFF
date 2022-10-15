# Code to clean and translate tweets from @folha_mercado using googletrans
# author: Luan Santos
# 15-10-2022

import re
import time
import pandas as pd
from googletrans import Translator
translator = Translator()

# read tweets csv
path = r'D:/Desktop/DataScience/Python/monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv')

# remove url from tweets
df['clean_tweet'] = df['tweet'].apply(lambda x: re.sub("http\S+", "", x))

# function to translate tweets with interval of 0.1 sec
def translate(x):
    y = ""
    time.sleep(0.1)
    try:
        v = translator.translate(x).text
        return v
    except:
        return y

# using lambda to translate every tweet
df['tweetTranslated'] = df.clean_tweet.apply(lambda x: translate(x))

# saving csv file
df.to_csv(path + "folhamercado_tweets.csv", index=False, encoding='utf-8-sig')