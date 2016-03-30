## Species interactions prediction

The topology of metabolic networks can provide insight not only into the metabolic process that accur within each species, but also into interactions between different species. Here we provides `caculateCoopreationIndex` using three cooperation index: competition index, complementarity index measure the microbe-microbe co-occurrence pattern and host-microbe.

Metabolic competition index is defined as the fraction of compounds in a species seed set of metabolic network that are also included in its partner; However, metabolic complementarity index is the fraction of compounds in one species seed set of metabolic network appearing in the metabolic network but not in the seed set of its partner. However, seed compounds are associated with a confidence score (1/size of SCC), so this fraction is calculated as a normalized weighted sum.

Based on the metabolic network and seed set calculated in previous step, this page help us to predict the species interactions. Press the `Compute interactons` button to start the calculation. 

In addition, we calculate the p value to determine biological significance of competition and complementarity index. P value of interactions is obtained as equation `(r+1)/(n+1)`, where n is the number of random samples. And r is the number of greater than or equal to competition index (for competition index),  or  the number of less than or equal to complementarity index (for complemenatiry index).


Note Calculation of species interactions is the most time-consuming module of shiny-RevEcoR, which may take minutes, hours and even several days depend on the number of species to analyis. Specifically, it takes about five minutes to analysis the built-in sample data which contains annotation profiles of seven species. The results is shown on the `Competition index` and `Complementarity index` tab-panel, and could be saved as tab-seprated file with the `Download` button in the sidebar.


## SessionInfo

```R
 [1] "R version 3.2.4 (2016-03-10)"                                                    
 [2] "Platform: x86_64-apple-darwin13.4.0 (64-bit)"                                    
 [3] "Running under: OS X 10.11.2 (El Capitan)"                                        
 [4] ""                                                                                
 [5] "locale:"                                                                         
 [6] "[1] zh_CN.UTF-8/zh_CN.UTF-8/zh_CN.UTF-8/C/zh_CN.UTF-8/zh_CN.UTF-8"               
 [7] ""                                                                                
 [8] "attached base packages:"                                                         
 [9] "[1] stats     graphics  grDevices utils     datasets  methods   base     "       
[10] ""                                                                                
[11] "other attached packages:"                                                        
[12] " [1] scales_0.4.0      sna_2.3-2         markdown_0.7.7    rmarkdown_0.9.2  "    
[13] " [5] igraph_1.0.1      network_1.13.0    intergraph_2.0-2  plyr_1.8.3       "    
[14] " [9] svglite_1.1.0     magrittr_1.5      GGally_1.0.1      RevEcoR_0.99.3   "    
[15] "[13] shinythemes_1.0.1 shiny_0.13.1     "                                        
[16] ""                                                                                
[17] "loaded via a namespace (and not attached):"                                      
[18] " [1] Rcpp_0.12.4        tools_3.2.4        digest_0.6.9       jsonlite_0.9.19   "
[19] " [5] gtable_0.2.0       lattice_0.20-33    Matrix_1.2-4       stringr_1.0.0.9000"
[20] " [9] gdtools_0.0.7      gtools_3.5.0       grid_3.2.4         reshape_0.8.5     "
[21] "[13] R6_2.1.2           XML_3.98-1.4       ggplot2_2.1.0      purrr_0.2.1       "
[22] "[17] htmltools_0.3.5    rsconnect_0.4.2    mime_0.4           xtable_1.8-2      "
[23] "[21] colorspace_1.2-6   httpuv_1.3.3       stringi_1.0-1      munsell_0.4.3     "
```
  

