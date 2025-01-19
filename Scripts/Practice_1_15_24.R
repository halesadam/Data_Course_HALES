getwd()
grades <- "./Data/Fake_grade_data.csv"
grades
read.csv()
read.csv(grades)
dat <- read.csv(grades)
class(dat)
class(grades)
class(names(dat))

?nrow
nrow(dat)
ncol(dat)

class(ncol(dat))
class(nrow(dat))

dat[1,]
dat[,15]
names(dat[15])
x <- names(dat)


dat[16]
mean(dat$Final_Project)
mean(dat$Skills_Test_2)
mean(dat$Student)
sd(dat$Assignment_2)
mean(dat$Assignment_2)
round(mean(dat$Skills_Test_1))
round(sd(dat$Skills_Test_2))
 

#creating test totals
test_totals <- dat$Skills_Test_1 + dat$Skills_Test_2 +  dat$Skills_Test_3 +   dat$Skills_Test_4

test_totals
#save as dataset
dat$Test_Totals <- test_totals

plot(dat$Test_Totals, dat$Assignment_1)
mod <- lm(dat$Test_Totals ~ dat$Assignment_1)
summary(mod)
