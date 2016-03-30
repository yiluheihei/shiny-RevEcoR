## Getting started

Reverse Ecology is an emerging new frontier in Evolutionary Systems biology at the interface of computational biology, genomics and environmental science.  This term uses population genomics to study ecology with no a priori assumptions about the organism(s) under consideration. It facilitates the translation of high through genomic data into large scale ecological data, and utilizes system-based method to obtain novel insights of poorly characterized microorganisms and relationships between microorgasnims or their environments in a superorganism.Traditional approach, however, can only applied to a small scale and for relatively well-studied systems.

[shiny-RevEcoR](https://github.com/yiluheihei/shiny-RevEcoR) is an interactive web application that provides a flexible graphical user interface to the Reverse Ecology analysis package for R, called [RevEcoR](https://github.com/yiluheihei/RevEcoR/).For details about using the RevEcoR package directly,see the [package vignette](https://github.com/yiluheihei/RevEcoR/vignettes/RevEcoR.Rmd). It is an open-source project with a modular design based on the much more general Shiny project for exposing R tools with custom web interfaces. As a result it is easy to customize --- for instance by the uploading annotation profiles to the default selection list, adjusting default parameters to analyze the microbial metabolism and ecology. It can be divided into two main functional module, genome scale metabolic network analysis and species interactions detection. 

A typical workflow in **shiny-RevEcoR** begins with KEGG Orthology(KO)-annotated genomes' functional data uploading, followed by metabolic network reconstruction and species interactions prediction. Each step of microbial data analysis are available in separate panels, including data management, metabolic network reconstruction, seed set identification and microbial interactions calculation. Basic settings of every step can be selected on the sidebar panel. User input widgets are consolidated in a left-hand sidebar of each panel, and all the intermediate results can be download and saved on your system by clicking the corresponding download buttons.  

**shiny-RevEcoR** interface is organized into panels from left to right. First panel shows the introduction of **shiny-RevEcoR**, implementing the overview of this app and how to install and extending it and other panel was used for data uploading and analysis.

**RevEcoR** package provides the backend Application Program Interface (API) for building this interactive web application. This app is almost entirely R code. However, it can be further extended integrating HTML, CSS, and JavaScript with R code as any other Shiny app. **shiny-RevEcoR** is fully cross-platform and can launch locally from any R environment (Console R, Rgui, RStudio, etc.), and can also be ["hosted" by a web-server](http://shiny.rstudio.com) that requiring only a web browser. 


### Installation

This chapters show the detailed description on how to launch/run shiny **RevEcoR** on your own system. It requires that you have both a *back end* [R](http://en.wikipedia.org/wiki/Web_browser) and a *front end* [web browser](http://en.wikipedia.org/wiki/Web_browser) installed on your system  


#### Front end

Users can launch shiny RevEcoR in your external web browser. It was supported by all the modern web browser.

- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Chrome](https://www.google.com/intl/en-US/chrome/browser/)
- [Safari](https://www.apple.com/safari/)
- [Internet Explorer](http://windows.microsoft.com/en-us/internet-explorer/download-ie) 8 or later

Internet Explorer is not well supported, and not recommended. Other modern browsers likely fine for connecting to a Shiny app session.

#### Back end

You must have the R 3.1.1 or later on your system for running  **shiny-RevEcoR** correctly, as well as several additional packages.

#### Auto-running shiny **RevEcoR** (Recommended)

Once you have installed or updated the R version to 3.1.1 or later, simple running **shiny-RevEcoR** will install the missing packages (dependencies) automatically. **Note** that this also requires an internet connection and installation permission on your system.

Run locally by pasting the following code into the R console:

```r
if (!require(shiny))
  install.packages("shiny") 
shiny::runGitHub("yiluheihei/shiny-RevEcoR")
```
Alternatively download the .zip file, unzip and run the following code (example for file on desktop)

```r
if (!require(shiny))
  install.packages("shiny") 
shiny::runApp('~/../Desktop/shiny-RevEcoR-master/shiny-RevEcoR-master')
```

#### Manual-install dependencies

If your auto run **shiny-RevEcoR** locally successfully according the above section, you can skip this section.

The following R code will install required packages on your local system. Note that this assumes that you have an active internet connection and updated R installation.

```r
if (!require(devtools))
  install.packages("devtools") 
devtools::source_url("https://github.com/yiluheihei/shiny-RevEcoR/blob/master/install.R")
```

This code executes the same package install code that is used by the auto-installer in **shiny-RevEcoR** itself. This is only recommended/necessary if you have never launched **shiny-RevEcoR** before and you want/need to perform/test installation ahead of launch. In addition, the web link provides the exact recommended dependency and installation code, in case your system has special requirements or you need to debug installation manually – for instance if you have special development versions of packages, or a non-standard installation of R. For most systems, this "manual install" is not necessary.


### Machine Requirements

If you are merely pointing your web browser at a remote server that is hosting **shiny-RevEcoR**, then your machine performance requirements are much less. 
Most modern desktops/laptops will do fine. If you are launching your own locally-hosted session, then you will need to install some things
and your system requirements are greater because your own computer will be performing the "back end" computations as well as rendering the graphics and user interface.

### Customizing

If you've downloaded the **shiny-RevEcoR** source code and intend to tinker with it. It is also possible to modify any aspect of **shiny-RevEcoR**. 

### Feedback

**shiny-RevEcoR** is openly [developed on GitHub](https://github.com/yiluheihei/shiny-RevEcoR/). Any bug reports, feature requests, and suggestions for improvement will be appreciated.

The website of [RevEcoR issue tracker](https://github.com/yiluheihei/shiny-RevEcoR/issues) is https://github.com/yiluheihei/shiny-RevEcoR/issues

### Contributing Code

Anybody, a programmer with skill in R, JavaScript, or CSS, may be contributed to **RevEcoR**. Contributions are preferred through the standard git/GitHub [Pull Request](https://help.github.com/articles/using-pull-requests)
system. 


### Acknowledgements

Big thanks to [Shiny web apps team](http://shiny.rstudio.com/) and Rstudio in general.
