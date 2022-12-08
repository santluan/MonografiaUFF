# getting ibovespa monthly returns
# Luan Santos
# 24-11-2022

import yfinance as yf
import pandas as pd

path = 'D:/Desktop/DataScience/Python/monografia/'

# obtendo índice BOVESPA
ibov = yf.download('^BVSP', start='2010-12-01', end='2021-12-31')['Adj Close']
ibov = pd.DataFrame(ibov)

# retornando as datas mais recentes para cada mês
ibov['date'] = ibov.index
ibov['month-year'] = ibov['date'].dt.to_period('M')
df = pd.DataFrame(ibov.groupby('month-year')['date'].min())
df2 = df.join(ibov['Adj Close'], on='date').reset_index(drop=True)

# criando coluna de retornos
df2['returns'] = df2['Adj Close'].pct_change()
ibov_returns = df2[['date', 'returns']][1:]

# save csv
ibov.to_csv(path + 'data/ibovespa.csv')
ibov_returns.to_csv(path + 'data/ibov_returns.csv', index=False)
