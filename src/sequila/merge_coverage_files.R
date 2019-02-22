# Load packages
library(sequila)
library(parallel)
library(data.table)
library(reshape)
library(dplyr)

# command line arguments
args = commandArgs(trailingOnly=TRUE)
baseCovPath = args[1]
genCovPath = args[2]
outputPath = args[3]

#Set Spark parameters and connect
driver_mem <- "40g"
master <- "local[20]"
ss<-sequila_connect(master,driver_memory<-driver_mem)

#create db
sequila_sql(ss,query="CREATE DATABASE sequila")
sequila_sql(ss,query="USE sequila")

#read coverage files
files <- list.files(path=baseCovPath, pattern="*.csv", full.names=TRUE, recursive=FALSE)
baseCov <- matrix(nrow=0, ncol=6)
for (file in files) {
    tmpCov <- read.table(file, header=FALSE, sep=",")
    if (nrow(baseCov)==0){baseCov <- matrix(nrow=0, ncol=ncol(tmpCov))}
    baseCov <- rbind(baseCov, tmpCov)
}
colnames(baseCov) <- c("sample","chr","st_bp","ed_bp","length","cov")

files <- list.files(path=genCovPath, pattern="*.csv", full.names=TRUE, recursive=FALSE)
genCov <- matrix(nrow=0, ncol=6)
for (file in files) {
    tmpCov <- read.table(file, header=FALSE, sep=",")
    if (nrow(genCov)==0){genCov <- matrix(nrow=0, ncol=ncol(tmpCov))}
    genCov <- rbind(genCov, tmpCov)
}
colnames(genCov) <- c("sample","chr","st_bp","ed_bp","length","cov")

#merge coverages
#TODO

#create a table with target data
cov <- '/home/dnaasm/CNV/bamgineer-sequila/results_bamgineer/cov/gen/20LOSSB255000_HAP2.bam.csv'
sequila_sql(ss,'genCov',paste('CREATE TABLE targets (Sample string, Chr string, Start integer, End integer, Len integer, Cov integer)
USING csv
OPTIONS (path "', cov, '", header "false", inferSchema "false", delimiter ",")',sep=""))
