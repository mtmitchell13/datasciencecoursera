rankall <- function(outcome, num = "best") {
        ##Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ##Check that outcome is valid
        if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
                stop("invalid outcome")
        }
        
        ##Set column based on outcome selection
        mort_col <- if (outcome == "heart attack") {
                11
        } else if (outcome == "heart failure") {
                17
        } else if (outcome == "pneumonia") {
                23
        }
        
        #For each state, find the hospital of the given rank
        rank_sort <- data[order(data[, 7], as.numeric(data[, mort_col]), data[, 2], na.last=NA), ]
        state_data <- split(rank_sort, rank_sort$State)
        
        ##Return hospital name in that state with the given rank 
        ##30-day death rate
        if (num == "best") {
                prep <- lapply(state_data, function(y) y[1, ])
        } else if (num == "worst") {
                prep <- lapply(state_data, function(y) y[nrow(y), ])
        } else if (is.numeric(num)) {
                prep <- lapply(state_data, function(y) y[num, ])
        } else {
                stop("invalid num")
        }
        result <- as.data.frame(do.call(rbind, prep))
        final <- result[, c(2, 7)]
        colnames(final) <- c("hospital", "state")
        final
}