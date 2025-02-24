#############################################################################################################################################
###### HackBio project - Advanced Genomics Course: Bioinformatics for Cancer Biology -- Biomarker Discovery for Early Cancer Detection  #####
#############################################################################################################################################

# set working directory
setwd("C:/Users/agdad/Desktop/New folder/HackBio/corsi_HackBio/project_2")

#load necessary libraries 
library("TCGAbiolinks")
library(SummarizedExperiment)
library(gplots)
library(ggplot2)
library(biomaRt)
library(dplyr)

# get project information for TCGA-PAAD
getProjectSummary("TCGA-PAAD")

# download the dataset for primary tumors and normal tissue
tcga_paad <- GDCquery(project = "TCGA-PAAD",
                      data.category = "Transcriptome Profiling",
                      data.type = "Gene Expression Quantification",
                      sample.type = c("Primary Tumor", "Solid Tissue Normal"))
GDCdownload(tcga_paad) 
paad_data <- GDCprepare(tcga_paad) 
head(paad_data) 

# explore metadata information
paad_data$barcode 
table(paad_data$ajcc_pathologic_stage) 
table(paad_data$sample_type) # 178 tumors, 4 normal samples

# create a simple metadata dataframe
metadata_df <- data.frame("barcode" = paad_data$barcode,
                          "stage" = paad_data$ajcc_pathologic_stage,
                          "type" = paad_data$sample_type)
View(metadata_df)
table(metadata_df$type, metadata_df$stage)

# filter out samples with NAs, stage 0, III and IV
metadata_df <- metadata_df %>% 
  filter(!is.na(metadata_df$stage) &
           metadata_df$stage == "Stage IA" | metadata_df$type == "Solid Tissue Normal")
dim(metadata_df)
table(metadata_df$stage) 

# get the raw expression data
paad_rawdata <- assays(paad_data)
dim(paad_rawdata$unstranded)

# downsize the data to 4 vs 4
samples <- c(subset(metadata_df, type == "Solid Tissue Normal")$barcode,
             subset(metadata_df, type == "Primary Tumor")$barcode)
final_df <- paad_rawdata$unstranded[,c(samples)]
dim(final_df)

# normalization and filtering
table(is.na(final_df)) # no NAs

norm_data <- TCGAanalyze_Normalization(tabDF = final_df, geneInfo = geneInfoHT, method = "geneLength")

filt_data <- TCGAanalyze_Filtering(tabDF = norm_data,
                                   method = "quantile",
                                   qnt.cut = 0.25)

# differential expression analysis
DEA <- TCGAanalyze_DEA(mat1 = filt_data[ , c(samples)[1:4]], # normal (control)
                       mat2 = filt_data[ , c(samples)[5:8]],
                       Cond1type = "Normal",
                       Cond2type = "Tumor",
                       pipeline = "edgeR")

DEA.Level <- 
  TCGAanalyze_LevelTab(DEA, "Normal", "Tumor",
                       filt_data[ , c(samples)[1:4]],
                       filt_data[ , c(samples)[5:8]])
View(DEA.Level)

# annotation
gene_names <- rownames(DEA.Level)
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
annot <- getBM(
  attributes = c('ensembl_gene_id', 'hgnc_symbol', 'description'),
  filters = 'ensembl_gene_id',
  values = gene_names,
  mart = mart)

# merge 
DEA.Level$ensembl_gene_id <- rownames(DEA.Level)
DEA.Level <-  DEA.Level %>%
  left_join(annot, by = 'ensembl_gene_id')

# filtering significant genes
DEGs <- DEA.Level
DEGs$status <- "NO"
DEGs$status[DEGs$logFC > 2 & DEGs$FDR < 0.01] <- "UP"
DEGs$status[DEGs$logFC < (-2) & DEGs$FDR < 0.01] <- "DOWN"
table(DEGs$status) # down 263, up 477
DEGs_df <- DEGs[DEGs$status == "UP"| DEGs$status == "DOWN", ] # 740 DEGs 

# heatmap of 740 DEGs
DEGs_list <- c(subset(DEGs, status == "UP")$mRNA,
              subset(DEGs, status == "DOWN")$mRNA)
heat.DEGs <- filt_data[DEGs_list, ]
DEGs_symbol <- DEGs$hgnc_symbol[match(rownames(heat.DEGs), DEGs$ensembl_gene_id)]
rownames(heat.DEGs) <- DEGs_symbol

# check for NAs
table(is.na(rownames(heat.DEGs))) # 11 NAs
no_NAs <- !is.na(rownames(heat.DEGs))
heat.DEGs <- heat.DEGs[no_NAs, ]
dim(heat.DEGs) # 729

# check for duplicated genes


# color code
type <- c(rep("Normal", 4), rep("Tumor", 4))
ccodes <- c()
for (i in type) {
  if ( i == "Normal") {
    ccodes <- c(ccodes, "red") # normal is red 
  } else {
    ccodes <- c(ccodes, "blue") # tumor is blue
  }
}

# heatmap
heatmap.2(x = as.matrix(heat.DEGs),
          col = hcl.colors(10, palette = 'Blue-Red 2'),
          Rowv = F, Colv = T,
          scale = 'row',
          sepcolor = 'black',
          trace = "none",
          key = TRUE,
          dendrogram = "col",
          cexRow = 0.9, cexCol = 0.7,
          main = "Heatmap of Normal Samples vs Early-Stage Pancreatic Tumors",
          na.color = 'black',
          ColSideColors = ccodes,
          margins = c(11,10))
legend("left",                       
       legend = c("Normal", "Tumor"),     
       col = c("red", "blue"),           
       lty = 1,                          
       lwd = 4,                         
       cex = 0.7,
       xpd = TRUE,
       inset = c(-0.39, 1.5))

# volcano plot
