#' Build all pdfs in a folder
#'
#' This expects to have on .Rmd file per output file
#'
#' @export
build_pdfs <- function() {
  lapply(list.files(pattern = ".Rmd$", recursive = TRUE), function(f){rmarkdown::render(f, output_dir = "pdf",clean = T)})
}
