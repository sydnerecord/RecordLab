### Perform multiple linear regression

# Load corrplot Library
library(corrplot)

# Read in data on sulphur dioxide (British spelling)
so2 <- read.csv('/users/PUOM0017/srecord/ExampleData/sulphur_dioxide.csv')

# Check first five lines to get to know data
head(so2)

# Create a scatterplot matrix and export it as a tif
# Open device
tiff("/users/PUOM0017/srecord/ExampleData/my_plot", compression = "zip")

# Make a plot
corrplot(as.matrix(so2), is.corr = FALSE, method = "square")

# Close device
dev.off()

# fit a multiple regression model
mod1 <- lm(Pollution ~ Temp*Industry*Wind*Rain, data=so2) 

# Get model summary
summary(aov(mod1))
