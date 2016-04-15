
### Installation

You can install and use **eTutorialsLayout** from CRAN as follows:


```r
devtools::install_github("Educational-Engineering/rticles")
```


### Overview

The **eTutorialsLayout** package provides a suite of custom [R Markdown](http://rmarkdown.rstudio.com) LaTeX formats and templates for varoius formats, including:

Under the hood, LaTeX templates are used to ensure that documents conform precisely to submission standards. At the same time, composition and formatting can be done using lightweight [markdown](http://rmarkdown.rstudio.com/authoring_basics.html) syntax, and R code and its output can be seamlessly included using [knitr](http://yihui.name/knitr/).

Using **eTutorialsLayout** has some prerequisites which are described below. You can get most of these pre-requisites automatically by installing the latest release of RStudio (instructions for using **eTutorialsLayout** without RStudio are also provided).

### Using eTutorialsLayout from RStudio

To use **eTutorialsLayout** from RStudio:

1) Install the latest [RStudio](http://www.rstudio.com/products/rstudio/download/).

2) Install the **eTutorialsLayout** package: 
    
    devtools::install_github("Educational-Engineering/eTutorialsLayout")
    
3) Use the **New R Markdown** dialog to create an article from one of the templates:

 ![New R Markdown](http://rmarkdown.rstudio.com/images/new_r_markdown.png)
    
    
### Using eTutorialsLayout outside of RStudio

1) Install [pandoc](http://johnmacfarlane.net/pandoc/) using the [instructions for your platform](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md).

2) Install the **rmarkdown** and **eTutorialsLayout** packages:

    
    install.packages("rmarkdown")
    devtools::install_github("Educational-Engineering/rticles")
    
    
3) Use the `rmarkdown::draft` function to create articles:

    
    rmarkdown::draft("MyJSSArticle.Rmd", template = "et_booklet_de", package = "eTutorialsLayout")
    rmarkdown::draft("MyRJournalArticle", template = "et_booklet_en", package = "eTutorialsLayout")
    
