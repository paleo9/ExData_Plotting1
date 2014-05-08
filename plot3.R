# plot sub metering 1-3, with legend

source("getData.R") # returns a table for the two days of interest

# plot sub metering 1-3, with legend
# note: no x-axis label
plot3 <- function(){
  table <- getData() # returns a table for the two days of interest
  with(table, {
    plot(Sub_metering_1, xlab='', ylab='Energy sub metering', axes=FALSE, type="l", col = 'black')
    par(new=TRUE)
    plot(Sub_metering_2, xlab='', ylab = '', axes=FALSE, type="l", col = 'red', ylim=c(0,40))
    par(new=TRUE)
    plot(Sub_metering_3, xlab='', ylab = '',axes=FALSE, type="l",  col = 'blue', ylim=c(0,40))
    
    legend("topright", 
      lty=c(1,1,1),
      lwd=c(2,2,2),
      col=c("black", "red", "blue"), 
      legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  })
  axis(1, at=c(0, 1500, 2800), labels= c("Thu", "Fri", "Sat"))
  axis(2, at=c(0,10,20,30), labels=c('0','10','20','30'))
  box()
}

# create png file
png(file="plot3.png")
plot3()
dev.off()  