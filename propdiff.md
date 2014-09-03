In a political poll where there are two or more choices, such as where there are two or more political parties, we're often interested in estimating the swing in support from one party to another.

This turns out to be not as simple as we might like, as the proportion of voters for two categories are necessarily negatively correlated: For a fixed sample size, if you increase the number of votes in one category you must decrease the number of votes in the other categories.

Thus, when estimating the margin of error for a swing, we must take into account the margin of error of each party's support, in addition to the correlation between them.

Suppose we have a poll of $n$ people, for which there are $k$ choices available.  Then the number of people that vote for each category is described by the **multinomial distribution**.  When $k=2$ this drops down to the more familiar **binomial distribution**.  The formulae are similar, with the probability density function of the multinomial distribution being

$$P(X_1 = x_1, X_2 = x_2, \ldots X_k = x_k) = \frac{n!}{x_1! x_2! \cdots x_k!}p_1^{x_1}p_2^{x_2}\cdots p_k^{x_k}$$

where $\sum_{i=1}^k x_i = n$.  Our goal in a political poll is to estimate the unknown proportion of people $p_i$ we expect to vote for choice $i$ if everyone had the opportunity to vote.  From details on the multinomial distribution (TODO: link to wikipedia) we can see that our best estimate of these are just the proportions observed in the poll $\hat{p}_i$.

To estimate how much out we might be, we then need the standard error of these estimates.  We can again use the known results from the multinomial distribution to find that

$$E[\hat{p}_i] = p_i var[\hat{p}_i] = \frac{p_i (1-p_i)}{n}$$

As long as $n$ is large and $p_i$ isn't too close to 0 or 1, then we can approximate the error distribution for $\hat{p}_i$ using a normal distribution with the above mean and variance.

In order to estimate the **swing** in the vote from left to right, though, we'll want to estimate $p_{left} - p_{right}$.  To do this we need the covariance of $\hat{p}_i$ and $\hat{p}_j$.  We find that this is just

$$cov[\hat{p}_i, \hat{p}_j] = -\frac{p_i p_j}{n}$$

From this we can estimate the mean and variance of $p_{left} - p_{right}$ as

$$E(\hat{p}_{left} - \hat{p}_j) = p_{left} - p_j var(\hat{p}_{left} - \hat{p}_j) = var(\hat{p}_{left}) + var(\hat{p}_{right}) - 2cov(\hat{p}_{left}, \hat{p}_{right}) = \frac{p_{left} + p_{right} - (p_{left} - p_{right})^2}{n}$$

