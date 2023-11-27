library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)
library(ggrepel)
library(ggplot2)
library(scales)

###############
# import data #
###############

NFL_Value <- read_csv("data/nfl-value.csv")
NFL_Payroll <- read_csv("data/nfl-payroll.csv")
NFL_Win <- read_csv("data/nfl-win.csv")
MLB_Value <- read_csv("data/mlb-value.csv")
MLB_Payroll <- read_csv("data/mlb-payroll.csv")
MLB_Win <- read_csv("data/mlb-win.csv")
NHL_Value <- read_csv("data/nhl-value.csv")
NHL_Payroll <- read_csv("data/nhl-payroll.csv")
NBA_Value <- read_csv("data/nba-value.csv")
NBA_Payroll <- read_csv("data/nba-payroll.csv")
NBA_Win <- read_csv("data/nba-win.csv")


###############
# wrangle data #
###############

nhl_value_wrangle <- NHL_Value |>
  mutate(Value = paste0(dollar(`Value`), "M"))

nhl_payroll_wrangle <- NHL_Payroll |>
  mutate(`2023 Payroll` = paste0(dollar(`2023 Payroll` * .000001), "M"))

nba_value_wrangle <- NBA_Value |>
  mutate(Value = paste0(dollar(`Value` * 1000), "M"))

nba_payroll_wrangle <- NBA_Payroll

nfl_payroll_wrangle <- NFL_Payroll |>
  mutate(`2023 Payroll` = paste0(dollar(`2023 Payroll` * .000001), "M"))

nfl_value_wrangle <- NFL_Value |>
  mutate(Value = paste0(dollar(`Value` * 1000), "M"))

mlb_value_wrangle <- MLB_Value |>
  mutate(Value = paste0(dollar(`Value`), "M"))

mlb_payroll_wrangle <- MLB_Payroll |>
  mutate(`2023 Payroll` = paste0(dollar(`2023 Payroll` * .000001), "M"))

