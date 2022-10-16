# Unique words and word occurrences on @folha_mercado tweets
# author: Luan Santos
# 16-10-2022

import nltk
nltk.download('stopwords')
import pandas as pd
from collections import Counter
from nltk.corpus import stopwords

# read csv file
path = r'../monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv')

# concatenate tweets
text = " ".join(t for t in df.tweetTranslated).lower().split()

# set stopwords
stopword = set(stopwords.words('english'))

# loop for exclude stopwords from text
words_filtered = []

for w in text:
    if w not in stopword:
        words_filtered.append(w)

# getting the amount of unique words
unique = len(set(text))
print("There are " + str(unique) + " unique words on tweets from @folha_mercado")

# getting the most common words
counter = Counter(words_filtered)
common_words = counter.most_common()
word_occurrence = pd.DataFrame(common_words, columns=['word', 'occurrence'])

word_occurrence.to_csv(path + "word_occurrence_folhamercado.csv", index=False, encoding='utf-8-sig')
