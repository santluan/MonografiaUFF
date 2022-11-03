# Estimando o modelo VAR e Função de Resposta Impulso para os dados

setwd('D:\\Desktop\\DataScience\\Python\\monografia\\')

require(urca)
require(vars)
require(aTSA)
require(mFilter)

# lendo os dados

df <- read.csv('data.csv', row.names = 1)
diff <- read.csv('diff_data.csv', row.names = 1)  

ibcbr_hp <- hpfilter(df$ibcbr, freq=14440)

df1 <- data.frame(isv = df$ISV[2:132],
                  ipca = df$ipca[2:132],
                  hiato = ibcbr_hp$cycle[2:132],
                  d_selic = diff$d_selic)

df2 <- data.frame(isl = df$ISL[2:132],
                  ipca = df$ipca[2:132],
                  hiato = ibcbr_hp$cycle[2:132],
                  d_selic = diff$d_selic)

# VAR 1 ####
# com ISV

VARselect(df1)

model1 <- VAR(df1, p = 3, type = 'both')

FIR1 <- irf(model1,
            impulse = 'isv',
            n.ahead = 12,
            boot = T)

plot(FIR1)

# VAR 2 ####
# com ISL

VARselect(df2)

model2 <- VAR(df2, p = 3, type = 'both')

FIR2 <- irf(model2,
            impulse = 'isl',
            n.ahead = 12,
            boot = T)

plot(FIR2)

# salvando dados

data1 <- data.frame(
  FIR1$irf,
  FIR1$Upper,
  FIR1$Lower
)

colnames(data1) <- c('irf.isv', 'irf.ipca', 'irf.hiato', 'irf.d_selic',
                     'up.isv', 'up.ipca', 'up.hiato', 'up.d_selic',
                     'lw.isv', 'lw.ipca', 'lw.hiato', 'lw.d_selic')

data2 <- data.frame(
  FIR2$irf,
  FIR2$Upper,
  FIR2$Lower
)

colnames(data2) <- c('irf.isl', 'irf.ipca', 'irf.hiato', 'irf.d_selic',
                     'up.isl', 'up.ipca', 'up.hiato', 'up.d_selic',
                     'lw.isl', 'lw.ipca', 'lw.hiato', 'lw.d_selic')

write.csv(data1, 'irf_isv.csv')
write.csv(data2, 'irf_isl.csv')

save.image('VARmodel.Rdata')
