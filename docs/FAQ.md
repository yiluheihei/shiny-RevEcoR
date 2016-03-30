### Q1. Why not lunch properly in my own system?

**A:** Normallly, simple running **shiny-RevEcoR** will install the missing packages (dependencies) automatically. If there is an error, you may have special development versions of packages, or a non-standard installation of R. Users can see the `sessionInfo` in the end of **Species interactions help page** for more detailed package version.

We can try to re-install all required packages as following:

```r
required_packages <-  c("plyr","shiny","rmarkdown","markdown",
  'GGally','svglite','intergraph', 'RevEcoR','network','igraph')
install.packages(required_packages)
```

### Q2. How much time will it take to calculate the species interactions? 

**A:** Calculation of species interactions is the most time-consuming module of shiny-RevEcoR. This step may take minutes, hours and even several days depend on the number of species to analysis. Generally, it takes about five minutes to analysis the built-in sample data which contains annotation profiles of seven species

### Q3. Which method is used for measure the biological or statistical sinificance of species interactions?

**A:** Default, we random sampled 1000 seed sets from the original metabolic network. The random seed sets are of the same size as the real seed set. We than calculate the interactions between a species' random seed sets and other species' seed set to determin its significance.

With reverse ecology analyis, we found that the competition index is significantly and positively correlated with co-occurrence, where as complementarity index is significantly and negatively correlated with co-occurrence. That is the species tend to co-occur across individuals more frequently with species with which they strongly compete. 

Thus, P value of index is obtained as equation `(r+1)/(n+1)`, where n is the number of random samples,  and r is the number of greater than or equal to competition index (for competition index),  or  the number of less than or equal to complementarity index (for complemenatiry index).

**Note** *P value calculation is one factor to slow our analyis,  the larger n the longer time will be taken.* 

### Q4. What is seed set and reverse ecology?

**A:** The seed set is defined as the minimal subset of compounds involved in an organism’s metabolism that cannot be synthesized from other compounds in the network, and all other compounds in the network can be produced by the presence of the seed set. A set of compound based on the metabolic network topology, represents the externally acquired compounds of the species, serves as the interface between species and their environments.

Reverse Ecology uses genomics to study community ecology with no a priori assumptions about the organisms under consideration. Based on seed set algorithm to obtain novel insights into an organism's ecology and its sorroundings. 

### Q5. Which operating system it is tested on?

**A:** x86_64-apple-darwin13.4.0 (64-bit), see the `SessionInfo` in help page for more details.


