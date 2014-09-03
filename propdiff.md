Suppose we have a poll of $n$ people, for which there are $k$ choices available.  Then the number of people that vote for each category is described by the **multinomial distribution** 
^[1] .

The goal in a political poll is to estimate the unknown proportion of people $p_i$ we expect to vote for choice $i$ if everyone had the opportunity to vote.  Assuming our poll is 
representative (or has been reweighted accordingly) Our best guess at this is just the proportion observed in the poll
$$
\hat{p}_i = \frac{x_i}{n}
$$
where $x_i$ is the number of people that vote for choice $i$ so that $\sum_{i=1}^k x_i = n$.

To estimate how much out our guess might be, we'll need the *standard error* of the estimate.  We can use the [known results from the multinomial distribution](http://en.wikipedia.org/wiki/Multinomial_distribution#Properties) to find that
$$
\begin{align}
  \mathsf{mean}[\hat{p}_i] &= p_i\\\\
  \mathsf{var}[\hat{p}_i] &= \frac{p_i (1-p_i)}{n}
\end{align}
$$

As long as $n$ is large and $p_i$ isn't too close to 0 or 1, then we can approximate the error distribution for $\hat{p}_i$ using a normal distribution with the above mean and variance 
^[2] .

In order to estimate the **swing** in the vote from left to right, though, we'll want to estimate $p_{left} - p_{right}$.  To do this we need the covariance of $\hat{p}_i$ and $\hat{p}_j$.  We find that this is just
$$
\mathsf{cov}[\hat{p}_i, \hat{p}_j] = -\frac{p_i p_j}{n}
$$
From this we can estimate the mean and variance of $\hat{p}_{left} - \hat{p}_{right}$ as
$$
\begin{align}
  \mathsf{mean}[\hat{p}_{left} - \hat{p}_{right}] &= p_{left} - p_{right}\\\\
  \mathsf{var}[\hat{p}_{left} - \hat{p}_{right}] &= \mathsf{var}(\hat{p}_{left}) + \mathsf{var}(\hat{p}_{right}) - 2\mathsf{cov}(\hat{p}_{left}, \hat{p}_{right})\\\\
  &= \frac{p_{left} + p_{right} - (p_{left} - p_{right})^2}{n}
\end{align}
$$

The above assumes that the poll is representative.  Unfortunately, few polls are ever representative, they're usually reweighted.  By doing so we effectively reduce the sample size by 
dividing by a quantity known as the **design effect**.  In the above plots, we've assumed the sample was representative, so has design effect 1.  In reality, it's more likely that the 
design effect in most New Zealand polls is closer to 2, which would halve the sample size, increasing margins of error by about 40%.  You can simulate this by halving the sample size 
using the slider above.

[1]: When $k=2$ this drops down to the more familiar **binomial distribution**.

[2]: A rule of thumb is that $n \hat{p}_i$ and $n(1-\hat{p}_i)$, the number of votes for or against choice $i$, are both larger than 5.
