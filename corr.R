corr <- function(directory, threshold = 0) {
        getdata <- function(directory, id) {
                files_list <- list.files("specdata", full.names=TRUE)
                data <- read.csv(files_list[id])
        }
                
        completes <- complete(directory)
        thrshnobs <- completes[completes$nobs > threshold, ]
        result <- c()
        for (i in thrshnobs$id) {
                data <- getdata("specdata", i)
                result <- c(result, cor(data$nitrate, data$sulfate, use="complete.obs"))        
        }
        as.numeric(result)
}