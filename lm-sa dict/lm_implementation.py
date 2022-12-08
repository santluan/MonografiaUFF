# Implementation of LM-SA-2020 dictionary
# Luan Santos
# 07-12-2022

import pandas as pd

path = 'D:/Desktop/DataScience/Python/monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv', usecols=['date', 'tweetTranslated'])

loughran = pd.read_csv(path + "lm-sa/LM-SA-2020.csv", index_col='word')
loughran = loughran[(loughran['sentiment'] == 'Negative') | (loughran['sentiment'] == 'Positive')]


def count_words(data_word):
    """Count the number of words"""
    return len(data_word.split())


pos_loughran = []
neg_loughran = []
words_total = []

for row in range(0, (len(df))):

    words_total.append(count_words(df.tweetTranslated[row]))
    print('Progress: ' + str(round(((row + 1) / (len(df) + 1)) * 100, 4)) + '%')

    pos = 0
    neg = 0

    for word in df.iloc[row, 1].split():
        if word in list(loughran.index):
            try:
                if (loughran.loc[word, 'sentiment'] == 'Negative') & (loughran.loc[word, 'sentiment'] == 'Positive'):
                    continue
                elif loughran.loc[word, 'sentiment'] == 'Negative':
                    neg += 1
                else:
                    pos += 1
            except ValueError:
                pass

    pos_loughran.append(pos / words_total[row])
    neg_loughran.append(neg / words_total[row])

df.insert(len(df.columns), "lm_positive", pos_loughran, True)
df.insert(len(df.columns), "lm_negative", neg_loughran, True)

# sentiment index
df['sentiment_index'] = df.lm_positive - df.lm_negative

# descriptive stats
df.sentiment_index.describe()

# save file
df.to_csv(path + 'lm-sa/lm_sentimentIndex.csv', index=False)
