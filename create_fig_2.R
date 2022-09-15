args <- commandArgs(trailingOnly = TRUE)

if (1 == 2) {
  args <- c("test_data.csv", "test_fig_1.png")
}

testthat::expect_equal(2, length(args))

csv_filename <- args[1]
testthat::expect_true(file.exists(csv_filename))
target_filename <- args[2]

library(dplyr)

t_all <- readr::read_csv(csv_filename)
head(t_all)
names(t_all)
t_ts <- dplyr::select(t_all, condition, skill, luck, potion, t, p_clock_street, p_key_street, p_market_street)
t_means <- dplyr::summarise(
  dplyr::group_by(t_ts, condition, skill, luck, potion),
  mean_p_clock_street = mean(p_clock_street),
  mean_p_key_street = mean(p_key_street),
  mean_p_market_street = mean(p_market_street)
)
t_bests <- t_means %>% dplyr::rowwise() %>% 
  dplyr::mutate(
    p_best = max(mean_p_clock_street, mean_p_key_street, mean_p_market_street))
t_bests$winner <- ""
t_bests$winner[t_bests$p_best == t_bests$mean_p_clock_street] <- "clock"
t_bests$winner[t_bests$p_best == t_bests$mean_p_key_street] <- "key"
t_bests$winner[t_bests$p_best == t_bests$mean_p_market_street] <- "market"

p <- ggplot2::ggplot(
  t_bests, 
  ggplot2::aes(x = condition, y = skill, fill = winner)) +
  ggplot2::geom_tile() + 
  ggplot2::facet_grid(luck ~ potion) +
  ggplot2::labs(
    title = "Best choice at the first junction"
  )

p
ggplot2::ggsave(filename = target_filename, plot = p, width = 7, height = 7)