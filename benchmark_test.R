# A script to produce a single value (in milliseconds) from benchmarking
# Rick Scavetta,
# Adapted from https://statistik-dresden.de/archives/16275
# 2.11.2020

message("Working, please wait ...")

# Install (if necessary) and load packages
if (!require("microbenchmark")) {install.packages("microbenchmark")}
library(microbenchmark)
library(tidyverse)
options(dplyr.summarise.inform = FALSE)


# Parameters
N <- 1e7
K <- 100

# Data set
set.seed(136)
bench_data <- data.frame(
 id1 = sample(sprintf("id%03d", 1:K), N, TRUE), # large groups (char)
 id5 = sample(N / K, N, TRUE), # small groups (int)
 v1 = sample(5, N, TRUE), # int in range [1,5]
 v2 = sample(5, N, TRUE), # int in range [1,5]
 v3 = sample(round(runif(100, max = 100), 4), N, TRUE) # numeric, e. g. 23.5749
)

# Benchmarking
bench_output <- microbenchmark(
 {bench_data %>%
   group_by(id1) %>%
   summarise(sum(v1)) %>%
   as_tibble()},
 times = 10
)

# print result
message("Please enter the following value in the Google Form:")
message(mean(bench_output$time)/10^6)
