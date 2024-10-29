install.packages("tidyverse")

if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install(version = "3.19")
BiocManager::install(c(
  "AnnotationDbi",
  "org.Hs.eg.db",
  "TCGAbiolinks",
))
