rm(list =ls())#To remove all variables previously loaded

library("Hmisc")

covid19_raw <- read.csv("~/Personal Development/Data Analytics/Projects/R/COVID19_line_list_data.csv")
describe(data)

#cleaned up data
covid19_raw$death_cleaned <- as.integer(covid19_raw$death != 0)

#death rate
sum(covid19_raw$death_cleaned)/nrow(covid19_raw)

#Age
#claim: The average age of those who die from covid is higher than those who survive

dead <- subset(covid19_raw, death_cleaned == 1)
alive <- subset(covid19_raw, death_cleaned == 0)

mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

#is this statistically significant
t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
#In statistics when the p value < 0.05, we reject the null hypothesis and conclude statistically significant
#Here p ~ 0, therefore we reject null hypothesis and conclude statistically significant


#Gender
#claim: Gender has no effect.

male <- subset(covid19_raw, gender == "male")
female <- subset(covid19_raw, gender == "female")
mean(male$death_cleaned, na.rm = TRUE) #8.4%
mean(female$death_cleaned, na.rm = TRUE) #3.66%

#is this statistically significant
t.test(male$death_cleaned, female$death_cleaned, alternative = "two.sided", conf.level = 0.95)
#The test showed a p value of 0.002105 which is far less than 0.05.Therefore we reject the null hypothesis
#Conclusion - statistically significant
