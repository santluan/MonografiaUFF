setwd('D:\\Desktop\\DataScience\\Python\\monografia\\')

# packages
# packages = c('aTSA', 'EnvStats', 'tseries', 'lmtest', 'sandwich', 'skedastic',
#              'Hmisc', 'scales', 'broom', 'bayesforecast', 'dynamac')
# install.packages(packages)
#lapply(packages, require, character.only = TRUE)

require(aTSA)
require(urca)

# load data
ISV <- read.csv('vader\\vaderIndex_month.csv', row.names = 1)
ISL <- read.csv('lm-sa\\lmIndex_month.csv', row.names = 1)
ibcbr <- read.csv('data\\ibc_br.csv', row.names = 1)
ipca <- read.csv('data\\ipca.csv', row.names = 1)
selic <- read.csv('data\\selic.csv', row.names = 1)

ISV <- merge(ISV, selic, by = 0)

df <- data.frame(ISL$sentiment_index, ISV[c('sentiment_index', 'selic')],
                 ibcbr$ibc_br_adj, ipca$ipca_12m)

colnames(df) <- c('ISL', 'ISV', 'selic', 'ibcbr', 'ipca')

rm(ISV, ISL, ibcbr, ipca, selic)

############### ADF test #################

# sem diferen?a ####

data <- aTSA::adf.test(df$ISV)

isv_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])

"none: ISV rejeita H0;
drift: ISV rejeita H0;
trend: ISV rejeita H0"

data <- aTSA::adf.test(df$ISL)

isl_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])

"none: ISV n?o rejeita H0;
drift: ISV rejeita H0;
trend: ISV rejeita H0"

data <- aTSA::adf.test(df$ibcbr)

ibc_adf <- data.frame(type1_none = data$type1[1,],
                      type2_drift = data$type2[1,],
                      type3_trend = data$type3[1,])


"IBC-Br n?o rejeita H0 para nenhuma das hip?teses/tipos"


data <- aTSA::adf.test(df$ipca)

ipca_adf <- data.frame(type1_none = data$type1[5,],
                       type2_drift = data$type2[5,],
                       type3_trend = data$type3[5,])

"IPCA n?o rejeita H0 para nenhuma das hip?teses/tipos"

data <- aTSA::adf.test(df$selic)

selic_adf <- data.frame(type1_none = data$type1[4,],
                        type2_drift = data$type2[4,],
                        type3_trend = data$type3[4,])

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

"todas as s?ries em diferen?a rejeitam H0"

############## PP test ###########

isv_pp <- aTSA::pp.test(df$ISV, type = "Z_tau")
isl_pp <- aTSA::pp.test(df$ISL, type = "Z_tau")
ibcbr_pp <- aTSA::pp.test(df$ibcbr, type = "Z_tau")
ipca_pp <- aTSA::pp.test(df$ipca, type = "Z_tau")
selic_pp <- aTSA::pp.test(df$selic, type = "Z_tau")

d_isv_pp <- aTSA::pp.test(d_isv, type = "Z_tau")
d_isl_pp <- aTSA::pp.test(d_isl, type = "Z_tau")
d_ibc_pp <- aTSA::pp.test(d_ibcbr, type = "Z_tau")
d_ipca_pp <- aTSA::pp.test(d_ipca, type = "Z_tau")
d_selic_pp <- aTSA::pp.test(d_selic, type = 'Z_tau')

#### save data ####

diff_data <- data.frame(d_isv, d_isl, d_ibcbr, d_ipca, d_selic)
write.csv(diff_data, file = "diff_data.csv")
write.csv(df, file = 'data.csv')

save.image(file = 'stacionarity_test.Rdata')
