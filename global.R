# load require packages ---------------------------------------------------
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

################################################################################
# Source code from shiy-phyloseq
# Special variant of numericInput() that has a smaller default width,
# and is much more customizable, including `...`
# and an explicitly exposed `class` argument
#
# This is used by both ui.R and server.R
#
# Some helpful details. 
#
# http://shiny.rstudio.com/tutorial/lesson2/
# http://shiny.rstudio.com/articles/layout-guide.html
# http://stackoverflow.com/questions/20637248/shiny-4-small-textinput-boxes-side-by-side
# http://getbootstrap.com/2.3.2/base-css.html#forms
################################################################################
numericInputRow <- function(inputId, label, value, min = NA, max = NA, step = NA, class="form-control", ...){
  inputTag <- tags$input(id = inputId, type = "number", value = value, class=class, ...)
  if (!is.na(min)) 
    inputTag$attribs$min = min
  if (!is.na(max)) 
    inputTag$attribs$max = max
  if (!is.na(step)) 
    inputTag$attribs$step = step
  div(style="display:inline-block",
    tags$label(label, `for` = inputId), 
    inputTag)
}
textInputRow <- function(inputId, label, value = "", class="form-control", ...){
  div(style="display:inline-block",
    tags$label(label, `for` = inputId), 
    tags$input(id = inputId, type = "text", value = value, class=class, ...))
}

##============================================================================
## [Function]  gaint connected componets of network
##============================================================================
net_gaint_component  <- function(g){
  decomposed.component  <- decompose.graph(g)
  gaint.component.index  <- llply(decomposed.component, 
    function(x)V(x)$name) %>%
    laply(length) %>%
    which.max
  return(decomposed.component[[gaint.component.index]])
}

## data 
load("data/RefDbcache.rda")
load("data/anno.species.rda")
