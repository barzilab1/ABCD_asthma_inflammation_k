# abcd asthma inflammation project 

This project uses the following ABCD instruments [version 3.0]:

1. pdem02
2. acspsw03
3. dhx01
4. abcd_ssmty01
6. abcd_ksad501
7. medsy01
8. abcd_ssphp01
9. abcd_sscey01
10. abcd_rhds01
11. abcd_medhxss01
12. abcd_mx01
13. abcd_lpmh01


How to run the code:

1. update the config.R to reflect the location of the instruments above 
2. In the scripts folder, run the scripts in any order. These scripts go over the abcd instruments and create new variables and datasets that are placed in the “outputs” folder.
3. Run the [merging.R](/scripts/merging.R) script. This script merges all the datasets that were created in step 2 and adds some more adhd variables. 
