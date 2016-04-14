#' Journal of Statistical Software (JSS) format.
#'
#' Format for creating a Journal of Statistical Software (JSS) articles. Adapted
#' from
#' \href{http://www.jstatsoft.org/about/submissions}{http://www.jstatsoft.org/about/submissions}.
#'
#' @inheritParams rmarkdown::pdf_document
#' @param ... Arguments to \code{rmarkdown::pdf_document}
#'
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("MyArticle.Rmd", template = "jss_article", package = "rticles")
#' }
#'
#' @export
et_booklet_de <- function(..., keep_tex = TRUE) {

  template <- find_resource("et_booklet_de", "template.tex")

  base <- inherit_pdf_document(..., template = template, keep_tex = keep_tex)

  # Mostly copied from knitr::render_sweave
  base$knitr$opts_knit$out.format <- "sweave"

  base$knitr$opts_chunk$prompt <- TRUE
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$highlight <- FALSE

  base$knitr$opts_chunk$dev.args <- list(pointsize = 11)
  base$knitr$opts_chunk$fig.width <- 4.9 # 6.125" * 0.8, as in template
  base$knitr$opts_chunk$fig.height <- 3.675 # 4.9 * 3:4
  base$knitr$opts_chunk$fig.align <- "center"

  ## a common hook for messages, warnings and errors
  hook_lst_bf = function(x, options) {
    paste("\\begin{lstlisting}[basicstyle={\\bfseries}]\n", x,
          "\\end{lstlisting}\n", sep = "")
  }
  knit_hooks$set(source = function(x, options) {
    paste("\\begin{lstlisting}[language=R,numbers=left,stepnumber=2]\n", x,
          "\\end{lstlisting}\n", sep = "")
  }, output = function(x, options) {
    paste("\\begin{lstlisting}[basicstyle={\\ttfamily}]\n", x,
          "\\end{lstlisting}\n", sep = "")
  }, warning = hook_lst_bf, message = hook_lst_bf, error = hook_lst_bf)

  ## empty highlight header since it is not useful any more
  set_header(highlight = "")

  base$knitr$knit_hooks$chunk   <- hook_chunk
  base$knitr$knit_hooks$source  <- hook_input
  base$knitr$knit_hooks$output  <- hook_output
  base$knitr$knit_hooks$message <- hook_output
  base$knitr$knit_hooks$warning <- hook_output
  base$knitr$knit_hooks$plot <- knitr::hook_plot_tex

  base
}

