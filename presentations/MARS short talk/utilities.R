colorize <- function(x, color) {
#3 https://bookdown.org/yihui/rmarkdown-cookbook/font-color.html#using-an-r-function-to-write-raw-html-or-latex-code
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, x)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color,
      x)
    } else x
    }