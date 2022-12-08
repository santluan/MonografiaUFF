# Gráficos para Função Resposta Impulso
# Luan Santos
# 25-11-2022

library(ggplot2)
library(magrittr)
library(patchwork)

setwd('D:\\Desktop\\DataScience\\Python\\monografia\\')

df_isv <- read.csv('data\\irf_isv.csv')
df_isl <- read.csv('data\\irf_isl.csv')

# VADER ####

ipca_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ipca, ymax = up.ipca), fill = 'gray65') +
  geom_line(aes(y = irf.ipca), size = .7) +
  geom_point(aes(y = irf.ipca), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'IPCA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))
  
hiato_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.hiato, ymax = up.hiato), fill = 'gray65') +
  geom_line(aes(y = irf.hiato), size = .7) +
  geom_point(aes(y = irf.hiato), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'Hiato do Produto') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

selic_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.d_selic, ymax = up.d_selic), fill = 'gray65') +
  geom_line(aes(y = irf.d_selic), size = .7) +
  geom_point(aes(y = irf.d_selic), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'SELIC') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

ibov_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ibov, ymax = up.ibov), fill = 'gray65') +
  geom_line(aes(y = irf.ibov), size = .7) +
  geom_point(aes(y = irf.ibov), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'IBOVESPA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

# LM-SA ####

ipca_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ipca, ymax = up.ipca), fill = 'gray65') +
  geom_line(aes(y = irf.ipca), size = .7) +
  geom_point(aes(y = irf.ipca), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'IPCA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

hiato_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.hiato, ymax = up.hiato), fill = 'gray65') +
  geom_line(aes(y = irf.hiato), size = .7) +
  geom_point(aes(y = irf.hiato), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'Hiato do Produto') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

selic_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.d_selic, ymax = up.d_selic), fill = 'gray65') +
  geom_line(aes(y = irf.d_selic), size = .7) +
  geom_point(aes(y = irf.d_selic), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'Selic') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

ibov_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ibov, ymax = up.ibov), fill = 'gray65') +
  geom_line(aes(y = irf.ibov), size = .7) +
  geom_point(aes(y = irf.ibov), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0)) +
  labs(y = 'Percentual', title = 'IBOVESPA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

# save image
layout <- "
AB
CD
"

hiato_isv + ipca_isv + selic_isv + ibov_isv + plot_layout(design = layout)
ggsave("figs\\irf_isv.pdf", width = 300, height = 300, units = "mm")

hiato_isl + ipca_isl + selic_isl+ ibov_isl + plot_layout(design = layout)
ggsave("figs\\irf_isl.pdf", width = 300, height = 300, units = "mm")

save.image('plots_irf.Rdata')
#load('plots_irf.Rdata')
