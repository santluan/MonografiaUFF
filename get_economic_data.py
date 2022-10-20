# getting economic data
# author: Luan Santos
# 19-10-2022

from bcb import sgs

path = 'D:\\Desktop\\DataScience\\Python\\monografia\\data\\'

# interest rate (taxa de juros selic)
selic = sgs.get({'selic': 432}, start='2011-01-01')

# price index
ipca = sgs.get({'ipca': 433}, start='2011-01-01')

# pib
pib = sgs.get({'pib': 4380,
               'pib_acum': 4381}, start='2011-01-01')

selic.to_csv(path + 'selic.csv')
ipca.to_csv(path + 'ipca.csv')
pib.to_csv(path + 'pib.csv')
