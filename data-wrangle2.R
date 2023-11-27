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
NHL_Win <- read_csv("data/nhl-win.csv")
NBA_Value <- read_csv("data/nba-value.csv")
NBA_Payroll <- read_csv("data/nba-payroll.csv")
NBA_Win <- read_csv("data/nba-win.csv")


###############
# wrangle data #
###############

#NFL
nfl_val_wrangle <- NFL_Value |>
  mutate(team = Name, value = Value * 1000000000, league = "NFL") |>
  select(team, value, league)

nfl_payroll_wrangle <- NFL_Payroll |>
  mutate(team = Name, payroll = `2023 Payroll`) |>
  select(team, payroll)

nfl_win_wrangle <- NFL_Win |>
  mutate(team = Name, win_percentage = `Win %`) |>
  select(-`Win %`, -Name)


#MLB
mlb_val_wrangle <- MLB_Value |>
  mutate(team = Name, value = Value * 1000000, league = "MLB") |>
  select(team, value, league)

mlb_payroll_wrangle <- MLB_Payroll |>
  mutate(team = Name, payroll = `2023 Payroll`) |>
  select(team, payroll)

mlb_win_wrangle <- MLB_Win |>
  mutate(team = Name, win_percentage = `Win Percentage`) |>
  select(team, win_percentage)


#NHL
nhl_val_wrangle <- NHL_Value |>
  mutate(team = Name, value = Value * 1000000, league = "NHL") |>
  select(team, value, league)

nhl_payroll_wrangle <- NHL_Payroll |>
  mutate(team = Name, payroll = `2022-23 Payroll`) |>
  select(team, payroll)

nhl_win_wrangle <- NHL_Win |>
  mutate(team = Team, win_percentage = round(PTS / (2*GP), 3)) |>
  select(team, win_percentage)


#NBA
nba_val_wrangle <- NBA_Value |>
  mutate(team = Name, value = Value * 1000000000, league = "NBA") |>
  select(team, value, league)

nba_payroll_wrangle <- NBA_Payroll |>
  mutate(team = Name, payroll = `2023 Payroll` * 10000) |>
  select(team, payroll)

nba_win_wrangle <- NBA_Win |>
  mutate(team = Name, win_percentage = `WIN%`) |>
  select(team, win_percentage)


# Merge NFL datasets
nfl_combined <- nfl_val_wrangle %>%
  left_join(nfl_payroll_wrangle, by = "team") %>%
  left_join(nfl_win_wrangle, by = "team")

# Merge MLB datasets
mlb_combined <- mlb_val_wrangle %>%
  left_join(mlb_payroll_wrangle, by = "team") %>%
  left_join(mlb_win_wrangle, by = "team")

# Merge NHL datasets
nhl_combined <- nhl_val_wrangle %>%
  left_join(nhl_payroll_wrangle, by = "team") %>%
  left_join(nhl_win_wrangle, by = "team")

# Merge NBA datasets
nba_combined <- nba_val_wrangle %>%
  left_join(nba_payroll_wrangle, by = "team") %>%
  left_join(nba_win_wrangle, by = "team")

# Combine all leagues into one dataset
all_teams_combined <- bind_rows(nfl_combined, mlb_combined, nhl_combined, nba_combined)



