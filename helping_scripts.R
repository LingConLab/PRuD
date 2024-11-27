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

# detect missing files ----------------------------------------------------

library(tidyverse)

df <- readxl::read_xlsx("data/data.xlsx")

audio <- str_c(df$filename, ".wav")
images <- str_c(df$filename, ".png")

audio[!(audio %in% list.files("/home/agricolamz/work/databases/PRuD/audio"))] |> 
  tibble(missing = _) |> 
  mutate(type = "audio") |> 
  na.omit() ->
  missing

images[!(images %in% list.files("/home/agricolamz/work/databases/PRuD/images/"))] |> 
  tibble(missing = _) |> 
  mutate(type = "image") |> 
  na.omit() |> 
  filter(!str_detect(missing, "\\D00\\.")) |> 
  bind_rows(missing) |> 
  arrange(missing) 
  writexl::write_xlsx("~/Desktop/missing.xlsx")
