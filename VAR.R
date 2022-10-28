# Estimando o modelo VAR para os dados

setwd('D:\\Desktop\\DataScience\\Python\\monografia\\')

require(urca)
require(vars)
require(aTSA)

# lendo os dados

df <- read.csv('data.csv', row.names = 1)
diff <- read.csv('diff_data.csv', row.names = 1)  

df1 <- data.frame(isv = df$ISV[2:132],
                  d_ibcbr = diff$d_ibcbr,
                  d_ipca = diff$d_ipca,
                  d_selic = diff$d_selic)

df2 <- data.frame(isl = df$ISL[2:132],
                  d_ibcbr = diff$d_ibcbr,
                  d_ipca = diff$d_ipca,
                  d_selic = diff$d_selic)

############### VAR #################

# com ISV

VARselect(df1)

model1 <- VAR(df1, p = 3, type = 'both')

FIR1 <- irf(model1,
            impulse = 'isv',
            n.ahead = 12,
            boot = T)
plot(FIR1)

# com ISL

VARselect(df2)

model2 <- VAR(df2, p = 3, type = 'both')

FIR2 <- irf(model2,
            impulse = 'isl',
            n.ahead = 12,
            boot = T)
plot(FIR2)

#### save data ####

data1 <- data.frame(
  FIR1$irf,
  FIR1$Upper,
  FIR1$Lower
)

colnames(data1) <- c('irf.isv', 'irf.d_ibcbr', 'irf.d_ipca', 'irf.d_selic',
                     'up.isv', 'up.d_ibcbr', 'up.d_ipca', 'up.d_selic',
                     'lw.isv', 'lw.d_ibcbr', 'lw.d_ipca', 'lw.d_selic')

data2 <- data.frame(
  FIR2$irf,
  FIR2$Upper,
  FIR2$Lower
)

colnames(data2) <- c('irf.isl', 'irf.d_ibcbr', 'irf.d_ipca', 'irf.d_selic',
                     'up.isl', 'up.d_ibcbr', 'up.d_ipca', 'up.d_selic',
                     'lw.isl', 'lw.d_ibcbr', 'lw.d_ipca', 'lw.d_selic')

write.csv(data1, 'irf_isv.csv')
write.csv(data2, 'irf_isl.csv')

save.image('VARmodel.Rdata')
