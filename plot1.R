source("getData.R")
plot1 <- function(){
  table <- getData() # returns a table for the two days of interest
  
  hist(table[[3]],
    main = "Global ActivePower",
    xlab = "Global Active Power (kilowatts)",
    col = 'red'
  )
}


# create png file
png(file="plot1.png")
plot1()
dev.off()  