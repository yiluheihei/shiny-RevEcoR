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
depend.packages  <- c("plyr","shiny","shinythemes","markdown","magrittr",
  'GGally','svglite','intergraph','network','igraph','ggplot2',
  'sna','devtools','RevEcoR')
all.packages = .packages(all.available = TRUE)
not_installed_pkg <- match(depend.packages, all.packages, nomatch = 0)
not_installed_pkg <- depend.packages[not_installed_pkg == 0]
if (length(not_installed_pkg))
  install.packages(not_installed_pkg)
