# Teste ADF e PP
# Luan Santos
# 24-11-2022

setwd('D:\\Desktop\\DataScience\\Python\\monografia\\')

# packages
# packages = c('aTSA', 'EnvStats', 'tseries', 'lmtest', 'sandwich', 'skedastic',
#              'Hmisc', 'scales', 'broom', 'bayesforecast', 'dynamac')
# install.packages(packages)
#lapply(packages, require, character.only = TRUE)

require(aTSA)
require(urca)
require(mFilter)

# load data
ISV <- read.csv('vader\\vaderIndex_month.csv', row.names = 1)
ISL <- read.csv('lm-sa\\lmIndex_month.csv', row.names = 1)
ibcbr <- read.csv('data\\ibc_br.csv', row.names = 1)
ipca <- read.csv('data\\ipca.csv', row.names = 1)
selic <- read.csv('data\\selic.csv', row.names = 1)
ibov <- read.csv('data\\ibov_returns.csv', row.names = 1)

ISV <- merge(ISV, selic, by = 0)

hiato <- hpfilter(ibcbr$ibc_br_adj, freq=14440)
#plot(hiato)

df <- data.frame(ISL$sentiment_index, ISV[c('sentiment_index', 'selic')],
                 ibcbr$ibc_br_adj, hiato$cycle, ipca$ipca, ibov$returns)

colnames(df) <- c('ISL', 'ISV', 'selic', 'ibcbr', 'hiato', 'ipca', 'ibov')

rm(ISV, ISL, ibcbr, ipca, selic, hiato, ibov)

############### ADF test #################

# sem diferen?a ####

data <- aTSA::adf.test(df$ISV)
isv_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])

data <- aTSA::adf.test(df$ISL)
isl_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])

data <- aTSA::adf.test(df$ibcbr)
ibc_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])

data <- aTSA::adf.test(df$ipca)
ipca_adf <- data.frame(type1_none = data$type1[1,],
                       type2_drift = data$type2[1,],
                       type3_trend = data$type3[1,])

data <- aTSA::adf.test(df$selic)
selic_adf <- data.frame(type1_none = data$type1[4,],
                        type2_drift = data$type2[4,],
                        type3_trend = data$type3[4,])

data <- aTSA::adf.test(df$hiato)
hiato_adf <- data.frame(type1_none = data$type1[1,],
                        type2_drift = data$type2[1,],
                        type3_trend = data$type3[1,])

data <- aTSA::adf.test(df$ibov)
ibov_adf <- data.frame(type1_none = data$type1[1,],
                       type2_drift = data$type2[1,],
                       type3_trend = data$type3[1,])

# primeira diferen?a ####

d_isv <- diff(df$ISV)
data <- aTSA::adf.test(d_isv)
d_isv_adf <- data.frame(type1_none = data$type1[1,],
                        type2_drift = data$type2[1,],
                        type3_trend = data$type3[1,])

d_isl <- diff(df$ISL)
data <- aTSA::adf.test(d_isl)
d_isl_adf <- data.frame(type1_none = data$type1[1,],
                        type2_drift = data$type2[1,],
                        type3_trend = data$type3[1,])

d_ibcbr <- diff(df$ibcbr)
data <- aTSA::adf.test(d_ibcbr)
d_ibcbr_adf <- data.frame(type1_none = data$type1[1,],
                          type2_drift = data$type2[1,],
                          type3_trend = data$type3[1,])

d_ipca <- diff(df$ipca)
data <- aTSA::adf.test(d_ipca)
d_ipca_adf <- data.frame(type1_none = data$type1[1,],
                         type2_drift = data$type2[1,],
                         type3_trend = data$type3[1,])

d_selic <- diff(df$selic)
data <- aTSA::adf.test(d_selic)
d_selic_adf <- data.frame(type1_none = data$type1[1,],
                          type2_drift = data$type2[1,],
                          type3_trend = data$type3[1,])

d_hiato <- diff(df$hiato)
data <- aTSA::adf.test(d_hiato)
d_hiato_adf <- data.frame(type1_none = data$type1[1,],
                          type2_drift = data$type2[1,],
                          type3_trend = data$type3[1,])

d_ibov <- diff(df$ibov)

############## PP test ###########

isv_pp <- aTSA::pp.test(df$ISV, type = "Z_tau")
isl_pp <- aTSA::pp.test(df$ISL, type = "Z_tau")
ibcbr_pp <- aTSA::pp.test(df$ibcbr, type = "Z_tau")
ipca_pp <- aTSA::pp.test(df$ipca, type = "Z_tau")
selic_pp <- aTSA::pp.test(df$selic, type = "Z_tau")
hiato_pp <- aTSA::pp.test(df$hiato, type = "Z_tau")
ibov_pp <- aTSA::pp.test(df$ibov, type='Z_tau')

d_isv_pp <- aTSA::pp.test(d_isv, type = "Z_tau")
d_isl_pp <- aTSA::pp.test(d_isl, type = "Z_tau")
d_ibcbr_pp <- aTSA::pp.test(d_ibcbr, type = "Z_tau")
d_ipca_pp <- aTSA::pp.test(d_ipca, type = "Z_tau")
d_selic_pp <- aTSA::pp.test(d_selic, type = 'Z_tau')
d_hiato_pp <- aTSA::pp.test(d_hiato, type = "Z_tau")

#### save data ####

diff_data <- data.frame(d_isv, d_isl, d_ibcbr, d_ipca, d_selic, d_hiato, d_ibov)
write.csv(diff_data, file = "data\\diff_econdata.csv")
write.csv(df, file = 'data\\econdata.csv')

save.image(file = 'stacionarity_test.Rdata')
load('stacionarity_test.Rdata')
