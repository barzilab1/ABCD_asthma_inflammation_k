source("config.R")
source("utility_fun.R")

site <-  load_instrument("abcd_lt01",site_files_path)

site$site_id_l_br = as.numeric(sub("site","",site$site_id_l))
site$site_id_l = NULL

write.csv(file = "outputs/site.csv",x = site, row.names = F, na = "")