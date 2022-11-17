# Learn R with Dr.Hu and His Friends
# Sun Zhaoyang R lecture No.3 2022.10.20
# Basic Visualization with ggplot2


# dplyr
# groupby



# set current folder as working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("/Users/championlee/Desktop/GogoLab/Chengping-Li-Coevolution:CasPi/R_workshop_codes/20221027 R回归诊断/")

library(ggplot2) # R package for visualization
#library(readxl) # R package for import excel files
library(gridExtra) # R package for combine and arrange plots

###################
#     New Way     #
###################

library(drhur)
drhur('visualize')
drhur('loop_cn')
#https://cran.r-project.org/web/packages/drhur/vignettes/drhur-vignette.html
is.na(c(1,2,NA,3))

#####################################################################
##---ggplot: data, aesthetics, geometric objects and others----------
#####################################################################

###################
# Traditional Way #
###################
data <- wvs7

## data
ggplot()
# ggplot(data = your data)
ggplot(data = data)

## data, basic plot aesthetic setting
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram()

## data, aesthetics, geometric
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'red', bins = 10)

## add title
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'black', bins = 10) +
  ggtitle('incomeLevel of Respondents')

## add lab 
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'black', bins = 10) +
  ggtitle('incomeLevel of Respondents') +
  ylab('') +
  xlab('Recent Life Satisfaction') +
  theme(plot.title = element_text(hjust = 0.5))

# add theme
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('incomeLevel of Respondents') +
  ylab('Density') +
  xlab('Gender') +
  theme_minimal() + # add theme here
  theme(plot.title = element_text(hjust = 0.5))

## how save my plot 
fig1 <- ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('incomeLevel of Respondents') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  theme(plot.title = element_text(hjust = 0.5))
fig1

ggsave("myfirstplot.pdf", fig1) 

## plot grid 1 plot arrange
fig2 <- ggplot(data = data, aes(y = incomeLevel, x = factor(female))) +
  geom_violin() +
  ggtitle("incomeLevel \n By Respondent's gender") +
  xlab('female') +
  ylab('incomeLevel')
fig2

grid.arrange(fig1, fig2, ncol=2)

grid.arrange(fig1, fig2, ncol=1)


## facet_plot 1 plot panel
ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram(fill = 'grey', color = 'black',bins = 10) +
  ggtitle('incomeLevel of Respondents \n By country') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  facet_wrap( ~ factor(country)) + # add facet here
  theme(plot.title = element_text(hjust = 0.5))

#####################################################################
## -----------------------color--------------------------------------
#####################################################################

fig3 <- ggplot(data =data, aes(x = incomeLevel, color=factor(country), fill=factor(country))) +
  geom_histogram() +
  ggtitle('incomeLevel of Respondents \n By country') +
  ylab('Density') +
  xlab('Gender') +
  theme_bw()+ # add theme here
  facet_wrap( ~ factor(country)) + # add facet here
  theme(plot.title = element_text(hjust = 0.5))
fig3


fig3 <- fig3 + scale_fill_brewer(palette = 'Accent')
fig3

?scale_fill_brewer()


#####################################################################
## ------------------------analysis----------------------------------
#####################################################################


#####################################################################
## ------------------------one variable------------------------------
#####################################################################

## histogram
pic1 <- ggplot(data = data, aes(x = incomeLevel)) +
  geom_histogram() +
  xlab('incomeLevel') +
  ylab('') +
  ggtitle('incomeLevel of Respondents')
pic1


pic2 <- ggplot(data = data, aes(x = education)) +
  geom_histogram() +
  xlab('education') +
  ylab('') +
  ggtitle('education')
pic2


#####################################################################
## ------------------------two variable------------------------------
#####################################################################

## point plot
pic3 <- ggplot(data = data, aes(x = education, y = incomeLevel)) +
  geom_point() + # 点图
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel')
pic3


## jitter plot
pic4 <- ggplot(data = data, aes(x = education, y = incomeLevel)) +
  geom_jitter(width=0.1, height=0.3) +  #散点图，随机偏移
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel')
pic4

## add line auto
pic5 <- ggplot(data = data, aes(x = education, y = incomeLevel)) +
  geom_jitter(width=0.2, height=0.2) +
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel') +
  stat_smooth(method = NULL, color="grey")
pic5

## add line linear model
pic6 <- ggplot(data = data, aes(x = education, y = incomeLevel)) +
  geom_jitter(width=0.2, height=0.2) +
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel') +
  stat_smooth(method = lm, color="grey")
pic6

## add some details
pic7 <- ggplot(data = data, aes(x = education, y = incomeLevel, color = education)) +
  #scale_color_continuous(low="green")+
  scale_color_continuous(low ="grey", high="black")+
  geom_jitter(width=0.2, height=0.2) +
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel') +
  stat_smooth(method = lm, color="grey")
pic7

## add some details: dot
pic8 <- ggplot(data = data, aes(x = education, y = incomeLevel, color = education)) +
  scale_color_continuous(low ="#CC0033", high="#0066CC")+
  geom_jitter(width=0.2, height=0.2, shape=4, size=3) + # dot style
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel') +
  stat_smooth(method = lm, color="grey")
pic8

## change type
pic9 <- ggplot(data = data, aes(x = education, y = incomeLevel, color = education)) +
  scale_color_continuous(low ="#CC0033", high="#0066CC")+
  geom_count() + #数一下点的数量，数越大，画的点越�?
  xlab('education') +
  ylab('incomeLevel') +
  ggtitle('Will education predict incomeLevel') +
  stat_smooth(method = lm, color="grey")
pic9


#####################################################################
## --------------------------- link ---------------------------------
#####################################################################

# Further Study
# https://stats.idre.ucla.edu/stat/data/intro_ggplot2_int/ggplot2_intro_interactive.html#(1)

# Detailed Hist Plot and Bar Plot
# https://www.sohu.com/a/125919313_466874