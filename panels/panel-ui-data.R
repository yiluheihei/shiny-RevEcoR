datapage = fluidPage(
  column(width = 3,
    wellPanel(
      img(src = "logo.png", width = 220)
    ),
    wellPanel(
      h5("Download sample annotated metabolic data"),
      downloadButton("downSampledata", "Download")
    ),
    wellPanel(
      h5("Upload tab-seprated file"),
      fileInput('file1',label = '', accept=c('text/csv', 
        'text/comma-separated-values,text/plain', '.csv'))
    ),
    wellPanel(
      h5("Download KEGG reference metabolic data"),
      downloadButton("downloadRefData", "Download")
    )
  ),
  column(width = 9)
)
