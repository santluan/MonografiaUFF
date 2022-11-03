# Gráficos FIR

library(ggplot2)
library(magrittr)
library(patchwork)

setwd('D:\\Desktop\\DataScience\\Python\\monografia')

df_isv <- read.csv('irf_isv.csv')
df_isl <- read.csv('irf_isl.csv')

# VADER
isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.isv, ymax = up.isv), fill = 'gray65') +
  geom_line(aes(y = irf.isv), size = .7) +
  geom_point(aes(y = irf.isv), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'Índice de Sentimentos VADER') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

ipca_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ipca, ymax = up.ipca), fill = 'gray65') +
  geom_line(aes(y = irf.ipca), size = .7) +
  geom_point(aes(y = irf.ipca), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'IPCA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))
  
hiato_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.hiato, ymax = up.hiato), fill = 'gray65') +
  geom_line(aes(y = irf.hiato), size = .7) +
  geom_point(aes(y = irf.hiato), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'Hiato do Produto') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

selic_isv <- df_isv %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.d_selic, ymax = up.d_selic), fill = 'gray65') +
  geom_line(aes(y = irf.d_selic), size = .7) +
  geom_point(aes(y = irf.d_selic), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'SELIC') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

# LM-SA
isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.isl, ymax = up.isl), fill = 'gray65') +
  geom_line(aes(y = irf.isl), size = .7) +
  geom_point(aes(y = irf.isl), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'Índice de Sentimentos LM-SA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

ipca_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.ipca, ymax = up.ipca), fill = 'gray65') +
  geom_line(aes(y = irf.ipca), size = .7) +
  geom_point(aes(y = irf.ipca), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'IPCA') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

hiato_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.hiato, ymax = up.hiato), fill = 'gray65') +
  geom_line(aes(y = irf.hiato), size = .7) +
  geom_point(aes(y = irf.hiato), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'Hiato do Produto') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

selic_isl <- df_isl %>%
  ggplot(aes(x = (X-1))) +
  geom_ribbon(aes(ymin = lw.d_selic, ymax = up.d_selic), fill = 'gray65') +
  geom_line(aes(y = irf.d_selic), size = .7) +
  geom_point(aes(y = irf.d_selic), shape = 20) + 
  geom_hline(yintercept = 0, size = 0.3) +
  scale_x_continuous(name = "Períodos", limits = c(0, 12.1), expand = c(0, 0), breaks = c(0, 12)) +
  labs(y = 'Percentual', title = 'Selic') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, size = 12))

# save image
layout <- "
AB
CD
"

isv + hiato_isv + ipca_isv + selic_isv + plot_layout(design = layout)
ggsave("plot_irf_isv.pdf", width = 300, height = 300, units = "mm")

isl + hiato_isl + ipca_isl + selic_isl + plot_layout(design = layout)
ggsave("plot_irf_isl.pdf", width = 300, height = 300, units = "mm")

save.image('plots_irf.Rdata')
