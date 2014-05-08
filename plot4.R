## display four images in 2 x 2 format

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

table <- getData()

### plot Global Active Power
plot4a <- function(){
  plot(table[[3]],
    ylab = "Global Active Power (kilowatts)",
    xlab="",
    type="l",
    axes=FALSE
  )
  
  axis(1, at=c(0, 1500, 2800), labels=c("Thu", "Fri", "Sat"))
  axis(2, at=c(0,2,4,6))
  box()
}

### plot voltage
plot4b <- function(){
  plot(table$Voltage, type="l",  xlab='date/time', ylab="Voltage", axes=FALSE)
  axis(1, at=c(0, 1500, 2800), labels=c("Thu", "Fri", "Sat"))
  axis(2, at=c(234,238,242,246))
  box()
}

### plot energy sub metering
# identical to plot 3 except no box around legend
plot4c <- function(){
  with(table, {
    plot(Sub_metering_1, xlab='', ylab='Energy sub metering', axes=FALSE, type="l", col = 'black')
    par(new=TRUE)
    plot(Sub_metering_2, xlab='', ylab = '', axes=FALSE, type="l", col = 'red', ylim=c(0,40))
    par(new=TRUE)
    plot(Sub_metering_3, xlab='', ylab = '',axes=FALSE, type="l",  col = 'blue', ylim=c(0,40))
    
    legend("topright", 
      lty=c(1,1,1),
      lwd=c(2,2,2),
      box.lwd=0, # no box
      col=c("black", "red", "blue"), 
      legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  })
  axis(1, at=c(0, 1500, 2800), labels=c("Thu", "Fri", "Sat"))
  axis(2, at=c(0,10,20,30), labels=c('0','10','20','30'))
  box()
}

### plot Global reactive power
# note: reference plot has underscores in the y-axis label
plot4d <- function(){
    plot(table$Global_reactive_power, 
      type="l",  
      xlab='date/time', 
      ylab="Global_reactive_power",
      axes=FALSE)
    axis(1, at=c(0, 1500, 2800), labels=c("Thu", "Fri", "Sat"))
    axis(2, at=c(0,0.1,0.2,0.3,0.4,0.5))
    box()
}

### display the four images in 2 x 2 format
# note: only reference images 3 and 4 have 'date/time' as their x-axis label
plot4 <- function(){
  par(mfrow=c(2,2))
  plot4a()  # Global active power
  plot4b()  # Voltage
  plot4c()  # Energy sub metering
  plot4d()  # Global reactive Power
}

### create png file
png(file="plot4.png")
plot4()
dev.off()  