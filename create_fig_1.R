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
t_ps <- dplyr::select(t_all, condition, skill, luck, potion, t, p_start_1, p_start_2, p_start_3)
t_ts <- t_ps %>% dplyr::rowwise() %>% 
  dplyr::mutate(p_win = max(p_start_1, p_start_2, p_start_3))
t_ts$p_start_1 <- NULL
t_ts$p_start_2 <- NULL
t_ts$p_start_3 <- NULL
t <- dplyr::summarise(
  dplyr::group_by(t_ts, condition, skill, luck, potion),
  mean_p_win = mean(p_win)
)

p <- ggplot2::ggplot(
  t, 
  ggplot2::aes(x = condition, y = skill, fill = mean_p_win)) +
  ggplot2::geom_tile() + 
  ggplot2::scale_fill_gradientn(
    colors = c("red", "yellow", "green"), values = c(0.0, 0.5, 1.0)
  ) +
  ggplot2::facet_grid(luck ~ potion) +
  ggplot2::labs(
    title = "Chance to win the game"
  )

p
ggplot2::ggsave(filename = target_filename, plot = p, width = 7, height = 7)