shiny-sandbox
=============

Testbox for Shiny package from RStudio

Apps include:

grn
-------

Reconstruct gene regulatory networks using the `ENA` package then visualize them using D3.js

rgl
------

Visualize color palettes from RColorBrewer using Shiny-friendly RGL.


simpleGeyeser
---------------

A simplified version of the Geyeser example provided by RStudio. Plots a histogram with the requested number of bins.

naiveGeyeser
-------------

An extension to the Geyeser example which supports an additional dataset but implements the server side all in a single function.

reactiveGeyeser
---------------

Demonstrates an improvement over the naiveGeyeser by separating out the dependent parts into reactive functions to demonstrate isolation of data import from analysis code.

