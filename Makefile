all: test_data.csv

test_data.csv:
	Rscript create_test_data.R
