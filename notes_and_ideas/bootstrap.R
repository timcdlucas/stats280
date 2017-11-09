


purrr::rerun(100, x = rnorm(5)) %>%
  map_dbl(~ mean(.x$x)) %>% 
  hist

replicate(100, mean(rnorm(100))) %>% 
  hist


data.frame(x = rnorm(10 * 100), g = 1:10) %>% 
  group_by(g) %>% 
  dplyr::summarise(m = mean(x)) %>% 
  pull(m) %>% 
  hist


data.frame(x = rnorm(10 * 100), g = 1:10) %>% 
  group_by(g) %>% 
  dplyr::do(data.frame(m = mean(.$x))) %>% 
  pull(m) %>% 
  hist
