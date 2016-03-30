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
      message("Installing", i, "package using biocLite... \n")
      biocLite(i)
    }
  }
}

depend.packages  <- c("plyr","shiny","rmarkdown","markdown",
  'GGally','svglite','intergraph', 'RevEcoR','network','igraph','ggplot2')

install_not_available(depend.packages)

##==============================================================================
## Load the dependecies
##==============================================================================

for(i in depend.packages){
  library(i, character.only = TRUE)
  message(paste(i,packageVersion(i),sep=": "))
}

##==============================================================================