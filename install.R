##==============================================================================
## Check that the currently-installed version of R is at least the minimum 
## required version. 
##==============================================================================

R.min.version = "3.1.1"
R.version = paste0(R.Version()$major, ".", R.Version()$minor)
if(compareVersion(R.version, R.min.version) < 0){
  stop("RevEcoR requires R 3.1.1 or later.\n", 
    "Launch should fail.\n",
    "Go to http://cran.r-project.org/ and update your version of R.")
}


##==============================================================================
## Install the basic required packages if not available/installed
##==============================================================================

install_not_available  <- function(pkg){
  installed.packges = .packages(all.available = TRUE)
  if(any(!pkg %in% installed.packges)){
    source("http://bioconductor.org/biocLite.R")
    for(i in pkg[!pkg %in% installed.packges]){
      message("Installing ", i, " package using biocLite... \n")
      biocLite(i,suppressUpdates = '.*')
    }
  }
}

depend.packages  <- c("plyr","shiny","shinythemes","markdown","magrittr",
  'GGally','svglite','intergraph','network','igraph','ggplot2','sna','devtools')

install_not_available(depend.packages)

## install the dev version of RevEcoR
if (!require(RevEcoR)){
  devtools::install_github('yiluheihei/RevEcoR')
}else {
  revecor.version <- packageVersion('RevEcoR')
  if (compareVersion('0.99.3', as.character(revecor.version))){
    devtools::install_github('yiluheihei/RevEcoR')
  }
}

library(shiny)
library(shinythemes)
library(RevEcoR)
library(GGally)
library(magrittr)
library(svglite)
library(plyr)
library(intergraph)
library(network)
library(igraph)
library(ggplot2)
