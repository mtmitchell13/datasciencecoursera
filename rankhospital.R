rankhospital <- function(state, outcome, num = "best") {
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
        
        #Subset and sort state data
        state_data <-  subset(data, data[, 7]==state)
        sorted_state <- state_data[order(as.numeric(state_data[, mort_col]), 
                                         state_data[, 2], na.last=NA), ]
        
        ##Return hospital name in that state with the given rank 
        ##30-day death rate
        if (num == "best") {
                sorted_state$Hospital.Name[1]
        } else if (num == "worst") {
                sorted_state$Hospital.Name[nrow(sorted_state)]
        } else if (is.numeric(num)) {
                sorted_state$Hospital.Name[num]
        } else {
                stop("invalid num")
        }
}