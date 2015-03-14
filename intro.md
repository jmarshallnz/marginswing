In a political poll where there are two or more choices, such as where there are two or more political parties, we're often interested in estimating the difference in support between one 
party and another.

This turns out to be not as simple as we might like, as the proportion of voters for two categories are necessarily negatively correlated: For a fixed sample size, if you increase the number of votes in one category you must decrease the number of votes in the other categories.

Thus, when estimating the margin of error for a difference, we must take into account the margin of error of each party's support as well as the correlation between them.

Once we've estimated the margin of error, we can use that to predict the chance that the swing reverses.

**Have a play around with the sliders on the right to see how the margin of error for the left (red) and right (blue) change with sample size and with the percentage of voters.**

See below for the maths, and [github for the code](https://github.com/jmarshallnz/marginswing).
