library(tidyverse)

getMillis <- function() {
  # function to get current time in milli seconds
  as.numeric(Sys.time())*1000
}

getMillisDiff <- function() {
  old <- getMillis()
  for (i in 1:1e8) {
    # do nothing
  }
  new <- getMillis()
  new - old
}

getData <- function(port) {
  #
  # receive data from serial port and print it
  con <- serial::serialConnection(name = "testcon", port = port,
                          mode = "115200,n,8,1", newline = 1, translation = "crlf"
  )

  # let's open the serial interface
  close(con)
  Sys.sleep(2)
  open(con)

  # Sys.sleep(1)

  # write some stuff
  # serial::write.serialConnection(con,"Hello World!")

  # read, in case something came in
  n = 0
  oldMillis <- getMillis()
  while (TRUE) {
    inQ <- serial::nBytesInQueue(con)
    nInQ <- inQ["n_in"]
    # nOutQ <- inQ["n_out"]
    if(nInQ > 32) {
      # print(inQ)
      a <- serial::read.serialConnection(con)
      a <- stringr::str_split_1(a, ",") %>% trimws() %>% as.numeric() %>% suppressWarnings()
      if (length(a) != 6) next
      newMillis <- getMillis()
      print(newMillis - oldMillis)
      print(a)
      n <- n + 1
      oldMillis <- newMillis
      if (n > 500) {
        break
      }
    }
  }

  # a <- serial::nBytesInQueue(con)["n_in"]
  # print(a)

  # show summary
  # summary(con)

  # close the connection
  close(con)

}
