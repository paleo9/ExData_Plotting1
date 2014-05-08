## plot sub metering 1-3, with legend

### cache the file data
# returns a table for the two days of interest
getData <- function(){
  original.filename <- "household_power_consumption.txt"
  cache.filename <- "household_power_consumption_01-02-feb-2007.txt"
  
  if (!file.exists(cache.filename)){ # create the cache
    # read rows for 2007-02-01 and 2007-02-02
    df <- read.csv(original.filename, sep=";", skip=66636, nrow=69516-66636)
    
    # we lose the names, so get them back by reading one row and passing them on
    df.with.names <- read.csv(original.filename, sep=";", nrow=1)
    names(df) <- names(df.with.names)
    write.table(df, cache.filename, sep=";")
  } else { # otherwise read the cached data
    df <- read.table(cache.filename, sep=";")
  }
  df
}

### plot sub metering 1-3, with legend
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

### create png file
png(file="plot3.png")
plot3()
dev.off()  