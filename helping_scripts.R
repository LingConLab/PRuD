italize_and_separate <- function(string){
  string |> 
    str_split("\n") |> 
    unlist() |> 
    str_replace("^", "*") |> 
    str_replace("\\(", "* \\(") |> 
    str_c(collapse = "\n\n") |> 
    cat()
}

library(tidyverse)
readxl::read_xlsx("data/data.xlsx") |> 
  count(intonation_type, sort = TRUE) |> 
  filter(!is.na(intonation_type)) |> 
  writexl::write_xlsx("~/Desktop/intonation_type_problems.xlsx")

readxl::read_xlsx("data/data.xlsx") |> 
  count(transcription2, sort = TRUE) |> 
  filter(!is.na(transcription2)) |> 
  writexl::write_xlsx("~/Desktop/transcription2_problems.xlsx")
