## Metabolic network reconsruction seed set  identity

Once annotation profile in the correct format was uploaded, the "Metabolic network and Seed set" panel supports genome scale metabolic network reconstruction, visualization, and seed set identity. The sidebar of this panel supports comprehensive settings for network analyis. Graph-based representation of metabolic reactions where nodes represent compounds and edges represent reactions is a common tool in analyzing and studying metabolic networks. A directed edge from node a to b indicates that compound a is a substrate in some reaction that produces compound b

As the interactions with the environment was reflected in the metabolic networks, these networks could be used not only to infer metabolic function but also to obtain insights into the growth environments in which the species evolved. The seed set of the network is defined as the minimal set of compounds in the network that allows the synthesis of all other compounds, and can serve as a good proxy for its environment and can be conceived as the essential and effective biochemical environment.

 This panel was used to metabolic network reconstruction and the seed set identity of a given network, and colored the seed with a user-specific color by setting color used to highlight the seed in the network. 


#### Settings

1. The  **Network structure** section of sidebar is to set the dimension of metabolic network and choose what parts of the network should be considered meaningful and be used for the further analysis. Width and height used to adjustment the width and height of the graph. 

- Species name: select the species (obtained from the uploaded data) whose metabolic network was reconstructed.

-  layout: the methods used to calculate the coordinates of the vertices for a network usually based on some optimality criterion, currently, "eigen", "random", "circle", "hall", "fruchtermanreingold", "kamadakawai", "spring", "target", "mds" and "princood" is supported, default value is fruchtermanreingold. More details see the `gplot.layout` in **sna** package.

- Confidence: seed set's confidnece score higher than this threshold is take into subsequent analyis.

- Seed color:the color of the seed set to show in the right main panel, default is red. All strings starting with "\#" are assumed to be RGB color specifications. If you don't want (some) vertices to have any color, supply NA as the color name. 

- Ignore all nodes except those in the giant component: selecting the only main largest component (connected set of nodes) of the network. All smaller components will be ignored. This is a good option for networks with a dominant component.

- Ignore small component: Nodes belonging to components with fewer than the value of threshold nodes will be ignored. This is a good option for networks that contain many small and trivial components. (Default is 0: Analyze all nodes.)

2. **Aesthetic Mapping** was used to set the parameters of the node and edges for  metabolic network:

- vertex size: the node size of the network, all node sizes must be strictly positive default is 3; 

- vertex.color : the color of the node, default value is blue. All strings starting with "\#" are assumed to be RGB color specifications. If you don't want (some) vertices to have any color, supply NA as the color name.

- arrow size: the size of the arrows for directed network edges, in points. Defaults to 0 (no arrows)..

- edge size: the size of the edges, in points, as a numeric value, a vector of numeric values, or as an edge attribute containing numeric values. All edge sizes must be strictly positive. Defaults to 0.25

3. Dimension and Download, figure dimensions and download button

- Figure width and height

- Download figure
  - Format: figure format,  now supportd eps, pdf, jpeg, tex, tiff, png, bmp, svg format, default is pdf.
  - Download: download the figure locally and saved as the format as in `Format` selectbox.
- Download the edgelist of metabolic network and the identified seed set as a tab-separated file locally.

###  Network reconstruction, visualization and seed set identity

After setting is complete, metabolic network will be reconstructed and visualized by clicking the `Draw network` button on the `Network` tab-panel. Meanwhile, seed set of the metabolic network also identified, network edgelist and seed set information is list on the `Edge list` and `Seed set` tab-panel.  


