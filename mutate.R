#mutate:
#mutate(data,new_column = expression)
# or with pipes
data |> mutate(new_column = expression)

library(dplyr)

df <- data.frame(
  price = c(10,9,8,5,4,7,8,7),
  quantity =c(2,3,4,7,8,9,6,5)
)
df |> mutate(total = price * quantity)

df |> mutate(price =price * 1.1)
df |>  mutate(price = price * 2,
              discount =price * 8)
print(df)

#Using Conditions

df |> 
  mutate(size = ifelse(quantity > 3, "Large","small"))

library(dplyr)
 mtcars |> 
   mutate(kpl =mpg * 0.152)  |> arrange(desc(kpl)) 
#Important Behavior
 #1. Keeps all original columns
 
 #mutate() does not remove columns.
 
 #2. Works row-wise by default
 
 #Each row calculation uses values from that row.
 
 df |> 
   mutate(
     total = price * quantity,
     tax = total * 0.05,
     final_price= total + tax
   )
 print(df)
   )