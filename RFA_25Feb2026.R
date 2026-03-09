###############################################################################
# NAME: 

# PROGRAM :
################################################################################

###############################################################################
# Instructions:
# - Work directly in this file.
# - You may add small helper lines if needed, but keep solutions simple.
# - Datasets come from {pharmaverseadam}: ADSL and ADLB.
# - Note that questions 1 and 2, and also questions 9, 10 and 11 follow 
#    from each other, i.e. q2 uses the result from q1 as the input etc.
###############################################################################

# --- 0) Setup: packages + data ------------------------------------------------

# Install + load (installs only what's missing)
pkgs <- c("dplyr", "tidyr", "ggplot2", "pharmaverseadam")

to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install) > 0) install.packages(to_install)

invisible(lapply(pkgs, library, character.only = TRUE))

# Load required datasets
adsl <- pharmaverseadam::adsl
adlb <- pharmaverseadam::adlb


# --- QUESTION 1: Debugging        [2 points] ---------------------------------------------------- 
# The code below FAILS. In your own words (as comments), explain:
#   (1) why it fails
#   (2) how to fix it
# Then write a corrected version that creates adsl_2 properly.
#
# NOTE: The intended output is ADSL filtered to SAFFL == "Y", keeping columns
#       USUBJID, TRT01A, SEX (and anything else you need temporarily).


# This fails (do not change these lines)
adsl_2 <- adsl %>%
  select(USUBJID, TRT01A, SEX) %>%
  filter(SAFFL == "Y")


# (Write your explanation below)
# Explanation of why fails: 
#
# Explanation of how to fix it:


# Write your corrected code below (overwrite adsl_2 with a working pipeline)

# adsl_2 <- ...


# --- QUESTION 2: Counting   [2 points] ----------------------------------------------------- 
# Using the resulting data frame from Q1, 
#  obtain the number of FEMALE participants per treatment.
# Hints: filter, group_by, summarise, count, n(), etc.
#
# Expected output: a small table with TRT01A and n_female (or similar).

# female_by_trt <- adsl_2 %>% ...
# female_by_trt


# ------ QUESTION 3: Checking Class Types [2 points] -------------------------------------- 
# Identify the data type/class contained in ADLB$AVAL
# Create a new variable AVALC that contains the content of AVAL converted to character format

adlb1 <- adlb %>%
  filter(PARAMCD %in% c("ALB","ALT","AST","BILI")) %>%
  mutate(AVALC= #[update here]
  )

# What is the data type of AVAL?

# Show how you used a function to find out the data type.



# --- QUESTION 4: Missingness summary by PARAMCD [3 points] ------------------------------- 
# Complete the code to summarise ADLB by PARAMCD.
#
# Required columns in output:
# - n_records          : number of records in that PARAMCD
# - n_distinct_subs    : number of distinct participants (USUBJID) in that PARAMCD
# - n_missing_AVAL     : number of missing AVAL values
# - pct_missing        : % missing AVAL (0–100)
# - pct_missing_rounded: pct_missing rounded to 2 decimals
#
# Then arrange from MOST missing to LEAST missing.

adlb_param_summary <- adlb %>% 
  group_by(PARAMCD) %>%
  summarise(
    n_records = 0,              # answer in this line (replace the "0")
    n_distinct_subs = 0,        # answer in this line (replace the "0")
    n_missing_AVAL = 0,         # answer in this line (replace the "0")
    pct_missing = 0,           # answer in this line (replace the "0")
    pct_missing_rounded = 0,    # answer in this line (replace the "0")
    .groups = "drop"
  )   #%>%                     
# arrange your data here

# View result
adlb_param_summary


# --- QUESTION 5: Create a custom LOCF function [2 points] ------------------------------- 
# This code will use the fill function to use LOCF when a value of AVAL is missing
# Create and call a custom function to perform LOCF
# HINT: Function parameters should include the input dataset and the variable
#        on which the LOCF will be performed 

adlb_imp <- adlb %>% 
  # BILI and GLUC are selected here because they are the only parameters 
  #  with partial missingness in AVAL
  filter(PARAMCD %in% c("BILI","GLUC")) %>%
  arrange(USUBJID,PARAMCD,AVISITN) %>%
  group_by(USUBJID,PARAMCD) %>%
  tidyr::fill(AVAL, .direction = "down") %>% 
  ungroup()

# add code to call the function

# --- QUESTION 6: Add baseline GLUC to ADSL [2 points] ----------------------------------- 
# Add the baseline value of GLUC (PARAMCD == "GLUC") from ADLB into ADSL as a 
# new column called base_gluc. 
# Ensure gluc_data ends up ONE ROW per USUBJID.

gluc_data <- adlb %>%
  filter(PARAMCD == "GLUC") %>%
  # you can use the BASE value or filter it by ABLFL == "Y" 
  select(
    #  (select the two appropriate variables)
  )


# adsl_with_gluc <-  adsl join gluc_data,  Perform the appropriate join


