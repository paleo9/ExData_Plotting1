# plot Global Active Power

source("getData.R") # returns a table for the two days of interest

# plot Global Active Power
plot2 <- function(){
  table <- getData() # returns a table for the two days of interest
  plot(table[[3]],
    ylab ="Global Active Power (kilowatts)",
    xlab="",
    type="l",
    axes=FALSE
  )
  
  axis(1, at=c(0, 1500, 2800), labels= c("Thu", "Fri", "Sat"))
  axis(2, at=c(0,2,4,6))
  box()
}

# create png file
png(file="plot2.png")
plot2()
dev.off()  