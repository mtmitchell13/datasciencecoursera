best <- function(state, outcome) {
        ##Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ##Check that state and outcome are valid
        if (!state %in% unique(data[, 7])) {
                stop("invalid state")
        }
        
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
        
        ##Subset state data
        state_data <-  subset(data, data[, 7]==state)
                
        ##Return hospital name in that state with lowest 30-day death rate
        min_table <- subset(state_data, as.numeric(state_data[, mort_col])
                            == min(as.numeric(state_data[, mort_col]), na.rm=TRUE))
        sort_result <- min_table[, 2]
        result <- sort_result[order(sort_result)]
        result[1]
}