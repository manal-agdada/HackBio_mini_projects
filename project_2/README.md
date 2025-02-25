# Biomarker Discovery for Early Cancer Detection

## Overview 
This project aims to identify potential biomarkers for early detection of pancreatic cancer (Pancreatic Adenocarcinoma: PAAD) by analyzing differential gene expression data from The Cancer Genome Atlas (TCGA). The focus is on detecting genes that are significantly expressed in early-stage pancreatic cancer (Stage IA) compared to normal pancreatic tissues. The project leverages RNA-seq data and includes data preprocessing, differential expression analysis, and functional enrichment analysis.

## Steps

### 1. Data Acquisition
- **Download RNA-seq data** for early-stage pancreatic cancer patients and normal controls from TCGA (**4** samples each).

### 2. Data Preprocessing
- **Normalization and Filtering**: Preprocess the data to remove low-expressed genes and normalize it for differential expression analysis.

### 3. Differential Expression Analysis
- **Gene Selection**: Identify genes that are significantly differentially expressed between early-stage pancreatic cancer samples and normal samples.
- **Significant Genes**: Filter for genes with a log2 fold change > 2 or < -2 and false discovery rate (FDR) < 0.01.

### 4. Visualization
- **Heatmap**: Visualize the differential expression of genes using a heatmap to show upregulated and downregulated genes.
- **Volcano Plot**: Create a volcano plot to identify the most significantly differentially expressed genes.

### 5. Functional Enrichment Analysis
- Perform **functional enrichment analysis** to explore the biological pathways and processes that these differentially expressed genes are involved in, including Gene Ontology (GO) and pathway analysis.


## Language
- R 4.4.2

## Required Libraries 

### Bioconductor Packages
- `TCGAbiolinks`
- `SummarizedExperiment`
- `biomaRt`

### CRAN Packages
- `gplots`
- `ggplot2`
- `dplyr`


## Data Description
- **Project**: TCGA-PAAD (Pancreatic Adenocarcinoma)
- **Sample Types**: Primary Tumor, Solid Tissue Normal
- **Data Category**: Transcriptome Profiling
- **Data Type**: Gene Expression Quantification

## Workflow Overview

1. **Load Data**: Download RNA-seq data from TCGA for early-stage pancreatic cancer (stage IA) and normal tissue samples.
2. **Preprocess Data**: Normalize and filter the data to prepare it for analysis.
3. **Differential Expression Analysis**: Use edgeR for differential expression analysis to identify genes that are significantly differentially expressed.
4. **Visualize Results**:
   - **Heatmap**: A heatmap to visualize gene expression changes between normal and tumor samples.
   - **Volcano Plot**: A volcano plot to show the distribution of genes based on fold change and FDR.
5. **Functional Enrichment**: Perform enrichment analysis to determine the biological relevance of the identified genes using Gene Ontology (GO) and pathway analysis.

## Results

- **Differentially Expressed Genes (DEGs)**: 
   - Upregulated: 477 genes
   - Downregulated: 263 genes
- **Visualization**:
   - Heatmap of the top differentially expressed genes
   - Volcano plot highlighting the most significant genes based on logFC and FDR
- **Functional Enrichment**:
   - Pathway analysis for up- and down-regulated genes

## Example Outputs

- Heatmap visualization of gene expression differences:

   ![heatmap](https://github.com/manal-agdada/HackBio_mini_projects/blob/main/project_2/Figures/project_2_heatmap.png)

- Volcano plot showing significant genes:

   ![volcanoplot](https://github.com/manal-agdada/HackBio_mini_projects/blob/main/project_2/Figures/project_2_volcanoplot.png)

## Conclusion


This analysis has identified key genes that are differentially expressed in early-stage pancreatic cancer compared to normal tissues, which could serve as potential biomarkers for early detection. Further investigation into the biological pathways these genes are involved in may offer new insights into pancreatic cancer biology and potential therapeutic targets.


## Installation Instructions

To run this [analysis](https://github.com/manal-agdada/HackBio_mini_projects/blob/main/project_2/project_2_script.R), you need to have R installed on your system along with the required packages. You can install the necessary packages using the following commands:

```r
# Install Bioconductor packages
BiocManager::install("TCGAbiolinks")
BiocManager::install("SummarizedExperiment")
BiocManager::install("biomaRt")

# Install CRAN packages
install.packages("gplots")
install.packages("ggplot2")
install.packages("dplyr")
