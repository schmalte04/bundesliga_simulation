library(tidyverse)
library(gganimate)

gdp_tidy <- read_csv("./data/gdp_tidy.csv")

gdp_formatted <- gdp_tidy %>%
  group_by(year) %>%
  # The * 1 makes it possible to have non-integer ranks while sliding
  mutate(rank = rank(-value),
         Value_rel = value/value[rank==1],
         Value_lbl = paste0(" ",round(value/1e9))) %>%
  group_by(country_name) %>% 
  filter(rank <=10) %>%
  ungroup()

# Animation

ggplot(Data_team_dummy, aes(mean.points, group = country_name, 
                          fill = as.factor(country_name), color = as.factor(country_name))) +
  geom_tile(aes(y = value/2,
                height = value,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(country_name, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=value,label = Value_lbl, hjust=0))


colnames(Data_team_dummy)

data_dummy$mean.points <- data_dummy$mean.points %>% round(0)


s04 = readPNG(system.file("img", "s04.png", package="png"))


buli<-ggplot(data_dummy, aes(Tabellenplatz, group = Team, 
                          fill = as.factor(Team), color = as.factor(Team))) +
  geom_tile(aes(y = mean.points/2,
                height = mean.points,
                width = 0.9), alpha = 0.8, color = NA)+
  #geom_text(aes(y = 0, label = paste(Team, " ")), vjust = 0.2, hjust = 1) +
  #geom_text(aes(y=mean.points,label = Tabellenplatz, hjust=0)) +
  geom_text(aes(y=mean.points,label = Team), hjust = "right", colour = "black", fontface = "bold", nudge_y = 1) +
  geom_text(aes(y=mean.points,label = scales::comma(Tabellenplatz)), hjust = "left", colour = "grey30", nudge_y = -5) +
  geom_text(aes(y=mean.points,label = scales::comma(Tabellenplatz)), hjust = "left", colour = "white", nudge_y = 100) +
  
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous("",labels=scales::comma)  +
scale_x_reverse() +
  scale_fill_manual(name = 'Team', values = 
            c("#DC052D", #Augsburg
              "#DC052D", #Bayern
              "yellow",  #Dortmund
              "#E1000F",   #Frankfurt
              "#ED1C24",  #Köln
              "#DA251D",  #Düsseldorf
              "red", #Freiburg
              "lightblue", #Hertha
              "blue",  #Hoffenheim
              "red", #Leverkusen
              "darkgrey", #Gladbach
              "red", #Mainz
              "darkblue", #Paderborn
              "orange",
              "royalblue",
              "green",
              "green",
              "red")) +
  guides(color = FALSE, fill = FALSE) +
  #hrbrthemes::theme_ipsum(plot_title_size = 32, subtitle_size = 24, caption_size = 20, base_size = 20) +
  theme(panel.grid.major.y=element_blank(),
        panel.grid.minor.x=element_blank(),
        legend.position = c(0.4, 0.2),
        plot.margin = margin(1,1,1,2,"cm"),
        axis.text.y=element_blank()) +
  theme(
     axis.line=element_blank(),
      axis.text.x=element_blank(),
  axis.text.y=element_blank(),
axis.ticks=element_blank(),
 axis.title.x=element_blank(),
axis.title.y=element_blank()
  legend.position="none",
  panel.background=element_blank(),
   panel.border=element_blank(),
panel.grid.major=element_blank(),
 panel.grid.minor=element_blank()
  #       # panel.grid.major.x = element_line( size=.1, color="grey" ),
  #       # panel.grid.minor.x = element_line( size=.1, color="grey" ),
  #       # plot.title=element_text(size=25, hjust=0.5, face="bold", colour="black", vjust=-1),
  #       # plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
  #       # plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
  #       # plot.background=element_blank(),
  #       plot.margin = margin(2,2, 2, 2, "cm")
         ) +
        transition_states(Spieltag, transition_length = 4, state_length = 1, wrap = TRUE) +
        view_follow(fixed_x = TRUE)  +
  ease_aes('cubic-in-out')+ 
  labs(title = '{closest_state}. Spieltag',
        subtitle  =  "Simulation 1.Bundesliga",
        caption  = "Tabellensimulation") 


animate(buli, nframes = 750, fps = 25, end_pause = 50, width = 1200, height = 900)

# 
# ggplotly(ggplot(data_dummy, aes(Tabellenplatz, group = Team, 
#                                 fill = as.factor(Team), color = as.factor(Team))) +
#            geom_tile(aes(y = mean.points/2,
#                          height = mean.points,
#                          width = 0.9), alpha = 0.8, color = NA))
# 
# 


p <-ggplot(data_dummy, aes(Tabellenplatz, group = Team, fill = as.factor(Team), color = as.factor(Team))) +
  geom_tile(aes(y = mean.points/2, height = mean.points, width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y=mean.points,label = Team), hjust = "right", colour = "black", fontface = "bold", nudge_y = 0) +
  geom_text(aes(y=mean.points,label = scales::comma(Tabellenplatz)), hjust = "left", nudge_y = 1, colour = "grey30") +
  coord_flip(clip="off") +
  scale_fill_manual(name = 'Team', values = 
                      c("#DC052D", #Augsburg
                        "#DC052D", #Bayern
                        "yellow",  #Dortmund
                        "#E1000F",   #Frankfurt
                        "#ED1C24",  #Köln
                        "#DA251D",  #Düsseldorf
                        "red", #Freiburg
                        "lightblue", #Hertha
                        "blue",  #Hoffenheim
                        "red", #Leverkusen
                        "darkgrey", #Gladbach
                        "red", #Mainz
                        "darkblue", #Paderborn
                        "orange",
                        "royalblue",
                        "green",
                        "green",
                        "red")) +
  
  scale_x_discrete("") +
  scale_y_continuous("",labels=scales::comma) +
  theme(panel.grid.major.y=element_blank(),
        panel.grid.minor.x=element_blank(),
        legend.position = element_blank(),
        plot.margin = margin(1,1,1,2,"cm"),
        axis.text.y=element_blank()
        #       # #panel.background=element_blank(),
        #       # panel.border=element_blank(),
        #       # #panel.grid.major=element_blank(),
        #       # panel.grid.minor=element_blank(),
        #       # panel.grid.major.x = element_line( size=.1, color="grey" ),
        #       # panel.grid.minor.x = element_line( size=.1, color="grey" ),
        ) +
  # gganimate code to transition by year:
  transition_time(Spieltag) +
  ease_aes('cubic-in-out') +
  labs(title='Largest Cities in the United States',
       subtitle='Population in {round(frame_time,0)}',
       caption='Source: United States Census
michaeltoth.me / @michael_toth')



# 
# anim <- ggplot(gdp_formatted, aes(rank, group = country_name, 
#                 fill = as.factor(country_name), color = as.factor(country_name))) +
#   geom_tile(aes(y = value/2,
#                 height = value,
#                 width = 0.9), alpha = 0.8, color = NA) +
#   geom_text(aes(y = 0, label = paste(country_name, " ")), vjust = 0.2, hjust = 1) +
#   geom_text(aes(y=value,label = Value_lbl, hjust=0)) +
#   coord_flip(clip = "off", expand = FALSE) +
#   scale_y_continuous(labels = scales::comma) +
#   scale_x_reverse() +
#   guides(color = FALSE, fill = FALSE) +
#   theme(axis.line=element_blank(),
#         axis.text.x=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks=element_blank(),
#         axis.title.x=element_blank(),
#          axis.title.y=element_blank(),
#         legend.position="none",
#         panel.background=element_blank(),
#         panel.border=element_blank(),
#         panel.grid.major=element_blank(),
#         panel.grid.minor=element_blank(),
#         panel.grid.major.x = element_line( size=.1, color="grey" ),
#         panel.grid.minor.x = element_line( size=.1, color="grey" ),
#         plot.title=element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
#         plot.subtitle=element_text(size=18, hjust=0.5, face="italic", color="grey"),
#         plot.caption =element_text(size=8, hjust=0.5, face="italic", color="grey"),
#         plot.background=element_blank(),
#        plot.margin = margin(2,2, 2, 4, "cm")) +
#   transition_states(year, transition_length = 4, state_length = 1, wrap = TRUE) +
#   view_follow(fixed_x = TRUE)  +
#   ease_aes('cubic-in-out') +
#   labs(title = 'GDP per Year : {closest_state}',  
#        subtitle  =  "Top 10 Countries",
#        caption  = "GDP in Billions USD | Data Source: World Bank Data") 

# For GIF

animate(buli, 200, fps = 20,  width = 1200, height = 1000, 
        renderer = gifski_renderer("gganim.gif"), end_pause = 15, start_pause =  15) 

# For MP4

animate(anim, 200, fps = 20,  width = 1200, height = 1000, 
        renderer = ffmpeg_renderer()) -> for_mp4

anim_save("animation.mp4", animation = for_mp4 )
