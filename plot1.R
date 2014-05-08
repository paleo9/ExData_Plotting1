## plot histogram of frequency / Global ActivePower

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

### plot histogram of frequency / Global ActivePower
plot1 <- function(){
  table <- getData() # returns a table for the two days of interest
  
  hist(table[[3]],
    main = "Global ActivePower",
    xlab = "Global Active Power (kilowatts)",
    col = 'red'
  )
}

### create png file
png(file="plot1.png")
plot1()
dev.off()  