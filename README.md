# abcd asthma inflammation project 

This project uses the following ABCD instruments [version 4.0]:

1. pdem02
2. abcd_lpds01
3. acspsw03
4. dhx01
5. abcd_rhds01
6. medsy01
7. abcd_ssphp01
8. abcd_medhxss01
9. abcd_lssmh01
10. abcd_mx01
11. abcd_lpmh01
12. abcd_cbcls01
13. abcd_yssbpm01
14. abcd_lt01
15. abcd_ksad01
16. abcd_ksad501


#### How to run the code:

1. Update the [config.R](config.R) to reflect the location of the instruments above.
2. In the data-scripts folder, run scripts in any order. These scripts go over the ABCD instruments and create new variables and datasets that are placed in the “outputs” folder.
3. Run the [merging.Rmd](/scripts/merging.Rmd) and [create_wide_data.Rmd](/scripts/create_wide_data.Rmd) script to create the long and wide format dataset.
4. Run the [create_table1.Rmd](/scripts/create_table1.Rmd) to generate table 1 of the main paper and supplement.
5. Run the [analyses.Rmd](/scripts/analyses.Rmd) for analyses in the main paper and supplement.
5. Run the [meta_analysis.R](/scripts/meta_analysis.R) to run meta-analyses for models with genetic scores.