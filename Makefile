all: test_fig_1.png test_fig_2.png

test_fig_1.png: test_data.csv
	Rscript create_fig_1.R test_data.csv test_fig_1.png

test_fig_2.png: test_data.csv
	Rscript create_fig_2.R test_data.csv test_fig_2.png

test_data.csv:
	Rscript create_test_data.R
