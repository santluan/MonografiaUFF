# Economic plots
# Luan Santos
# 07-12-22

import pandas as pd
import matplotlib.pyplot as plt

path = 'D:/Desktop/DataScience/Python/monografia/'

# load data
selic = pd.read_csv(path + 'data/selic.csv')
ipca = pd.read_csv(path + 'data/ipca.csv')
ibcbr = pd.read_csv(path + 'data/ibc_br.csv')
ibov = pd.read_csv(path + 'data/ibov_returns.csv')

selic.index = pd.to_datetime(selic.Date)
ipca.index = pd.to_datetime(ipca.Date)
ibcbr.index = pd.to_datetime(ibcbr.Date)
ibov.index = pd.to_datetime(ibov.date)

# plots
plt.style.use('seaborn-white')
fig = plt.figure(figsize=(7.5, 6.5))
sub1 = plt.subplot(2, 2, 1)
sub1.plot('ibc_br', data=ibcbr, color='gray')
sub1.set_title('IBC-Br')
for spine in sub1.spines.values():
    spine.set_visible(False)

sub2 = plt.subplot(2, 2, 2)
sub2.plot('ipca', data=ipca, label='IPCA', color='gray')
sub2.set_title('IPCA')
for spine in sub2.spines.values():
    spine.set_visible(False)

sub3 = plt.subplot(2, 2, 3)
sub3.plot('selic', data=selic, label='SELIC', color='gray')
sub3.set_title('SELIC')
for spine in sub3.spines.values():
    spine.set_visible(False)

sub4 = plt.subplot(2, 2, 4)
sub4.plot('returns', data=ibov, color='gray')
sub4.set_title('IBOVESPA')
for spine in sub4.spines.values():
    spine.set_visible(False)

fig.tight_layout()
plt.show()

plt.savefig(path + 'figs/econ_plots.pdf')
