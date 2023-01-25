# Extract SNPs/Samples from the HRS geno file                   
plink_call=/Users/Mingzhou/Downloads/plink_mac_20230116/plink

# hrs genetics --hg37 
geno_path=/Users/Mingzhou/Desktop/AD_Grant/Smoking_MR/data/genome/
geno_file=chrALL
genorn=${geno_path}${geno_file}

sumstats_path=/Users/Mingzhou/Desktop/AD_Grant/smk_dem_MR/data/sumstats/sig_snps/
finalsnplist=${sumstats_path}candidate_AD_wdup.txt

# candidate_SI_wdup.txt candidate_CPD_wdup.txt  candidate_AI_wdup.txt candidate_SC_wdup.txt

#====== Extract HRS =======
genout_path=/Users/Mingzhou/Desktop/AD_Grant/smk_dem_MR/data/genome/
genoex=${genout_path}${geno_file}.indsig.AD

$plink_call --noweb --allow-no-sex --bfile ${genorn} --extract ${finalsnplist} --make-bed --out ${genoex}