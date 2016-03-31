# shiny-RevEcoR

[shiny-RevEcoR](https://github.com/yiluheihei/shiny-RevEcoR)
is an interactive web application that provides 
a flexible graphical user interface (GUI) to the Reverse Ecology analysis package for R, called [RevEcoR](https://github.com/yiluheihei/RevEcoR/) hosted on [CRAN](https://cran.r-project.org/web/packages/RevEcoR/index.html). 

For details about using the **RevEcoR** package directly,
see the [package vignette](https://github.com/yiluheihei/RevEcoR/vignettes/RevEcoR.Rmd) hosted on [github](https://github.com/) or on the [CRAN](https://cran.r-project.org/web/packages/RevEcoR/index.html).

RevEcoR is intended for the following purposes:

1. Rapid, reproducible, interactive exploration of Reverse Ecology analysis
 
  (1) Genome scale metabolic network reconstruction start from the KEGG database annotated genome (microbial genomes or metagenomes are supported.)

  (2) Seed set detection as well as the exogenous compounds acquired from the environment.

  (3) Prediction of microbial ecology interactions.
  
2. Introduction to some of the functionality in the [RevEcoR](https://github.com/yiluheihei/RevEcoR/) package

3. Analysis more easy and convenient, even if you still be in dark about R.

4. An accessible tool for learning the microbial community and their ecology environment.


This RevEcoR shiny app help us to learn the microbial community begin with  KEGG Orthology (KO) annotated genomes' functional data uploaded, then we can reconstruct the metabolic network and identify the exogenous required compounds named seed set of a given species. Finally, species interactions is calculated according by comparing the seeds among various species.

# Availability

**shiny-RevEcoR** is open source and runs through R and a web browser. It is available at 
[https://yiluheihei.shinyapps.io/shiny-RevEcoR/](https://yiluheihei.shinyapps.io/shiny-RevEcoR/) or can be installed locally and the source code accessed from 
[https://github.com/yiluheihei/shiny-RevEcoR](https://github.com/yiluheihei/shiny-RevEcoR).

# Launch/Install shiny-RevEcoR

For running the **shiny-RevEcoR** back end with R, you must have the [R](http://cran.r-project.org/) installed on your system. It requires R 3.1.1 or later. 

Once required version of R is installed on your system, simply launching **shiny-RevEcoR** will also install dependencies that are missing on your system. Apparently, this requires an internet connection and installation permission on your system.

The following R code will launch RevEcoR on most systems.

```{r}
if (!require(shiny))
  install.packages("shiny") 
shiny::runGitHub("yiluheihei/shiny-RevEcoR")
```

See the help page for more details.

##  Citing

RevEcoR shiny app is a free and open source software, licensed under GPL.
All we require is that you cite/attribute the following
in any work that benefits from this code or application.

## Contributing

Source code of this app is hosted on [my github](https://github.com/yiluheihei/shiny-RevEcoR). If you'd like to get involved, please fork this repository and submit a pull request with your proposed changes. We're happy to chat if you have any questions about the source code.

## News

version 0.1.1 2016.3.25

- Rewrite the most source code,  making code more simple and readable.  Take some new functions of latest **shiny package**, such as  validate error message while app goes wrong, `navbarpage `.
- All the intermediate results can be download and saved on your system by clicking the corresponding download buttons.
- Embed Bootstrap themes with **shinythemes** package.
- Add p value calculation of interactons according to the **RevEcoR** package, specifically speed the interactions calcualtion time.
- More detailed tutorials.
- Remove BSI score.
- Attach a video for how to use **shiny-RevEcoR**



