# Data curation
# Allison Horst
# 10/26/2019

# Get costume_candy data:
costume_candy <- read_csv("costume_candy.csv")

# Wrangle to tidy by costume rank for each state
costumes <- costume_candy %>%
  select(state, region_us_census, costume_rank1:costume_rank5) %>%
  pivot_longer(costume_rank1:costume_rank5, names_to = "rank", values_to = "costume") %>%
  mutate(
    rank = case_when(
      rank == "costume_rank1" ~ "first",
      rank == "costume_rank2" ~ "second",
      rank == "costume_rank3" ~ "third",
      rank == "costume_rank4" ~ "fourth",
      rank == "costume_rank5" ~ "fifth"
    )
  ) %>%
  filter(rank %in% c("first", "second", "third"))

candy <- costume_candy %>%
  select(state, candy_rank1:pounds_3) %>%
  pivot_longer(c(candy_rank1, candy_rank2, candy_rank3), names_to = "rank", values_to = "candy") %>%
  select(-pounds_1, -pounds_2, -pounds_3) %>%
  mutate(
    rank = case_when(
      rank == "candy_rank1" ~ "first",
      rank == "candy_rank2" ~ "second",
      rank == "candy_rank3" ~ "third"
    )
  )

candy_pounds <- costume_candy %>%
  select(state, candy_rank1:pounds_3) %>%
  pivot_longer(c(pounds_1, pounds_2, pounds_3), names_to = "rank", values_to = "pounds_candy_sold") %>%
  select(-candy_rank1, -candy_rank2, -candy_rank3, -rank, -state)

candy_df <- data.frame(candy, candy_pounds)
spooky_data <- full_join(costumes, candy_df)

write_csv(spooky_data, "spooky_data.csv")
