# This script includes all functions used in the dementia genetic prediction project
# Listed below
# 1. '%!in%': not in

#=================================================
'%!in%' = function(x,y)!('%in%'(x,y))

#=================================================
# Extract OR values for MR table
extract_MR = function(mr_obj, exposure, method_lst) {
  
  tbl_to_extract = mr_obj %>% filter(method %in% method_lst)
  mr_table = array(NA, dim = c(length(method_lst), 8))
  OR = exp(tbl_to_extract$b)
  lower_OR_CI = exp(tbl_to_extract$b - 1.96*tbl_to_extract$se)
  upper_OR_CI = exp(tbl_to_extract$b + 1.96*tbl_to_extract$se)
  OR_CI_95 = paste0(sprintf('%.2f', OR), ' (', sprintf('%.2f', lower_OR_CI), ', ', sprintf('%.2f', upper_OR_CI), ')')
  p = round(tbl_to_extract$pval, 4)
  
  mr_table[,1] = exposure
  mr_table[,2] = tbl_to_extract$method
  mr_table[,3] = tbl_to_extract$nsnp
  mr_table[,4] = tbl_to_extract$b
  mr_table[,5] = tbl_to_extract$se
  mr_table[,6] = OR
  mr_table[,7] = OR_CI_95
  mr_table[,8] = p
  
  mr_table_final = as.data.frame(mr_table) 
  colnames(mr_table_final) = c('exposure','method', 'nsnp', 'b', 'se', 'OR', 'OR_95CI', 'pval')
  mr_table_final = mr_table_final %>% mutate(nsnp = as.numeric(nsnp), b = as.numeric(b), se = as.numeric(se),
                                             OR = as.numeric(OR), pval = as.numeric(pval))
  
  return(mr_table_final)
}

#=================================================
PVEfx = function(BETA, MAF, SE, N){ 
  pve = (2*(BETA^2)*MAF*(1 - MAF))/
    ((2*(BETA^2)*MAF*(1 - MAF)) + ((SE^2)*2*N*MAF*(1 - MAF))) 
  return(pve) 
} 

#=================================================
# Function to calculate OR and 95% CI from beta and SE
calculate_or_and_ci = function(beta, se) {
  # Calculate OR
  or = exp(beta)
  
  # Calculate lower and upper bounds of 95% CI
  ci_lower <- exp(beta - 1.96 * se)
  ci_upper <- exp(beta + 1.96 * se)
  
  # Return results as a list
  return(list(OR = or, CI_lower = ci_lower, CI_upper = ci_upper))
}

# Example usage:
beta = 0.005        # Example beta coefficient
se = 0.001   # Example standard error

result <- calculate_or_and_ci(beta, se)
print(result)

#=================================================
# Calculating for 10 additional years
OR_1 = 1.01
CI_lower_1 = 1.001
CI_upper_1 = 1.02

OR_10 = OR_1^10
CI_lower_10 = CI_lower_1^10
CI_upper_10 = CI_upper_1^10

# Results
OR_10
CI_lower_10
CI_upper_10
