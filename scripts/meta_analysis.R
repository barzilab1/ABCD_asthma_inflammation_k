library(meta)
library(sjPlot)
library(performance)
library(dplyr)
library(MuMIn)
library(lme4)
library(readr)

dataset <- read_csv("outputs/data_wide_mm.csv")

create_meta_df <- function (feature, model1, model2) {
  mod1_coef = summary(model1)$coef
  mod2_coef = summary(model2)$coef
  
  df = data.frame(
    TE = c(mod1_coef[, "Estimate"][feature], mod2_coef[, "Estimate"][feature]),
    seTE = c(mod1_coef[, "Std. Error"][feature], mod2_coef[, "Std. Error"][feature])
  )
}


run_meta_analysis <- function(IV, modEUR, modAFR){
  df = create_meta_df(IV, modEUR, modAFR)
  metagen(TE, seTE, studlab = c("EUR", "AFR"),  data = df, sm = "OR")
}


run_models <- function(DV, IV = NULL, demo = T, covar = NULL) {
  
  if(!demo) {
    formula_str = paste0(DV, " ~ (1 | site_id_l_br/rel_family_id)")
  } else {
    formula_str = paste0(DV, " ~ scale(age_2y_years) + sex_br + race_other + ethnicity_hisp +
                       (1 | site_id_l_br/rel_family_id)")
  }
  
  if(!is.null(IV)) {
    formula_str = paste0(formula_str, "+", IV)
    if(!is.null(covar)){
      formula_str = paste0(formula_str, "+", paste0(covar, collapse = "+"))
    }
  }
  
  formula = as.formula(formula_str)
  
  
  dataset_ = dataset
  
  modEUR = glmer(formula, data = dataset_[dataset_$genetic_afr == 0,], family = binomial, nAGQ = 0)
  modAFR = glmer(formula, data = dataset_[dataset_$genetic_afr == 1,], family = binomial, nAGQ = 0)
  
  # print(tab_model(modEUR,modAFR, show.intercept = F ))
  # cat("\nr2 EUR: ")
  # print(round(r.squaredGLMM(modEUR)[1,1], digits = 3) *100)
  # cat("\nr2 AFR: ")
  # print(round(r.squaredGLMM(modAFR)[1,1], digits = 3) *100)

    
  if(demo){
    cat("\n\n meta analysis for age:\n")
    print(run_meta_analysis("scale(age_2y_years)", modEUR, modAFR))
    cat("\n\n meta analysis for sex:\n")
    print(run_meta_analysis("sex_br", modEUR, modAFR))
    cat("\n\n meta analysis for race_other:\n")
    print(run_meta_analysis("race_other", modEUR, modAFR))
    cat("\n\n meta analysis for ethnicity_hisp:\n")
    print(run_meta_analysis("ethnicity_hisp", modEUR, modAFR))
  }
  
  if(!is.null(IV)){
    cat("\n\n meta analysis for", IV, ":\n")
    print(run_meta_analysis(IV, modEUR, modAFR))
  }
      
  if(!is.null(covar)){
      for (cov in 1:length(covar)) {
        cat("\n\n meta analysis for", covar[cov], ":\n\n")
        print(run_meta_analysis(covar[cov], modEUR, modAFR))
      }
  }
  
  return(list(modEUR = modEUR, modAFR = modAFR))
  
}


mod_SA_PRS_1IV = run_models("SA_y_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_SA_PRS_1IV, show.intercept = F )
mod_SA_PRS = run_models("SA_y_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_SA_PRS, show.intercept = F )

mod_SI_PRS_1IV = run_models("SI_y_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_SI_PRS_1IV, show.intercept = F )
mod_SI_PRS = run_models("SI_y_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_SI_PRS, show.intercept = F )

mod_diag_PRS_1IV = run_models("asthma_diagnosis_l_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_diag_PRS_1IV, show.intercept = F )
mod_diag_PRS = run_models("asthma_diagnosis_l_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_diag_PRS, show.intercept = F )

mod_attack_PRS_1IV = run_models("asthma_attack_l_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_attack_PRS_1IV, show.intercept = F )
mod_attack_PRS = run_models("asthma_attack_l_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_attack_PRS, show.intercept = F )

mod_composite_PRS_1IV = run_models("asthma_composite_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_composite_PRS_1IV, show.intercept = F )
mod_composite_PRS = run_models("asthma_composite_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_composite_PRS, show.intercept = F )

mod_recent_active_PRS_1IV = run_models("recent_active_asthma_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_recent_active_PRS_1IV, show.intercept = F )
mod_recent_active_PRS = run_models("recent_active_asthma_ever", IV = "asthma_PRS", demo = T)
tab_model(mod_recent_active_PRS, show.intercept = F )

mod_brokenbones_PRS_1IV = run_models("medhx_6a_l_ever", IV = "asthma_PRS", demo = F)
tab_model(mod_brokenbones_PRS_1IV, show.intercept = F )





