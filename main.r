library(tidyverse)
library(phyloseq)
library(microViz)
library(qiime2R)


pseq <- qza_to_phyloseq(
    features = "./q2objs/common_biology_free_table.qza",
    taxonomy = "./q2objs/common_biology_free_classification.qza",
    metadata = "./q2objs/metadata.tsv",
    tree = "./q2objs/biology_free_rooted_tree.qza"
) %>%
    tax_fix() %>%
    tax_fix(unknowns = c("uncultured"))

p <- pseq %>%
    comp_barplot(tax_level = "Genus") +
    coord_flip()

ggsave("barplot.svg", plot = p, width = 10, height = 8, dpi = 300)
