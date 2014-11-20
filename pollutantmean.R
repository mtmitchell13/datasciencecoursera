pollutantmean <- function(directory, pollutant = c("sulfate", "nitrate"), id = 1:332) {
        files_list <- list.files("specdata", full.names=TRUE)
        fulldata <- data.frame()
        for (i in id) {
                fulldata <- rbind(fulldata, read.csv(files_list[i]))                
        }
        id_sel <- fulldata[which(fulldata$ID %in% id), ]
        mean(id_sel[, pollutant], na.rm=TRUE)
}