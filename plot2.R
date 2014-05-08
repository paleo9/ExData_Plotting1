## plot Global Active Power

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

### plot Global Active Power
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

### create png file
png(file="plot2.png")
plot2()
dev.off()  