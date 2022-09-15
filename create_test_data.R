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
  t$p_key_street <- runif(n = nrow(t), min = 0.5, max = 0.6)
  t$p_market_street <- runif(n = nrow(t), min = 0.4, max = 0.7)
  t$p_correct_final_choice <- 1.0
  t$p_wrong_final_choice_1 <- runif(n = nrow(t), min = exp(-t$t), max = 0.1)
  t$p_wrong_final_choice_2 <- runif(n = nrow(t), min = exp(-t$t), max = 0.1)
  
  # advantage
  advantage <- 0
  # A luck potion gives an advantage
  if (t$potion[1] == "luck") advantage <- advantage + 0.1
  # Having high skill does give an advantage
  advantage <- advantage + ((t$skill[1] - 7) * 0.1)
  
  t$p_start_1 <- t$p_start_1 + advantage
  t$p_start_2 <- t$p_start_2 + advantage
  t$p_start_3 <- t$p_start_3 + advantage
  t$p_clock_street <- t$p_clock_street + advantage
  t$p_key_street <- t$p_key_street + advantage
  t$p_market_street <- t$p_market_street + advantage

  payoffs_list[[i]] <- t
}

payoffs <- dplyr::bind_rows(payoffs_list)
readr::write_csv(payoffs, "test_data.csv")