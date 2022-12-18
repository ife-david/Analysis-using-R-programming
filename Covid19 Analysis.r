rm(list =ls())#To remove all variables previously loaded

library("Hmisc")

data <- read.csv("~/Personal Development/Data Analytics/Projects/R/COVID19_line_list_data.csv")
describe(data)

#cleaned up data
data$death_dummy <- as.integer(data$death != 0)

#death rate
sum(data$death_dummy)/nrow(data)

#Age
#claim: The average age of those who die from covid is higher than those who survive

dead <- subset(data, death_dummy == 1)
alive <- subset(data, death_dummy == 0)

mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

#is this statistically significant
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
#In statistics when the p value < 0.05, we reject the null hypothesis and conclude statistically significant
#Here p ~ 0, therefore we reject null hypothesis and conclude statistically significant


#Gender
#claim: Gender has no effect.

male <- subset(data, gender == "male")
female <- subset(data, gender == "female")
mean(male$death_dummy, na.rm = TRUE) #8.4%
mean(female$death_dummy, na.rm = TRUE) #3.66%

#is this statistically significant
t.test(male$death_dummy, female$death_dummy, alternative = "two.sided", conf.level = 0.95)
#The test showed a p value of 0.002105 which is far less than 0.05.Therefore we reject the null hypothesis
#Conclusion - statistically significant
