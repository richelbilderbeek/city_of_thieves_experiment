initial_characters <- tidyr::expand_grid(
  condition = seq(2, 12),
  skill = seq(4, 9),
  luck = seq(7, 12),
  potion = c("condition", "skill", "luck")
)
n_characters <- nrow(initial_characters)

payoffs_list <- list()

for (i in seq_len(n_characters)) {
  t <- initial_characters[i, ]
  time_end <- round(10 ^ runif(n = 1, min = 2, max = 5))
  time_start <- round(0.9 * time_end)
  t <- merge(t, tibble::tibble(t = seq(from = time_start, to = time_end)))
  t$p_start_1 <- runif(n = nrow(t), min = 0.5, max = 0.7)
  t$p_start_2 <- runif(n = nrow(t), min = 0.4, max = 0.6)
  t$p_start_3 <- runif(n = nrow(t), min = 0.3, max = 0.5)
  t$p_clock_street <- runif(n = nrow(t), min = 0.5, max = 0.7)
  t$p_key_street <- runif(n = nrow(t), min = 0.4, max = 0.6)
  t$p_market_street <- runif(n = nrow(t), min = 0.3, max = 0.5)
  t$p_wrong_final_choice_1 <- runif(n = nrow(t), min = exp(-t$t), max = 0.1)
  t$p_wrong_final_choice_2 <- runif(n = nrow(t), min = exp(-t$t), max = 0.1)
  
  payoffs_list[[i]] <- t
}

payoffs <- dplyr::bind_rows(payoffs_list)
readr::write_csv(payoffs, "test_data.csv")