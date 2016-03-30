# reactive ---------------------------------------------------------------
Metabolicdata  <- reactive({
  infile  <- input$file1
  if (is.null(infile)){
    return(NULL)
  }else{
    read.delim(infile$datapath, header=input$header, 
      quote=input$quote, sep = input$sep) 
  }
})


# output ------------------------------------------------------------------

output$downloadRefData <- downloadHandler(
  filename = function(){"Refko.csv"},
  content = function(file){
    write.table(RefDbcache$ko,file,sep="\t", row.names = FALSE, quote = FALSE)
  }
)

output$downSampledata<- downloadHandler(
  filename = function(){"anno.species.csv"},
  content = function(file) {
    write.table(anno.species, file,sep = "\t", col.names = names(anno.species),
      row.names = FALSE, quote = FALSE)
  }
)