# --- QUESTION 7: Derive AGEGR1 with case_when [2 points] -------------------------------- 
# Create AGEGR1 in ADSL (age group) using AGE:
#   "18-39"   if AGE < 40
#   "40-64"   if AGE between 40 and 64 (inclusive)
#   "65+"     if AGE >= 65
#   "Missing" if AGE is missing
#
# Then count participants by TRT01A and AGEGR1 (SAFFL == "Y").

adsl_age <- adsl %>%
  filter(SAFFL == "Y") %>%
  mutate(
    AGEGR1 = case_when(
      #  Add the required rules
      TRUE ~ NA_character_ 
    )
  )

agegr_counts <- adsl_age %>%
  count(TRT01A, AGEGR1)


# ---- QUESTION 8: Calculate duration [2 points] ----------------------------------------- 
# Create a new variable in ADSL called TRTDUR
# Calculate this variable as the difference in days between TRTSDT and TRTEDT
# Calculate TRTDURW as the difference in weeks
# TIP1: Remember we count the start and end days
# TIP2: TRTDURD is already present in the dataset for comparison

adsl2 <- adsl %>%
  mutate(
    TRTDUR = ,# [update here]
    TRTDURW = # [update here]
  ) 






# ---- QUESTION 9: Descriptive Statistics [3 points] -------------------------------------- 
# Calculate the basic statistics required for building a table
# HINT: Ensure to exclude missing values from calculations

ADLB_STATS <- adlb %>%
  filter(PARAMCD %in% c("ALB","ALT","AST","BILI")) %>%
  group_by(TRT01A, PARAMCD, PARAM) %>%
  summarise( 
    n     = # update,
      MEAN  = # update,
      SD    = # update,
      MIN   = # update,
      MAX   = # update,
      Q1    = # update,
      Q3    = # update,
      .groups = "drop"
  ) 

# ---- QUESTION 10: Concatenate columns to create new columns [2 points] ------------------- 
# Create new variables in ADLB_STATS (from Q9) called mean_sd, min_max and q1_q3 
# Concatenate the MEAN and SD columns to create mean_sd
# Concatenate the MIN and MAX columns to create min_max
# Concatenate the Q1 and Q3 columns to create q1_q3
# display the results in the format "mean (sd)", "min-max" and "q1-q3"
# EXTRA POINTS: Display 1dp for MEAN, MIN, MAX, Q1 and Q3, and 2dp for SD 

ADLB_STATS2 <- ADLB_STATS %>%
  mutate(
    mean_sd = ,# update,
    min_max = ,# update,
    q1_q3   =  # update   
  ) %>%
  select(TRT01A,PARAMCD,PARAM,n,mean_sd,min_max,q1_q3)

# ---- QUESTION 11: Transposing data frames [3 points] ------------------------------------ 
# Transpose ADLB_STATS2 (from Q10) from wide to long format
# The following columns should be present: TRT01A, PARAMCD, PARAM, STATISTICS, RESULT
# HINT: pivot...
# HINT: You may get an error requiring an update to the code from Q9

ADLB_STATS_long <- ADLB_STATS2 %>%
  # update 
  
  # Transpose again from long to wide to keep the following columns
  # PARAMCD, PARAM, STATISTICS, PLACEBO, Xanomeline High Dose, Xanomeline Low Dose
  
  ADLB_STATS_long_trt <- ADLB_STATS_long %>%
  # update
  
  
  # --- QUESTION 12: Line plot (mean GLUC over visits) [5 points] --------------------------- 
# Complete the summarise and ggplot code to create a line plot:
# - x axis: visit (use numeric visit order variable)
# - y axis: mean AVAL
# - lines/points grouped and colored by TRT01A
# 
# First run this code to obtain the line plot dataset (complete mean() args)

gluc_summary <- adlb %>%
  filter(
    PARAMCD == "GLUC",
    SAFFL == "Y",
    AVISITN %in% c(0,4,5,6,7,8,9,10,11,12,13)
  ) %>%
  group_by(TRT01A, AVISITN, AVISIT) %>%
  summarise(
    mean_aval = mean(
      AVAL
      # add something here to remove NA values 
    ),
    .groups = "drop"
  )

p <- ggplot(
  gluc_summary,
  aes(
    x = 0,      # answer in this line (replace the "0")
    y = 0,      # answer in this line (replace the "0")
    color = "", # answer in this line (replace the "")
    group = ""   # answer in this line (replace the "")
  )
) +
  #   (add a line geometry)
  #  (add a point geometry)
  scale_x_continuous(
    breaks = sort(unique(gluc_summary$AVISITN)),
    labels = gluc_summary %>%
      arrange(AVISITN) %>%
      distinct(AVISITN, AVISIT) %>%
      pull(AVISIT)
  ) +
  labs(
    title = "Mean glucose over visits by treatment",
    x = "Visit",
    y = "Mean AVAL",
    color = "Treatment"
  ) +
  theme_minimal() +
  # Adjust angle of x-axis labels by 45 degrees for readability
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Print plot
p 