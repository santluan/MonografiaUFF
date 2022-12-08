# Normalization for VADER & LM-SA (ISV x ISL)
# Luan Santos
# 24-11-2022

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from sklearn import preprocessing

path = '../monografia/'
vaderIndex_month = pd.read_csv(path + 'vader/vaderIndex_month.csv')
lmIndex_month = pd.read_csv(path + 'lm-sa/lmIndex_month.csv')

v_array = np.array(vaderIndex_month['sentiment_index'])
lm_array = np.array(lmIndex_month['sentiment_index'])

# Min-Max Scaler methor for normalization
scaler = preprocessing.MinMaxScaler()
v_array = v_array.reshape(-1, 1)
lm_array = lm_array.reshape(-1, 1)
v = scaler.fit_transform(v_array)
lm = scaler.fit_transform(lm_array)

df = pd.DataFrame({'vader': np.concatenate(v),
                   'lm_sa': np.concatenate(lm)},
                  index=pd.date_range(start='2011-01-01', periods=132, freq='MS'))

# plot
plt.style.use('seaborn-whitegrid')
plt.figure(figsize=[7.5, 5.5])
plt.plot('vader', data=df, label='ISV', color='#FF0000')
plt.plot('lm_sa', data=df, label='ISL', color='b')
plt.legend(bbox_to_anchor=(0.5, -0.15), loc='lower center', mode='expand', ncol=2)
plt.tick_params(axis='x', which='both', bottom=False, top=False, labelbottom=True)
plt.tick_params(axis='y', which='both', right=False, left=False, labelleft=True)
for pos in ['right', 'top', 'bottom', 'left']:
    plt.gca().spines[pos].set_visible(False)
plt.show()
plt.savefig(path + 'figs/isv_isl.pdf')
