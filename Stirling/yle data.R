source("config.R")
source("utility_fun.R")

yle = load_instrument("abcd_yle01",exposome_files_path)

summary(yle[yle$eventname == "baseline_year_1_arm_1",]) 

dput(names(yle))

myVars <- c("eventname", "ple_died_y", "ple_injured_y", "ple_crime_y", "ple_friend_y", "ple_friend_injur_y", "ple_financial_y", "ple_sud_y", "ple_ill_y", "ple_injur_y", "ple_argue_y", "ple_job_y", "ple_away_y", "ple_arrest_y", "ple_friend_died_y", "ple_mh_y", "ple_sib_y", "ple_victim_y", "ple_separ_y", "ple_law_y", "ple_school_y", "ple_move_y", "ple_jail_y", "ple_step_y", "ple_new_job_y", "ple_new_sib_y")

catVars <- c("eventname", "ple_died_y", "ple_injured_y", "ple_crime_y", "ple_friend_y", "ple_friend_injur_y", "ple_financial_y", "ple_sud_y", "ple_ill_y", "ple_injur_y", "ple_argue_y", "ple_job_y", "ple_away_y", "ple_arrest_y", "ple_friend_died_y", "ple_mh_y", "ple_sib_y", "ple_victim_y", "ple_separ_y", "ple_law_y", "ple_school_y", "ple_move_y", "ple_jail_y", "ple_step_y", "ple_new_job_y", "ple_new_sib_y")

tab2 <- CreateTableOne(vars = myVars, data = yle, factorVars = catVars)

tab2

tab3 <- CreateTableOne(vars = myVars, strata = "eventname" , data = yle, factorVars = catVars)

tab3
