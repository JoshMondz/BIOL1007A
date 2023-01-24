#### ggplot2
#### 24 January 2023
#### JJM

library(ggplot2)
library(ggthemes)
library(patchwork)

#### Template for ggplot code
### p1 <- ggplot(data = <DATA>, mapping = aes(x = <x>, y = <y>)) + 
### <GEOM FUNCTION>
### print(p1)

#### Load in a built in data set
d <- mpg
str(mpg)

library(dplyr)
glimpse(d)

#### qplot: quick plotting

## Histogram
qplot(x = d$hwy)

qplot(x = d$hwy, fill = I("darkblue"), color = I("black")) #Need the I function for some reason

## Scatterplot
qplot(x = d$displ, y = d$hwy, geom = c("smooth", "point"), method = "lm")

## Box Plot
qplot(x = d$fl, y = d$cty, geom = "boxplot", fill = I("forestgreen"))

## Bar Plot
qplot(x = d$fl, geom = "bar", fill = I("forestgreen"))

### Create some data with specified counts
x_trt <- c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)
qplot(x = x_trt, y = y_resp, geom = "col", fill = I(c("forestgreen", "slategrey", "goldenrod")))


##### ggplot: uses dataframes instead of vectors

p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty, color = cyl)) + 
  geom_point()

p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_minimal()
p1 + theme_solarized()

p1 + theme_bw(base_size=30, base_family = "serif")

p2 <- ggplot(data = d, aes(x = fl, fill = fl)) + 
  geom_bar()
p2 + coord_flip() + theme_classic(base_size = 15, base_family = "sans")

# Theme modifications
p3 <- ggplot(data = d, aes(x=displ, y = cty)) +
  geom_point(size = 7, shape = 21, color = "magenta", fill = "black") +
  xlab("Count") +
  ylab("Fuel") +
  labs(title = "My title here", subtitle = "my subtitle here")

p3 + xlim(1,10) + ylim(0,35)
library(viridis)
cols <- viridis(7, option = "magma")
ggplot(d, aes(x = class, y = hwy, fill=class)) + 
  geom_boxplot() +
  scale_fill_manual(values = cols)

p1 + p2 / p3
