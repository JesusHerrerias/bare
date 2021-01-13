# Librerías ====
library(tidyverse)

# Lectura ====
diamantes <- diamonds %>%
    slice_sample(n = 1e3)

#Dos formas de verlo:
# 1. como programa
# 2. como intuición 
diamantes %>%
    ggplot() %>%
    class()

# básicos de ggplot2

# geoms ====
ggplot(diamantes) +
    geom_point(mapping = aes(x = carat, y = price))

ggplot(diamantes) +
    geom_boxplot(mapping = aes(x = cut, y = price))

# ggplot(<data>) +
#   <geom>(mapping = <AES>(<vars>))

diamantes %>%
    ggplot() +
    geom_density2d(mapping = aes(x = carat, y = price))

ggplot(diamantes) +
    geom_point(mapping = aes(x = carat, y = price)) +
    geom_smooth(mapping = aes(x = carat, y = price))


# aesthetics

#manuales
diamantes %>%
    ggplot() +
    geom_point(mapping = aes(x = carat, y = price),
               color = 'blue4')


diamantes %>%
    ggplot() +
    geom_point(mapping = aes(x = carat, y = price),
               color = '#DD2D4A',
               size = 5,
               shape = 25,
               fill = 'black',
               #alpha = 1 / 2,
               stroke = 1
               )


# ggplot(<data>) +
#   <geom>(mapping = <AES>(<automatic_aes>),
#            <manual_aes>)


diamantes %>%
    ggplot() +
    geom_point(mapping = aes(x = carat, y = price,
               color = cut))
               
diamantes %>%
    ggplot() +
    geom_point(aes(x = carat, y = price, color = cut),
               size = 4,
               alpha = 1/ 3)



diamantes %>%
    ggplot() +
    geom_density_2d(aes(x = carat, y = price, color = cut),
               size = 4,
               alpha = 1 / 3)

diamantes %>%
    ggplot() +
    geom_boxplot(aes(x = cut, y = price),
                    alpha = 1 / 3)


diamantes %>%
    ggplot() +
    geom_boxplot(aes(x = cut, y = price,
                 fill = color))


diamantes %>%
    ggplot() +
    geom_violin(aes(x = cut, y = price,
                     fill = color))
diamantes %>% 
    ggplot() +
    geom_violin(aes(x = cut, y = price, 
                    fill = color)) +
    theme(panel.background = element_rect(fill = "#cecece"))










               
               
               
               





