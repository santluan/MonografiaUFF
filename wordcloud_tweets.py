# Make Wordclouds with news tweets
# author: Luan Santos @santluan
# 15-10-2022

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
from PIL import Image

# read tweets
path = r'D:/Desktop/DataScience/Python/monografia/'
df = pd.read_csv(path + 'folhamercado_tweets.csv')

# change the color font to black
def black_color_func(word, font_size, position,orientation,random_state=None, **kwargs):
    return("hsl(0,100%, 1%)")

# portuguese tweets
# combine tweets into one big text
text = " ".join(tweet for tweet in df.clean_tweet)

wordcloud = WordCloud(background_color="white", width=3000, height=2000, max_words=500).generate(text)
wordcloud.recolor(color_func=black_color_func)
plt.figure(figsize=[15, 10])
plt.title('WordCloud dos Tweets de @folha_mercado entre 2011-2021')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

plt.savefig(path + "wordclouds/wordcloud_pt.png")

# using stopwords and translated tweets
text = " ".join(tweet for tweet in df.tweetTranslated)

stopwords = set(STOPWORDS)
wordcloud = WordCloud(stopwords=stopwords, background_color="white", width=3000, height=2000, max_words=500).generate(text)
wordcloud.recolor(color_func=black_color_func)
plt.figure(figsize=[15, 10])
plt.title('Wordcloud for News Tweets by @folha_mercado - using STOPWORDS by WordCloud')
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
plt.show()

plt.savefig(path + "wordclouds/wordcloud_en.png")

# use mask method
mask = np.array(Image.open(path + 'brazil.png'))

wordcloud = WordCloud(stopwords=stopwords, background_color='white', max_words=500, mode="RGBA", mask=mask).generate(text)
image_colors = ImageColorGenerator(mask)
plt.figure(figsize=[7, 7])
plt.imshow(wordcloud.recolor(color_func=image_colors), interpolation="bilinear")
plt.axis("off")
plt.show()

wordcloud.to_file(path + "wordclouds/wordcloud_brazilflag.png")