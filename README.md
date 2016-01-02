<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
## Stick breaking 101

Ahh, the ubiquitous stick breaking process (SBP). (Well, it's probably more *esoteric* than *ubiquitous*, but we'll go with it anyways.) The stick breaking process is a convenient way to generate random probability measures and completely random measures---don't stress if those terms aren't familiar. In fact, the SBP allows us to put distributions on an infinite collection of objects (*e.g.,* the integers).

**The details below are not needed to understand the *SBP Shiny app* but may be of interest to some readers.  Those solely interested in the app should proceed to the *SBP Shiny app* section.**

The SBP is a tool in a *nonparametric Bayesian's* toolbox for putting *distributions on distributions* or distributions on abstract spaces. For example, samples from the Dirichlet process, which is a stochastic process that *takes on values* in the space of probability distributions, can be generated using a stick breaking approach.

The SBP is a *convenient* method for generating random objects because it has a compact 
combinatorial form.

## SBP Shiny app

For our purposes the SBP will be a way to generate discrete distributions on 
a *large number* points, called *atoms*. The distribution has two sources of randomness: 
its probabilities and its atom locations. The app has controls for each source of 
randomness; they are discussed in the sub-sections below.

### Stick breaking controls

The user can specify two arguments that control one aspect of the SBP's randomness: 
the number of sticks and the stick lengths.

* The *number of atoms* is simply the number of points that are sampled.
      + A large number of atoms can be thought of as an approximation to an infinte 
      collection of atoms.
* The *concentration parameter* controls the weights (or *heights* or *lengths*) of the 
sampled atoms.
      + A larger concentration parameter will result in a large number of *tall* atoms.

### Base measure controls

The user can also pick the *base distribution* (or base measure), which is the second 
source of randomness in the SBP. The available distributions are:

* Normal (or Gaussian): lives on (*i.e.,* takes values on) $\mathbf{R}$
* Gamma: lives on $\mathbf{R}_{+}$
      + Note: Includes *exponential distribution* when the shape parameter is set equal
       to 1
* Beta: lives on $[0, 1]$
      + Note: Includes *uniform distribution* when both parameters are set equal to 1
* Cauchy: lives on $\mathbf{R}$

Once the distribution has been chosen, the user can specify its parameters.  For example, 
the mean and standard deviation of the normal distribution can be adjusted via slider 
input. Additional details are provided below.

#### Normal parameters

* Mean -- central tendency of the distribution
* Standard deviation -- dispersion around the distribution's mean

#### Gamma parameters

* Shape -- controls the distribution's curvature and mean
* Rate -- controls the distribution's mean and variation

#### Beta parameters

* Shape 1 -- shifts of distribution towards 1 (usually denoted as $\alpha$)
* Shape 2 -- shifts of distribution towards 0 (usually denoted as $\beta$)

#### Cauchy parameters

* Location -- similar to the normal distribution's mean
* Scale -- similar to the normal distribution's standard deviation

### Some output statistics

The output table provides basic statistics from the random measure, including its mean, 
minimum, maximum, and "longest stick".  (The longest stick is simply the atom with the 
highest probability.)  Note that the longest stick will **not** change if the 
*base measure controls* are updated. The longest stick **will** change if the 
*stick breaking controls* are adjusted.

---

## Resources and references
Jordan, M. I. Bayesian Nonparametric Learning: Expressive Priors for Intelligent Systems.
 In R. Dechter, H. Geffner, and J. Halpern (Eds.), Heuristics, Probability and Causality: 
 A Tribute to Judea Pearl, College Publications, 2010. 
 <http://www.cs.berkeley.edu/~jordan/papers/pearl-festschrift.pdf>.

Kingman, J.F.C. "Completely random measures." Pacific Journal of Mathematics. Volume 21. 
Issue 1. Pages 59-78. 1967. 
<https://projecteuclid.org/download/pdf_1/euclid.pjm/1102992601>.
