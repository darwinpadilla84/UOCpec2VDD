library(tidyverse)
library(magrittr)
library(readr)
library(ggplot2)
library(foreign)
library(haven)
library(readxl)
library(openxlsx)

# dir.create("Data")
# dir.create("Script")
# dir.create("Documentacion")
# dir.create("Resultados")

#Fuente: https://www.ant.gob.ec/?page_id=2670#

rm(list = ls())

df21 <- read.xlsx("./Data/12.-REPORTES-NACIONALES-DICIEMBRE-2021.xlsx",sheet = "BDD ENE - DIC 2021 SM")
df21$HORA <- as.numeric(df21$HORA)
df21$`LATITUD.(Y)` <- as.numeric(df21$`LATITUD.(Y)`)
df21$`LONGITUD.(X)` <- as.numeric(df21$`LONGITUD.(X)`)
df21$EDAD <- as.numeric(df21$EDAD)
df22 <- read.xlsx("./Data/02.-REPORTES-NACIONALES-FEBRERO-2022.xlsx",sheet = "BDD ENE - FEB 2022 SM")
df <- bind_rows(df21,df22)
rm(df21,df22)

#Limpieza de latitud y longitud atípicas
omitir <-  which(is.na(df$`LATITUD.(Y)`)==TRUE)
omitir2 <- which(df$`LATITUD.(Y)`<=-6)
omitir3 <- which(df$`LONGITUD.(X)`<= (-100))
a <- c(omitir,omitir2,omitir3)

df <- df[-a,]
rm(a,omitir,omitir2,omitir3)

save(df,file = "./Data/Siniestros.RData")
load("./Data/Siniestros.RData")
#summary(df$`LONGITUD.(X)`)
