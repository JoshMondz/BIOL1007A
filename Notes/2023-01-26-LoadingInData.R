##### Loading in Data
##### 26 January 2023
##### JJM


### Create and save a dataset
### write.table(x = varName, file = "outputFileName.csv", Header = T, sep = ",") 

### Read in data sets
### read.table(file = "<path/to/data.csv>", header = TRUE, sep = ",")
### read.csv(file = data.csv, header = T)

#### Use RDS object when only working in R
## saveRDS(my_data, file = "FileName.RDS")
## p <- readRDS("FileName.RDS")

### Long vs Wide Data formats
### wide format = contains values that do not repeat in the ID column
### long format = contains values that do repeat in the ID column

library(tidyverse)
head(billboard)
glimpse(billboard)
b1 <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"), #Specify which columns to make longer
    names_to = "Week", #name of new colimn which will contain the header name
    values_to = "Rank", #name of new column whuch contains value
    values_drop_na = TRUE
  )

### pivot_wider
### best for making occupancy matrix
glimpse(fish_encounters)

fish_encounters %>%
  pivot_wider(
    names_from = station, #which column to turn into multiple
    values_from = seen #which column contains the values for new columns
  )

fish_encounters %>%
  pivot_wider(
    names_from = station, #which column to turn into multiple
    values_from = seen, #which column contains the values for new columns
    values_fill = 0 # fills NAs with 0s
  )

##### Dryad: makes research data freely reusable, citable, and discoberable
#### datadryad.org/search

dryadData <- read.table(file = "Data/veysey-babbit_data_amphibians.csv", header = T, sep = ",")
glimpse(dryadData)
head(dryadData)

table(dryadData$species) # allows you to see different groups of character column
summary(dryadData$mean.hydro)

dryadData$species<-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating 'labels' to use for the plot

class(dryadData$treatment)

dryadData$treatment <- factor(dryadData$treatment, 
                              levels=c("Reference",
                                       "100m", "30m"))

class(dryadData$treatment)
p<- ggplot(data=dryadData, 
           aes(x=interaction(wetland, treatment), 
               y=count.total.adults, fill=factor(year))) + geom_bar(position="dodge", stat="identity", color="black") +
  ylab("Number of breeding adults") +
  xlab("") +
  scale_y_continuous(breaks = c(0,100,200,300,400,500)) +
  scale_x_discrete(labels=c("30 (Ref)", "124 (Ref)", "141 (Ref)", "25 (100m)","39 (100m)","55 (100m)","129 (100m)", "7 (30m)","19 (30m)","20 (30m)","59 (30m)")) +
  facet_wrap(~species, nrow=2, strip.position="right") +
  theme_few() + scale_fill_grey() + 
  theme(panel.background = element_rect(fill = 'gray94', color = 'black'), legend.position="top",  legend.title= element_blank(), axis.title.y = element_text(size=12, face="bold", colour = "black"), strip.text.y = element_text(size = 10, face="bold", colour = "black")) + 
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) 

p
