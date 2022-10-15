# Cleaning tweets process and concatenating files
# Luan Santos
# 15-10-2022

import glob
import re
import pandas as pd

# read all filenames in path
path = r'D:/Desktop/DataScience/Python/monografia/'
files = glob.glob(path + "/Data/*.csv")

df = pd.DataFrame()

# read all files and turn into dataframe
for file in files:
    data = pd.read_csv(file)
    df = df.append(data).reset_index(drop=True)

# renaming collumns
df.columns = ['date', 'user', 'tweet']

# remove url from tweets
df['clean_tweet'] = df['tweet'].apply(lambda x: re.sub("http\S+", "", x))

# saving csv file
df.to_csv(path + "folhamercado_tweets.csv", index=False, encoding='utf-8-sig')
