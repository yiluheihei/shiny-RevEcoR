##source('install.R', local = TRUE)
## load required packages
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
load("data/RefDbcache.rda")
load("data/anno.species.rda")


##============================================================================
##                          [Function]  
##============================================================================
## validata error message
no_data <- function(sample.input, upload.input){
  if (!sample.input && is.null(upload.input))
      "Please upload your metabolid data or load the sample data first"
  else 
    NULL
}


shinyServer(function(input, output) { 
  
  ##outputOptions(output, "net", priority = 1)
  ##outputOptions(output, "ne2", priority = 2)
  # data panel server -----------------------------------------------------  
  ##  reactive
  uploaded.data  <- reactive({
    validate(
      no_data(input$sampledata, input$uploadfile)
    )
    infile  <- input$uploadfile
    if (is.null(infile)){
      return(anno.species)
    }else{
      upload.data  <- read.delim(infile$datapath) 
      return(upload.data)
    }
  })
  
  species.name  <- reactive({
    data  <- uploaded.data()
    if (is.null(data))
      return(names(anno.species))
    return(names(data))
  })
  
  
  ## output 
  output$downloadData  <- downloadHandler(
    filename = function(){"anno.species.tab"},
    content = function(file) {
      write.table(anno.species, file, sep = "\t", 
        col.names = names(anno.species),
        row.names = FALSE, quote = FALSE)
    }
  )
  
  output$downloadRefData <- downloadHandler(
    filename = function(){"Refko.tab"},
    content = function(file){
      write.table(RefDbcache$ko,file,sep="\t")
    }
  )
  
  if (FALSE){
    output$table <- DT::renderDataTable(DT::datatable(
      uploaded.data(),
      options = list(
        pageLength = 15,
        scrollX = TRUE,
        searching = FALSE
      )
    ))
  }
  
  output$species_no <- renderText(
    paste("Uploaded data contains annotated metabolic information of",
      length(species.name()),'species:'
    )
  )
  
  output$species_name <- renderText(paste0(species.name(), collapse = ', '))
  
  output$species_ko_no <- shiny::renderDataTable({
    ko.no <- colSums(!is.na(uploaded.data()))
    species.ko.length <-  as.data.frame(t(ko.no))
  }, options = list(searching = FALSE, scrollX = TRUE))
  
# net panel server --------------------------------------------------------

  ## reactive
  metabolicNetwork  <- reactive({
    if (input$draw_network == 0)
      return()
    g  <- reconstructGsMN(uploaded.data()[input$speciesname], 
      is.gaint = input$gaint_component, threshold = input$small_threshold)
    return(g)
  })
  
 
  
  ## output
  output$species_select  <- renderUI({
    selectInput("speciesname", label = "Species", 
      choices = species.name(),selected =species.name()[1])
  })
  
  #plot dimensions
  plot_height <- function(){
    if (input$draw_network == 0) 
      return(height = 400)
    isolate({
      height <- 72*input$net_height})
  }
  
  
  plot_width <- function(){
    if (input$draw_network == 0) 
      return(width = 400)
    isolate({
      width <- 72*input$net_width})
  }
  
  ## ============== deprecated orginal metabolic network ================
  gg_network <- reactive({
    network(asNetwork(metabolicNetwork())) %>% 
      ggnet2(mode = input$network_layout,
        size = input$node_size, 
        color = input$node_color,
        edge.size = input$edge_size,
        arrow.size = input$edge_arrow_size)
  })
  
  output$net <- renderPlot({
    if (input$draw_network == 0)
      return()
    isolate(print(gg_network()))
  })
  
  output$plot_net <- renderUI({
    if (input$draw_network == 0)
      return()
    isolate(plotOutput("net", 
      width = 72*input$net_width, height = 72*input$net_height))
  })
  ##======================================================================
  
  output$download_net <- downloadHandler(
    filename =  function()
      paste0(input$speciesname,'_network.', input$network_format),
    content = function(file) {
      ggsave(file, plot = seed_network(), device = input$network_format,
        width=input$net_width, height=input$net_height, dpi=300L, units="in")
    }
  )
  
  output$network_edgelist  <- shiny::renderDataTable({
    if( input$draw_network == 0){ 
      message("Please select options and draw the network.")
      return()
    }
    isolate({
      edgelist  <- metabolicNetwork() %>%
        get.edgelist %>%
        as.data.frame(.,stringsAsFactors = FALSE)
      names(edgelist)  <- c("source","target")
      return(edgelist)
    })}, options = list(pageLength = 15, 
      pagingType = "simple", searching = FALSE, scrollX = TRUE)
  )
  
  output$downloadEdgeList  <- downloadHandler(
    filename = function(){paste0(input$speciesname,"_net_edgelist.tab")},
    content = function(file) {
      edgelist  <- metabolicNetwork() %>%
        get.edgelist %>%
        as.data.frame(.,stringsAsFactors = FALSE)
      names(edgelist)  <- c("source","target")
      write.table(edgelist, file,sep = "\t", row.names = FALSE, quote = FALSE)
    }
  )
  
  # seed set tabpanel 
  ## reactive
  
  node_names  <- reactive({
    g  <- metabolicNetwork()
    return(V(g)$name)
  })
  
  seedset  <- reactive({
    if (input$draw_network == 0)
      return()
    isolate({
      seed  <- getSeedSets(metabolicNetwork(),input$confidence_score)
      return(seed)
    })
  })
  
  net_seeds  <- reactive({
    if (input$draw_network ==0)
      return()
    net.seeds  <- seedset()@seeds  
  })
  
  seed_confidence  <- reactive({
    confidence.score  <- 1/lengths(net_seeds()) 

  })
  
  net_seeds_confidence  <- reactive({
    if (input$draw_network ==0)
      return()
    confidence.score <- rep(seed_confidence(), lengths(net_seeds()))
    data.frame(seeds = unlist(net_seeds()), confidence.score = confidence.score)
  })
  
  output$net_seeds_confidence <- shiny::renderDataTable({
    net_seeds_confidence()
  }, options = list(pageLength = 15, searching = FALSE, scrollX = TRUE))
  
  output$download_seedset  <- downloadHandler(
    filename = function(){paste0(input$speciesname,"_seedset.tab")},
    content = function(file) {
      write.table(net_seeds_confidence(), file, sep = "\t", 
        row.names = FALSE, quote = FALSE)
    }
  )
  
  seeds_color  <- reactive({
    if (input$draw_network ==0)
      return()
    nodes  <- node_names()
    seeds.set  <- unlist(net_seeds())
    seed.index  <- match(seeds.set,nodes)
    color=rep(input$node_color,length(nodes))
    color[seed.index]  <- input$seed_color
    return(color)
  })
  
  
  seed_network <- reactive({
    network(asNetwork(metabolicNetwork())) %>% 
      ggnet2(mode = input$network_layout,
        size = input$node_size, 
        color = seeds_color(),
        edge.size = input$edge_size,
        arrow.size = input$edge_arrow_size)
  })
  
  ## output
  output$net2  <- renderPlot({
    if (input$draw_network == 0) 
      return()
    isolate({
      withProgress({
        print(seed_network())},
        message = 'Calculation in progress',
        detail = 'This may take a while...')
    }) 
  })
  
  output$plot_net2 <- renderUI({
    if (input$draw_network == 0)
      return()
    isolate(plotOutput("net2", 
      width = 72*input$net_width, height = 72*input$net_height))
  })
  
  output$seednet_description  <- renderText({
    if(input$draw_network == 0)
      return()
    else{
      isolate({
       paste('<b>',"Metaboli network, in which nodes represent compounds 
          involved in metabolism and direct edges from node A to node B indicate that 
          compound A is a substrate in a certain reaction that produces compound B.",
          "The node colored with", input$seed_color, "represents the seed.", '</b>')
      })
    }
  })
  
  output$seednode_length  <- renderText({
    if(input$draw_network == 0)
      message <- ""
    else{
      isolate({
        node.length  <- length(V(metabolicNetwork())$name)
        paste('<b>',"Nodes:",node.length,'</b>')
      })
    }
  })
  
  output$seededge_length  <- renderText({
    if(input$draw_network == 0)
      return(NULL)
    else{
      isolate({
        edge.length <- metabolicNetwork() %>%
          get.edgelist %>%
          nrow
        return(paste('<b>',"Edges:",edge.length,'</b>'))
      }) 
    }
  })
  
  ## interactions panel
  interactions <- reactive({
    if (input$compute_interaction == 0)
      return(NULL)
    isolate({
      withProgress({net <- llply(uploaded.data(), reconstructGsMN)
      return(calculateCooperationIndex(net, p = TRUE))}, 
      message = 'Calculation in progress',
      detail = 'This may take a while...')
    })
  })
  
  
  
  output$competition_index <- shiny::renderDataTable(
    interactions()$competition.index, 
    options = list(searching = FALSE, scrollX = TRUE)
  )
  
  output$competition_index_p <- shiny::renderDataTable(
    interactions()$competition.index.p,
    options = list(searching = FALSE, scrollX = TRUE)
  )
  
  output$complementarity_index <-shiny::renderDataTable(
    interactions()$complementarity.index,
    options = list(searching = FALSE, scrollX = TRUE)
  )
  
  output$complementarity_index_p <-shiny::renderDataTable(
    interactions()$complementarity.index.p,
    options = list(searching = FALSE, scrollX = TRUE)
  )
  
  output$download_competition  <- downloadHandler(
    filename = function(){"competition_index.tab"},
    content = function(file) {
      competition.index <- interactions()$competition.index
      write.table(competition.index, file,sep = "\t", row.names = TRUE, 
        col.names = TRUE, quote = FALSE)
    }
  )
  
  output$download_competition_p  <- downloadHandler(
    filename = function(){"competition_index_p.tab"},
    content = function(file) {
      competition.index.p <- interactions()$competition.index.p
      write.table(competition.index.p, file,sep = "\t", row.names = TRUE, 
        col.names = TRUE, quote = FALSE)
    }
  )
  
  output$download_complementarity  <- downloadHandler(
    filename = function(){"complementarity_index.tab"},
    content = function(file) {
      complementarity.index <- interactions()$complementarity.index
      write.table(complementarity.index, file,sep = "\t", row.names = TRUE, 
        col.names = TRUE, quote = FALSE)
    }
  )
  
  output$download_complementarity_p  <- downloadHandler(
    filename = function(){"complementarity_index_p.tab"},
    content = function(file) {
      complementarity.index.p <- interactions()$complementarity.index.p
      write.table(complementarity.index.p, file,sep = "\t", row.names = TRUE, 
        col.names = TRUE, quote = FALSE)
    }
  )
  
  output$competition_message <- renderText({
    if (input$compute_interaction == 0)
      return()
    isolate(paste('<br/>','<b>','Competition index show as folowing table:','</b>'))
  })
  
  output$competition_p_message <- renderText({
    if (input$compute_interaction == 0)
      return()
    isolate(paste('<br/>','<b>','P value of competition index show as following table:','</b>'))
  })
  
  output$complementarity_message <- renderText({
    if (input$compute_interaction == 0)
      return()
    isolate(paste('<br/>','<b>','Complementarity index show as following table:','</b>'))
  })
  
  output$complementarity_p_message <- renderText({
    if (input$compute_interaction == 0)
      return()
    isolate(paste('<br/>','<b>','P value of complementarity show as following table:','</b>'))
  })
  
    
  output$sessionInfo <- renderPrint({
      capture.output(sessionInfo())
  })
  
})







