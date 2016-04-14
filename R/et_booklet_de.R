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

  inherit_pdf_document(...,
                       template = find_resource("et_booklet_de", "template.tex"),
                       keep_tex = keep_tex)
}

