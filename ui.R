# share sidebar -----------------------------------------------------------
library(shiny)
library(shinythemes)

shared_sidebar <- function(){
  column(width = 3, 
    wellPanel(
      img(src = "images/logo.png"),
      tags$head(tags$style(
        type="text/css",
        "img {max-width: 100%; width: 100%; height: auto}"
      ))
    ),
    wellPanel(
      helpText(HTML("<b>VERSION CONTROL</b>")),
      HTML('Version 0.1.1'),
      HTML('<br>'),
      HTML('Updated on 21-Mar-2016'),
      HTML('<br>'),
      HTML('<a href="https://github.com/yiluheihei/shiny-RevEcoR" 
        target="_blank">Code on GitHub</a>')
      ),
    wellPanel(
      tags$p("Yang Cao"),
      tags$p("Beijing Institute of Radiation Medicine"),
      tags$p("Department of Biotechnology"),
      tags$p("Email:", tags$a(href="mailto:yiluheihei@gmail.com",
        "yiluheihei@gmail.com"))
    ),
    wellPanel(
      helpText(HTML("<b>OTHER Links</b>")),
      HTML('<a href="https://github.com/yiluheihei/RevEcoR" target="_blank"
        >RevEcoR Package</a>,'),
      HTML('<a href="https://github.com/yiluheihei" 
        target="_blank">Github Page</a>.')
      )
    )
}

helppage = function(doc){
  fluidPage(width =12, tabPanel('',includeMarkdown(doc)))
}

# net layout --------------------------------------------------------------

available_layouts_net = list(
  circle = 'circle',
  eigen = 'eigen',
  fruchtermanreingold = 'fruchterman.reingold',
  hall = 'hall',
  kamadakawai = 'kamada.kawai',
  mds = 'mds',
  princoord = 'princoord',
  random = 'random',
  spring = 'spring',
  target = 'target'
)

## network format for saving 
vector_graphicformats = c("eps", "pdf", "tex", "svg")
raster_graphicformats = c("bmp", "jpg", "png", "tiff")
graphic_formats = c(vector_graphicformats, raster_graphicformats)

# introduction page -------------------------------------------------------

intropage = fluidPage(
  shared_sidebar(),
  column(width = 9,
    ##h4("Introduction to shiny-RevEcoR"),
    tabPanel("introduction",includeMarkdown("docs/introduction.md"))
  )
)


# Data PAGE ---------------------------------------------------------------

datapage = fluidPage(
  column(width = 3,
    wellPanel(
      img(src = "images/logo.png"),
      tags$head(tags$style(
        type="text/css",
        "img {max-width: 100%; width: 100%; height: auto}"
      ))
    ),
    wellPanel(
      ##helpText('In shiny-RevEcoR, a build-in sample metabolic data have been loaded.'),
      ##helpText("Download sample annotated metabolic data"),
      checkboxInput(inputId = "sampledata",
        label = "Load sample data",value = FALSE),
      downloadButton("downloadData", "Download")
    ),
    wellPanel(
      ##helpText("Users can upload their own species' metabolic data"),
      helpText("Upload tab-seprated file"),
      fileInput('uploadfile',label = '', accept=c('text/tab', 
        'text/tab-separated-values,text/plain', '.tab'))
    ),
    wellPanel(
      helpText("Download KEGG reference metabolic data"),
      downloadButton("downloadRefData", "Download")
    )
  ),
  
  column(width = 9,
    helpText("In shiny-RevEcoR, a build-in sample metabolic data have been loaded.
      And shiny-RevEcoR begins with the KO annotation functional data uploading. 
      User can upload local KO annotated profile of genomes that are in the “tab 
      tab-separated” file format.The first row of shiny-RevEcoR's input data 
      represents the species name. For the specific input data format, users can
      also download the sample metabolic data in the sidebar panel of this page, 
      and your own input data must be in the same format as the sample data."),
    helpText("Note the initial input of shiny-ReEvEcoR must be functional data
      which have been annotated with KEGG database, that is the uploaded data 
      have been annotated with the KEGG orthology (KO)."),
    helpText("Once species' functional annotation data is uploaded, subsequently 
      users could reconsruct the metabolic network of selected species based on
      KEGG database in the next Network page."),
    tags$b('The KO number that each species mapped is as following, and first row 
      of data is the name of species'),
    shiny::dataTableOutput('species_ko_no')
    ##textOutput('species_name')
    ##tags$style(
      ##"#species_no{font-size: 20px;font-weight: bold;}",
      ##"#species_name{font-size: 20px;}"
    ##)
    ##)
  )
)

# netpage -----------------------------------------------------------------

netpage = fluidPage(
  tags$link(rel = 'stylesheet', type = 'text/css', href = 'style.css'),
  column(width = 3,
    wellPanel(
      img(src = "images/logo.png"),
      tags$head(tags$style(
        type="text/css",
        "img {max-width: 100%; width: 100%; height: auto}"
      ))
    ),
    wellPanel(
      ##helpText("The select input widget determines which speices network will be 
      ##reconstucted and visualized in the right panel, as well as in the next
      ##", tags$i("Seed set"),'page.'),
      h5('Network Structure'),
      helpText('Which species to analysis..'),
      uiOutput("species_select"),
      selectInput("network_layout", "Layout",
        choices = names(available_layouts_net),
        selected = "fruchtermanreingold"
      ),
      fluidRow(column(width=12,
        div(class = 'col-md-6',numericInputRow("confidence_score",
          "Confidence",min =0, max =1, value=0,step=0.1, class = 'col-md-12')),
        div(class = 'col-md-6',textInputRow("seed_color","Seed color",
          "red", class = 'col-md-12'))
      )),
      checkboxInput(inputId = "gaint_component",label ="Ignore all nodes except 
        those in the giant component?",value = TRUE),
      checkboxInput(inputId = "small_component",
        label = "Ignore small component?",value = TRUE),
      helpText('The number of nodes of small component to ignore.'),
      numericInput(inputId = "small_threshold",label="Threshold", 
        min = 0,  value = 0, step = 5)
    ),
    wellPanel(
      h5("Aesthetic Mapping"),
      fluidRow(column(width=12,
        div(class="col-md-6",
          numericInputRow(inputId = "node_size","vertex size", 
            min = 0, max = 20, value = 3, step = 1,class="col-md-12")),
        div(class="col-md-6", textInputRow(inputId="node_color", 
          label="vertex color", value = "blue", class="col-md-12"))
      )),
      fluidRow(column(width=12,
        div(class="col-md-6",numericInputRow(inputId = "edge_arrow_size",
          "Arrow size", min = 0,  value = 0, step = .1,class="col-md-12")),
        div(class="col-md-6",numericInputRow(inputId = "edge_size", 
          "Edge size", min = 0,  value = 0.25, step = .1,class="col-md-12"))
      ))
    ),
    wellPanel(
      h5("Dimension and Download"),
      fluidRow(column(width=12,
        div(class="col-md-6",numericInputRow("net_width", "width",
          value=10, min=5, step=1, max = 100, class="col-md-12")),
        div(class="col-md-6",numericInputRow("net_height", "height",
          value=7, min=3, step=1, max = 100, class="col-md-12"))
      )),
      fluidRow(column(width=12,
        div(class = 'col-md-6',selectInput('network_format', "NetFormat",
          choices = graphic_formats, selected = "pdf")),
        div(class = 'col-md-6',div(style="display:inline-block",tags$label("Network"),
          downloadButton('download_net', 'Network'))
        )
      )),
      fluidRow(column(width = 12,
        div(class = 'col-md-6', downloadButton('downloadEdgeList', 'Edge list')),
        div(class = 'col-md-6',downloadButton('download_seedset', 'Seed set'))
      ))
    )
  ),
  column(width = 9,
      tabsetPanel( id = "metabolicnet",
        #Network
        tabPanel("Network",
          list(actionButton("draw_network", "Draw Network"),
            h5('Visualization of the selected seed set metabolic network, 
              be patient.'),
            uiOutput('plot_net2'),
            htmlOutput("seednet_description"),
            htmlOutput("seednode_length"),
            htmlOutput("seededge_length")
          )),#height = "100%"
        
        #edge 3list
        tabPanel("Edge List", list(
          ##actionButton("show_connection", "Edge List"),
          shiny::dataTableOutput("network_edgelist")
          ##tableOutput("network_edgelist")
        )),
        tabPanel("Seed Set", list(
          shiny::dataTableOutput("net_seeds_confidence")
          ##uiOutput("plot_net2"),
        
      ))
   )
  )
)


# interaction page ----------------------------------------------------------

interactionpage = fluidPage(
  column(width = 3, 
    wellPanel(
      img(src = "images/logo.png"),
      tags$head(tags$style(
        type="text/css",
        "img {max-width: 100%; width: 100%; height: auto}"
      ))
    ),
    wellPanel(
      h5('Download interactions'),
      fluidRow(column(width = 12,
        helpText('Competition'),
        div( class = 'col-md-6', 
          downloadButton('download_competition', 'Index')
        ),
        div(class = 'col-md-6',
          downloadButton('download_competition_p', 'pvalue')
        )
      )),
      helpText('Complementarity'),
      fluidRow(column(width = 12,
        div( class = 'col-md-6', 
          downloadButton('download_complementarity', 'Index')
        ),
        div(class = 'col-md-6',
          downloadButton('download_complementarity_p', 'pvalue')
        )
      ))
    ),
    wellPanel(
      helpText(HTML("<b>VERSION CONTROL</b>")),
      HTML('Version 0.1.1'),
      HTML('<br>'),
      HTML('Updated on 21-Mar-2016'),
      HTML('<br>'),
      HTML('<a href="https://github.com/yiluheihei/shiny-RevEcoR" 
        target="_blank">Code on GitHub</a>')
      ),
    wellPanel(
      tags$p("Yang Cao"),
      tags$p("Beijing Institute of Radiation Medicine"),
      tags$p("Department of Biotechnology"),
      tags$p("Email:", tags$a(href="mailto:yiluheihei@gmail.com",
        "yiluheihei@gmail.com"))
    ),
    wellPanel(
      helpText(HTML("<b>OTHER Links</b>")),
      HTML('<a href="https://github.com/yiluheihei/RevEcoR" target="_blank"
        >RevEcoR Package</a>,'),
      HTML('<a href="https://github.com/yiluheihei" 
        target="_blank">Github Page</a>.')
    )
  ),
  column(width = 9,
    tabsetPanel( id = "cooperationIndex",
      tabPanel("Competition index",
        list(actionButton("compute_interaction", "Compute interactions"),
          h5('Calculation of species interactions is the most time-consuming module
            of shiny-RevEcoR, which may take minutes, hours and even several days
            according to the number of species, please keep patient.'),
          htmlOutput('competition_message'),
          HTML('<br/>'),
          shiny::dataTableOutput('competition_index'),
          htmlOutput('competition_p_message'),
          HTML('<br/>'),
          shiny::dataTableOutput('competition_index_p')
        )
      ),
      tabPanel("complementairty index",
        list(
          htmlOutput('complementarity_message'),
          HTML('<br/>'),
          shiny::dataTableOutput('complementarity_index'),
          htmlOutput('complementarity_p_message'),
          HTML('<br/>'),
          shiny::dataTableOutput('complementarity_index_p')
        )
      )
    )
  )
)


shinyUI(navbarPage(theme = shinytheme("flatly"),"shiny-RevEcoR",
  tabPanel("Introduction", intropage),
  tabPanel("Data", datapage),
  tabPanel("Metabolic Network and Seed set", netpage),
  tabPanel("Species Interactions",interactionpage),
  navbarMenu("Help",
    tabPanel("Getting started", helppage('docs/start.md')),
    tabPanel("Data input", helppage('docs/inputdata.md')),
    tabPanel("Metabolic network and Seed set", 
      helppage("docs/net_seed.md")),
    tabPanel("Species interactions", helppage("docs/interactions.md")),
    tabPanel("FAQ",helppage("docs/FAQ.md")),
    tabPanel("Video",helppage("docs/video.md"))
  ),
  collapsible = TRUE
))