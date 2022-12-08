########## PLOTS ##############
# Luan Santos
# 07-12-2022

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

path = '../monografia/vader/'

# load data
vaderIndex_month = pd.read_csv(path + 'vaderIndex_month.csv')
vaderIndex_month.index = pd.to_datetime(vaderIndex_month['date'])

# function to plot index
def plot_index(data, period):
    plt.plot('compound', data=data, label='Compound')
    plt.plot('sentiment_index', data=data, label='Sentiment Index')
    plt.title('Compound x Sentiment Index by ' + period)
    plt.legend()
    plt.show()

plot_index(vaderIndex_month, 'month')
plt.savefig(path + 'vader/sentimentIndex_month.png')

# graph to monograph
# monthly index
plt.style.use('seaborn-whitegrid')
#plt.figure(figsize=[7.5, 5.5])
plt.plot('sentiment_index', data=vaderIndex_month, label='Índice de Sentimentos VADER', color='#FF0000')
plt.legend(bbox_to_anchor=(0.5,-0.15), loc='lower center')
plt.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=True)
plt.tick_params(axis='y', which='both', right=False, left=False, labelleft=True)
for pos in ['right', 'top', 'bottom', 'left']:
    plt.gca().spines[pos].set_visible(False)
plt.show()
plt.savefig(path + 'isv.pdf')

# density plot
sns.set_style('white')
isv1 = sns.displot(data=vaderIndex_month, x='sentiment_index', kde=True, color='red')
isv1.set(xlabel='ISV', ylabel="Densidade")
for pos in ['right', 'top', 'bottom', 'left']:
    plt.gca().spines[pos].set_visible(False)
plt.show()
plt.savefig(path + 'isv_densityplot.pdf')
