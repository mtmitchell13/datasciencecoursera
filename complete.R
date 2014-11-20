complete <- function(directory, id = 1:332) {
        files_list <- list.files("specdata", full.names=TRUE)
        nobs <- data.frame()
        for (i in id) {
                nobs <- rbind(nobs, sum(complete.cases(read.csv(files_list[i]))))
        }
        colnames(nobs) <- c("nobs")
        data.frame(cbind(id, nobs))
}