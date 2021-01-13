#Librerías ====
    library(tidyverse)

# Lectura y limpieza ====
sal_h <- read_csv('data/raw/salario_hombres.csv') %>% 
    janitor::clean_names() %>% 
    select(anio = salario_diario_hombres, 
           anio_mes = x3, 
           salario_h = nacional)
sal_m <- read_csv('data/raw/salario_mujeres.csv') %>% 
    janitor::clean_names() %>% 
    select(anio = salario_diario_mujeres, 
           anio_mes = x3, 
           salario_m = nacional) %>% 
    slice_sample(n = 252)

pt_h <- read_csv('data/raw/pt_hombres.csv') %>% 
    janitor::clean_names() %>% 
    select(anio_mes = x3, 
           pt_h = nacional) 
pt_m <- read_csv('data/raw/pt_mujeres.csv') %>% 
    janitor::clean_names() %>% 
    select(anio_mes = x3, 
           pt_m = nacional) 
inpc <- readxl::read_excel('data/raw/inpc_20201229.xlsx', 
                           skip = 17) %>% 
    janitor::clean_names() %>% 
    select(fecha, sp1_2)

# Joins ====
imss_joined <- sal_h %>% 
    left_join(sal_m) %>% 
    left_join(pt_h) %>% 
    left_join(pt_m)

imss_deflated <- imss_joined %>% 
    mutate(fecha = parse_datetime(anio_mes, format = '%Y/%b'), 
           across(starts_with('salario_'), ~ parse_number(.x))) %>% 
    left_join(inpc) %>% 
    mutate(across(starts_with('salario_'), ~ .x / sp1_2))


# Vizs ====

imss_deflated

# 1. Graficar los salarios de los hombres en una línea de tiempo

imss_deflated %>%
    filter(anio_mes != 'Tiempo') %>%
    ggplot() +
    geom_line(mapping = aes(x = fecha, y = salario_h))

# 2. pivot_longer sobre salario_* para graficar una compación con
# boxplots de hombres y mujeres
imss_deflated %>%
    filter(anio_mes != 'Tiempo') %>%
    select(fecha, starts_with('salario')) %>%
    pivot_longer(starts_with('salario'),
                 names_prefix = 'salario_',
                 names_to = 'sexo',
                 values_to = 'salario') %>%
    ggplot() +
    geom_boxplot(mapping = aes(x = sexo, y = salario))

# 3. Modifiquen sus aesthetics manuales para personalizar su gráfica

imss_deflated %>%
    filter(anio_mes != 'Tiempo') %>%
    select(fecha, starts_with('salario')) %>%
    pivot_longer(starts_with('salario'),
                 names_prefix = 'salario_',
                 names_to = 'sexo',
                 values_to = 'salario') %>%
    ggplot() +
    geom_boxplot(mapping = aes(x = sexo, y = salario),
                 fill = c('#DD2D4A', '#DDFD4A'),
                 alpha = 0.8
                 )

# 4. Invierte el orden de los boxplots de la gráfica 2
# TIP: parse_factor() tiene un argumento de niveles para vars categóricas

imss_deflated %>%
    filter(anio_mes != 'Tiempo') %>%
    select(fecha, starts_with('salario')) %>%
    pivot_longer(starts_with('salario'),
                 names_prefix = 'salario_',
                 names_to = 'sexo',
                 values_to = 'salario') %>%
    mutate(sexo = parse_factor(sexo, levels = c('m', 'h'))) %>%
    ggplot() +
    geom_boxplot(mapping = aes(x = sexo, y = salario),
                 fill = c('#DD2D4A', '#DDFD4A'),
                 alpha = 0.8)

# 5. Comportamiento por año 

imss_deflated %>% 
    filter(anio_mes != 'Tiempo') %>% 
    select(anio, fecha, starts_with('salario')) %>% 
    pivot_longer(starts_with('salario'), 
                 names_prefix = 'salario_', 
                 names_to = 'sexo', 
                 values_to = 'salario') %>% 
    mutate(sexo = parse_factor(sexo, levels = c('m', 'h'))) %>% 
    ggplot() +
    geom_boxplot(aes(x = sexo, y = salario, fill = anio), 
                 alpha = 0.8)




