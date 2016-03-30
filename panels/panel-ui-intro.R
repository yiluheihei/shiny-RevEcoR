intropage = fluidPage(
  column(width = 3,
    wellPanel(
      img(src = "logo.png", width = 220)
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
    ##h4("Introduction to shiny-RevEcoR"),
    tabPanel("introduction",includeMarkdown("docs/introduction.md"))
  )
)



