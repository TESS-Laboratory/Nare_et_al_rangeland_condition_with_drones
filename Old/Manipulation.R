#### Data manipulation
library(tidyverse)
# Load the air quality data
data("airquality")
head(airquality)
?airquality

ggplot(data=airquality, aes(x=Ozone))+
  geom_histogram()

# convert wide data to long data format
?pivot_longer
airquality_long <- pivot_longer(
  data= airquality,
  cols = c(Ozone, Solar.R, Wind, Temp),
  names_to = "env_factors",
  values_to = "contribution"
)
head(airquality_long)
ggplot(data= airquality_long, aes(x=env_factors, y=contribution))+
  geom_col()

###From wide to long
head(airquality_long)
airquality_wide <- pivot_wider(data= airquality_long,
             names_from = env_factors,
             values_from = contribution
             )
head(airquality_wide)

#####Unite and separate functions

df <- data.frame(
  first_name = c("Alan", "Dumezweni", "Nare"),
  last_name = c("Joestina", "Masuku", "Kabo"),
  height = c(185, 160, 60),
  weight = c(72, 60, 14)
)
df

unite(
  data = df,
  col = full_name,
  c(first_name, last_name),
  sep = " ",
  remove = TRUE,
)

df_united <- unite(
  data = df,
  col = full_name,
  c(first_name, last_name),
  sep = " ",
  remove = TRUE,
)

###### Separate columns
df <- data.frame(
  full_name = c("Alan Nare", "Joestina Masuku", "Kabo Nare"),
  height = c(185, 160, 60),
  weight = c(72, 60, 14)
)
df


separate(
  data = df,
  col = full_name,
  into = c("first_name","last_name"),
  sep = " ",
  remove = TRUE,
)

df_seperate <- separate(
  data = df,
  col = full_name,
  into = c("first_name","last_name"),
  sep = " ",
  remove = FALSE,
)
df_seperate







########################DPLYR ##########
install.packages("wooldridge")
library(wooldridge)
data(wage1)
wage1 %>% head()
##Select columns

wage1 %>% 
  select(!wage, educ, exper, tenure, lwage, expersq,tenursq) %>% 
  head()

wage1 %>% 
  select(wage:tenure,lwage:tenursq) %>% 
  head()

wage1 %>% 
  select(last_col()) %>% 
  head()

wage1 %>% 
  select(ends_with("sq")) %>% 
  head()

wage1 %>% 
  select(contains("sq")) %>% 
  head()



######## FILTER

wage1 %>% 
  select(wage:tenure, female) %>% 
  filter(female==1) %>% 
  head()

wage1 %>% 
  filter(female == 1) %>% 
  head()

wage1 %>% 
  filter(female==1 & married==1) %>% 
  head()


filter(data, ...)




mutate(data, ...)
transmute(data, ...)
arrange(data, ...)
group_by(data, ...)
summarise(data, ...)
