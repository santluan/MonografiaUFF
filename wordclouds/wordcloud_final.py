import string
import pandas as pd
import matplotlib.pyplot as plt
from wordcloud import WordCloud, STOPWORDS
from nltk.corpus import stopwords

path = r'D:/Desktop/DataScience/Python/monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv')

# treating stopwords
stopword = set(stopwords.words('english'))
more_words = ['says', 'r$', 'new', 'billion', '#folha', 'million', 'wants', 'brl',
              'approves', 'may', 'first', 'year', 'without', 'us$', 'end', 'since',
              'see', 'without', 'end', 'goes', '1st', 'reaches', 'points', 'make',
              'sees', 'day', 'say', 'will', 'want', 'years', 'launches', 'already',
              '2nd', 'could', 'must', 'take', 'use', 'asks', 'level', 'almost', 'year.'
              'starts', 'start', 'due', 'billion.', 'thousand', 'even', 'two',
              'car', '3rd', '1', 'go', 'still', 'U', 'leaf', 'talk', 'avoid',
              'group', 'folha', 'creates', 'less', '#leaf', 'gives', 'secong'
              'ends', 'shows', 'de', 'video', 'share', 'people', 'week', 'hits',
              'truck', 'despite', 'worst', 'small', 'month', 'reach', 'takes',
              'next', 'low', 'high', 'highest', 'lower', 'open', 'one', '3']
stopword.update(STOPWORDS)
stopword.update(more_words)

# WORDCLOUD

# combine tweets into one big text
text = " ".join(tweet for tweet in df.tweetTranslated)
new_text = text.translate(str.maketrans('', '', string.punctuation)).lower()

# change color font to black
def black_color_func(word, font_size, position,orientation,random_state=None, **kwargs):
    return("hsl(0,100%, 1%)")

# most 500 frequent words
wordcloud = WordCloud(stopwords=stopword, background_color="white", width=3000, height=2000, max_words=500).generate(new_text)
wordcloud.recolor(color_func=black_color_func)
plt.figure(figsize=[15, 10])
plt.title('Wordcloud for News Tweets by @folha_mercado - using STOPWORDS by WordCloud')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

wordcloud.to_file(path + 'wordclouds/wordcloud_tweets.pdf')

#most 100 frequent words
wordcloud = WordCloud(stopwords=stopword, background_color="white", width=3000, height=2000, max_words=100).generate(text)
wordcloud.recolor(color_func=black_color_func)
plt.figure(figsize=[15, 10])
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

wordcloud.to_file(path + 'wordclouds/wordcloud_100.png')
