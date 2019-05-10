from ConfigParser import SafeConfigParser

### global variables ###
configReader = SafeConfigParser()
project_name = ''
infile = ''
cnv_bed = ''
cnv_length = 0
min_snps_per_exon = 0
number_of_cnvs = 0
sample_name = ''
chr = ''
cnv_list_dir = ''
cancer_type = ''
spltbams_path = ''
het_path = ''
nonhet_path = ''
outbamfn = ''
results_path = ''
java_path = ''
beagle_path = ''
picard_path = ''
samtools_path = ''
bedtools_path = ''
vcftools_path = ''
phase = False
ctDNA = False
singleXY = False

def InitConfigReader(configFile):
    """init the config file"""
    configReader.readfp(open(configFile))


def GetConfigReader():
    """return the configreader"""
    return configReader


def GetResultsPath():
    return results_path


def SetResultsPath(path):
    global results_path
    results_path = path


def GetSplitBamsPath():
    return spltbams_path


def SetSplitBamsPath(spltbams):
    global spltbams_path
    spltbams_path = spltbams


def SetCancerType(can_type):
    global cancer_type
    cancer_type = can_type


def GetCancerType():
    return cancer_type


def SetOutputFileName(out_bam_file):
    global outbamfn
    outbamfn = out_bam_file


def GetOutputFileName():
    return outbamfn


def SetLogPath(path):
    global log_path
    log_path = path


def GetLogPath():
    return log_path


def SetHetPath(path):
    global het_path
    het_path = path


def GetHetPath():
    return het_path


def SetNonHetPath(path):
    global nonhet_path
    nonhet_path = path


def GetNonHetPath():
    return nonhet_path


def SetJavaPath(path):
    global java_path
    java_path = path


def GetJavaPath():
    return java_path


def SetBeaglePath(path):
    global java_path
    java_path = path

def GetBeaglePath():
    return java_path

def SetPicardPath(path):
    global java_path
    java_path = path

def GetPicardPath():
    return java_path

def SetCNV(val):
    global cnv_bed
    cnv_bed = val

def GetCNV():
    return cnv_bed

def SetCnvLength(val):
    global cnv_length
    cnv_length = val

def GetCnvLength():
    return cnv_length

def SetMinSnpsPerExon(val):
    global min_snps_per_exon
    min_snps_per_exon = val

def GetMinSnpsPerExon():
    return min_snps_per_exon

def SetNumberOfCnvs(val):
    global number_of_cnvs
    number_of_cnvs = val

def GetNumberOfCnvs():
    return number_of_cnvs

def SetSampleName(val):
    global sample_name
    sample_name = val

def GetSampleName():
    return sample_name

def SetChr(val):
    global chr
    chr = val

def GetChr():
    return chr

def SetCNVDir(cnv_l):
    global cnv_list_dir
    cnv_list_dir = cnv_l


def GetCNVDir():
    return cnv_list_dir


def SetPhase(Phase):
    global phase
    phase = Phase


def GetPhase():
    return phase


def GetctDNA():
    return ctDNA


def SetctDNA(ctdna):
    global ctDNA
    ctDNA = ctdna


def GetXY():
    return singleXY


def SetXY(xy):
    global singleXY
    singleXY = xy


def SetSoftwarePath(j_path, b_path, p_path, s_path, bd_path, v_path, sb_path):
    configReader.set('SOFTWARE', 'java_path', str(j_path))
    configReader.set('SOFTWARE', 'beagle_path', str(b_path))
    configReader.set('SOFTWARE', 'picard_path', str(p_path))
    configReader.set('SOFTWARE', 'samtools_path', str(s_path))
    configReader.set('SOFTWARE', 'bedtools_path', str(bd_path))
    configReader.set('SOFTWARE', 'vcftools_path', str(v_path))
    configReader.set('SOFTWARE', 'sambamba_path', str(sb_path))


def GetSoftwarePath():
    java_path = configReader.get('SOFTWARE', 'java_path')
    beagle_path = configReader.get('SOFTWARE', 'beagle_path')
    picard_path = configReader.get('SOFTWARE', 'picard_path')
    samtools_path = configReader.get('SOFTWARE', 'samtools_path')
    bedtools_path = configReader.get('SOFTWARE', 'bedtools_path')
    vcftools_path = configReader.get('SOFTWARE', 'vcftools_path')
    sambamba_path = configReader.get('SOFTWARE', 'sambamba_path')

    return java_path, beagle_path, picard_path, samtools_path, bedtools_path, vcftools_path, sambamba_path
