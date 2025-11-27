library(tidyverse)
library(phyloseq)
library(microViz)
library(qiime2R)
library(gtools)

source("./src/q2obj.r")

phyloseq_object <- load_q2obj()

natural_sorted <- phyloseq_object %>%
    sample_data() %>%
    as.data.frame() %>%
    {
        rownames(.)[mixedorder(.$RawID)] # RawIDを対象とする
    }


composition_barplot <- phyloseq_object %>%
    comp_barplot(
        tax_level = "Genus",
        sample_order = natural_sorted,
        label = "RawID",
        n_taxa = 41, # brewerPlusは最大個まで色分けできる
        palette = distinct_palette(n = 41, pal = "brewerPlus", add = "gray"),
        bar_outline_colour = NA,
        bar_width = 0.9,
    ) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


ggsave("barplot.svg", plot = composition_barplot, width = 16, height = 9, dpi = 600)
