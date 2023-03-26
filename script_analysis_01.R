# Packages ----------------------------------------------------------------
library(tidyverse)
library(readxl)
library(writexl)
library(lubridate)

# Importing ---------------------------------------------------------------
pwd <- getwd() # sets the current working directory
pwd

filepath <- paste(pwd, "/data-raw/1993-2023.csv", sep="") # Make sure you fix this separator, it's a space by default
filepath

data_import <- read_csv(filepath , skip = 4, col_names = T)
data_import %>% View


# Wrangling ---------------------------------------------------------------

data_import <- data_import %>% 
  mutate(
    ano = stringr::str_sub(Date,1,4),
    mes = stringr::str_sub(Date,5,6),
    celsius = (Value - 32)* 5/9
  ) %>% 
  rename(
    date = Date,
    fahrenheit = Value,
    anomaly = Anomaly
  )


# Visualization -----------------------------------------------------------

data_import %>% 
ggplot()+
  aes(x=ano, y=fahrenheit)+
  geom_line(aes(group=1))+
  geom_point()




# Export ------------------------------------------------------------------

writexl::write_xlsx(data_import, "dataframe.xlsx")
