getData <- function(port) {
  #
  # receive data from serial port and print it
  con <- serial::serialConnection(name = "testcon", port = port,
                          mode = "115200,n,8,1", newline = 1, translation = "crlf"
  )

  # let's open the serial interface

  open(con)

  # Sys.sleep(1)

  # write some stuff
  # serial::write.serialConnection(con,"Hello World!")

  # read, in case something came in
  n = 0
  while (TRUE) {
    inQ <- serial::nBytesInQueue(con)
    nInQ <- inQ["n_in"]
    # nOutQ <- inQ["n_out"]
    if(nInQ > 32) {
      # print(inQ)
      a <- serial::read.serialConnection(con)
      print(a)
      n <- n + 1
      if (n > 100) {
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
