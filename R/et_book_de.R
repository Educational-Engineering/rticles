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
et_book_de <- function(..., keep_tex = T) {
  inherit_pdf_document(...,
                       template = find_resource("et_book_de", "template.tex"),
                       keep_tex = T)
}


#' Loads one Chapter and generates Latex Code for it
#'
#' @export
loadChapter <- function(path = NULL,
                  copyFigures = T,
                  displayKeywords = F){

  filename <- tools::file_path_as_absolute(path)
  if(copyFigures) {
    currentfiles <- list.files(path=paste0(dirname(filename), '/figures'), full.names = T, include.dirs = T, recursive = T)
    newlocation <- tools::file_path_as_absolute("./figures")
    file.copy(from=currentfiles, to=newlocation,
              overwrite = F, recursive = FALSE,
              copy.mode = TRUE)
  }

  # Read in the lines of your file
  lines <- readLines(filename)
  # Find the header portion contained between the --- lines.
  header_line_nums <- which(lines == "---") + c(1, -1)
  # Create a string of just that header portion
  header <- paste(lines[seq(header_line_nums[1],
                            header_line_nums[2])],
                  collapse = "\n")
  # parse it as yaml, which returns a list of property values
  metadata <- yaml::yaml.load(header)
  #metadata$content <- paste0("\n", paste(
    #gsub("^#","##",lines[-seq(0,header_line_nums[2]+1)])
    #, collapse = "\n"))

  metadata$content <- "\n"
  isCode <- FALSE
  for (l in lines[-seq(0,header_line_nums[2]+1)]) {
    if (grepl("^~~~", l)) {
      isCode <- !isCode
    }
    if (!isCode) {
      metadata$content <- paste0(metadata$content, gsub("^#","##", l), "\n")
    } else {
      metadata$content <- paste0(metadata$content, l, "\n")
    }
  }


  result <- ""
  if(displayKeywords){
    result <- paste(
        "\\cleardoublepage", #only if chapter
        "\\refstepcounter{part}",
        "\\addcontentsline{toc}{part}{\\protect\\numberline{\\thepart}", metadata$title$main, "}",
        "\\par",
        "\\raisebox{0\\height}{\\includegraphics[width=0.25\\textwidth]{figures/Logo.png}}",
        "\\hfill",
        "\\raisebox{10pt}{\\includegraphics[width=0.25\\textwidth]{figures/teachITLogo.png}",
        "}",
        "\\par",
        "\\begin{center}",
        "\\noindent\\rule{\\textwidth}{0.4pt}\\\\",
        "\\vspace{0.5 cm} {\\large \\textsf{",metadata$title$course,"}}\\\\",
        "\\vspace{0.5 cm} {\\LARGE \\textbf{ \\textsf{", metadata$title$main," }}}\\\\",
        "\\vspace{0.5 cm} {\\Large \\textsf{", metadata$title$subtitle,"}}\\\\",
        "\\noindent\\rule{\\textwidth}{0.4pt}\\\\",
        "\\vspace{1 cm}Autoren: \\\\ \\vspace{2 mm}", paste(unlist(metadata$author), collapse=", "),"\\\\",
        "\\end{center}",
        "\\section*{Begriffe}",
        "\\begin{minipage}{\\textwidth}",
        "\\hrule",
        "\\begin{multicols}{2}",
        "\\begin{itemize}[leftmargin=0mm]",
        paste("\\item[]", metadata$keywords, collapse = " "),
        "\\end{itemize}",
        "\\end{multicols}",
        "\\vspace{-2mm}",
        "\\hrule",
        "\\end{minipage}"
      , collapse = "")
  }
  result <- paste(result,
                  "\\clearpage",
                  "\\begingroup",
                  "\\let\\clearpage\\relax",
                  "\\let\\cleardoublepage\\relax",
                  "\\chapter{", metadata$title$subtitle,"}",
                  "\\endgroup \n\n",
                  metadata$content[1]
                  , collapse = "")

  cat(knitr::knit_child(text = result, quiet=T))
}

