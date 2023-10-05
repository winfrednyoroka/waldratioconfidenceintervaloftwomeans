#' Wald Ratio Calculator With Confidence Intervals
#'
#' @param data A dataframe
#' @param mean_colA Mean of the variable as numerator
#' @param mean_colB Mean of the variable as denominator
#' @param se_colA  Standard error of the variable as numerator
#' @param se_colB Standard error of the variable as denominator
#' @param t t statistic for the desired confidence
#'
#' @return A dataframe with additional columns
#' @export
#'
#' @examples
CI_of_ratio_oftwo_means_droprows <- function(data, mean_colA, mean_colB, se_colA, se_colB, t) {
  n <- nrow(data) # Number of rows in the data frame

  # Initialize empty vectors to store calculated values
  waldratio <- numeric(n)
  lowerbound_waldratio <- numeric(n)
  upperbound_waldratio <- numeric(n)
  SEquotient <- numeric(n)


  i <- 1
  while (i <= n) {
    meanofgroupA <- data[[mean_colA]][i]
    meanofgroupB <- data[[mean_colB]][i]
    SEofgroupA <- data[[se_colA]][i]
    SEofgroupB <- data[[se_colB]][i]

    Q <- meanofgroupA / meanofgroupB
    print(paste("Index i:", i))

    g <- (t * (SEofgroupB / meanofgroupB))^2
    print(paste("g:", g))

    if (SEofgroupB < meanofgroupB) {
      SEq <- Q * sqrt((SEofgroupA^2 / meanofgroupA^2) + (SEofgroupB^2 / meanofgroupB^2))
      waldratio[i] <- Q
      lowerbound_waldratio[i] <- Q - (t * SEq)
      upperbound_waldratio[i] <- Q + (t * SEq)
      SEquotient <- SEq



    } else if (SEofgroupB > meanofgroupB) {
      if (g >= 1) {
        data <- data[-i, ]  # Remove the row where g is >= 1
        n <- nrow(data)     # Update the number of rows
        # Remove corresponding entries from vectors
        waldratio <- waldratio[-i]
        lowerbound_waldratio <- lowerbound_waldratio[-i]
        upperbound_waldratio <- upperbound_waldratio[-i]
        SEquotient <- SEq[-i]

      } else if (g < 1) {
        SEq <- (Q / (1 - g)) * sqrt(((1 - g) * (SEofgroupA^2 / meanofgroupA^2)) + (SEofgroupB^2 / meanofgroupB^2))
        waldratio[i] <- Q
        lowerbound_waldratio[i] <- (Q / (1 - g)) - (t * SEq)
        upperbound_waldratio[i] <- (Q / (1 - g)) + (t * SEq)
        SEquotient <- SEq

      }
    }
    i <- i + 1
  }

  result_data <- data.frame(
    data,
    waldratio = waldratio,
    lowerbound_waldratio = lowerbound_waldratio,
    upperbound_waldratio = upperbound_waldratio,
    SEquotient = SEq



  )

  return(result_data)
}
