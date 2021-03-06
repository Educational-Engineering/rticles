#' E.Tutorial Booklet for online distribution
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
#' draft("MyArticle.Rmd", template = "et_booklet_de", package = "eTutorialsLayout")
#' }
#'
#' @export
et_booklet_de <- function(..., keep_tex = F) {

  inherit_pdf_document(...,
                       template = find_resource("et_booklet_de", "template.tex"),
                       keep_tex = keep_tex)
}

