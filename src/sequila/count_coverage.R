# Load packages
library(sequila)
library(parallel)
library(data.table)
library(reshape)
library(dplyr)

# command line arguments
args = commandArgs(trailingOnly=TRUE)
bed = args[1]
bam = args[2]

#Set Spark parameters and connect
driver_mem <- "40g"
master <- "local[20]"
ss<-sequila_connect(master,driver_memory<-driver_mem)

#create db
sequila_sql(ss,query="CREATE DATABASE sequila")
sequila_sql(ss,query="USE sequila")

#create a BAM data source with reads
sequila_sql(ss,'reads',paste('CREATE TABLE reads USING org.biodatageeks.datasources.BAM.BAMDataSource OPTIONS(path "',bam,'")',sep=""))

# Check out the reads
sequila_sql(ss, query= "select * from reads limit 10")

#create a table with target data
sequila_sql(ss,'targets',paste('CREATE TABLE targets (Chr string, Start integer,End integer, v1 string)
USING csv
OPTIONS (path "', bed, '", header "false", inferSchema "false", delimiter "\t")',sep=""))

#inspect content of targets table
sequila_sql(ss, query= "select * from targets limit 10")

query <- "SELECT SampleId, Chr ,targets.Start ,targets.End ,CAST(targets.End AS INTEGER)-
                           CAST(targets.Start AS INTEGER) + 1 AS Length, count(*) AS Counts
            FROM reads
            JOIN targets ON (Chr=reads.contigName AND reads.end >= CAST(targets.Start AS INTEGER)
                                                  AND reads.start <= CAST(targets.End AS INTEGER))
            GROUP BY  SampleId, Chr, targets.Start, targets.End"

res <- sequila_sql(ss,'results',query)
readCountPerTarget <-  collect(res)
head(readCountPerTarget)

#readCountPerTarget[readCountPerTarget$Start > 255000 & readCountPerTarget$Start < 265000,]
