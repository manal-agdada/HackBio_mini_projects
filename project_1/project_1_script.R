###########################################################################################################
###### HackBio project - Data Science with R for Life Scientists: Beginners -- Extreme Plotting in R  #####
###########################################################################################################

set.seed(1001)
x1=1:100+rnorm(100,mean=0,sd=15)
y1=1:100

# save all the plots that will be generated 
pdf("plots_HackBio.pdf")

# 1. make a scatter plot using the x1 and y1 vectors
plot(x1, y1)

# 2. use the main argument to give a title to plot()
plot(x1, y1, main = "Scatter Plot")

# 3. use the xlab and ylab argument to set a label for the x-axis and y-axis
plot(x1, y1, main = "Scatter Plot of x1 and y1", 
     xlab = "x1 values",
     ylab = "y1 values")

# 4. run mtext(side=3,text="hi there")
mtext(side=3,text="hi there")

# 5. check what mtext(side=2,text="hi there") does
mtext(side=2,text="hi there")

# 6. Use mtext() and paste() to put a margin text on the plot. You can use paste() as ‘text’ argument in mtext()
mtext(side=3,text=paste("hi there"))

# 7. use cor() on x1 and y1
cor(x1, y1)

# 8. display the correlation coefficient on the scatter plot
plot(x1, y1, main = "Scatter Plot of x1 and y1", 
     xlab = "x1 values",
     ylab = "y1 values")
mtext(side=3, text=paste("Correlation:", cor(x1,y1)))

# 9. change colors of the plot
plot(x1, y1, main = "Scatter Plot of x1 and y1", 
     xlab = "x1 values",
     ylab = "y1 values",
     col = "red")

# 10. use pch=19 command
plot(x1, y1, main = "Scatter Plot of x1 and y1", 
     xlab = "x1 values",
     ylab = "y1 values",
     col = "red",
     pch = 19)

# 11. use pch=18 command
plot(x1, y1, main = "Scatter Plot of x1 and y1", 
     xlab = "x1 values",
     ylab = "y1 values",
     col = "red",
     pch = 18)

# 12. make a histogram of x1 with hist()
hist(x1)

# 13. better the histogram with col, labels and title
hist(x1, xlab = "x1 values", ylab = "frequency", main = "Histogram of x1", col = "green")

# 14. make a boxplot of y1
boxplot(y1)

# 15. make a boxplot of x1 and y1
boxplot(x1, y1)

# 16. use horizontal = TRUE in the boxplot function
boxplot(x1, y1, horizontal = TRUE)

# 17. divide the screen to fit multiple figures par(mfrow=c(2,1))
par(mfrow=c(2,1))
boxplot(y1, ylab = "y1 values", main = "Boxplot of y1", col = "red")
hist(x1, xlab = "x1 values", ylab = "frequency", main = "Histogram of x1", col = "blue")

# 18. divide the screen to fit multiple figures with par(mfrow=c(1,2))
par(mfrow=c(1,2))
boxplot(y1, ylab = "y1 values", main = "Boxplot of y1", col = "red")
hist(x1, xlab = "x1 values", main = "Histogram of x1", col = "blue")

dev.off()
