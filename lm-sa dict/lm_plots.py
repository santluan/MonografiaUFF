import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

path = '..\\monografia\\lm-sa\\'

lmIndex_month = pd.read_csv(path + 'lmIndex_month.csv')
lmIndex_month.index = pd.to_datetime(lmIndex_month.date)

plt.style.use('seaborn-whitegrid')
plt.figure(figsize=[7.5, 5.5])
plt.plot('sentiment_index', data=lmIndex_month, label='Índice de Sentimentos LM-SA', color='b')
plt.legend(bbox_to_anchor=(0.5,-0.15), loc='lower center')
plt.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=True)
plt.tick_params(axis='y', which='both', right=False, left=False, labelleft=True)
for pos in ['right', 'top', 'bottom', 'left']:
    plt.gca().spines[pos].set_visible(False)
plt.show()
plt.savefig(path + 'isl.pdf')

sns.set_style('white')
lm = sns.displot(data=lmIndex_month, x='sentiment_index', kde=True, color='blue')
lm.set(xlabel='ISL', ylabel='Densidade')
for pos in ['right', 'top', 'bottom', 'left']:
    plt.gca().spines[pos].set_visible(False)
plt.show()
plt.savefig(path + 'isl_densityplot.pdf')
