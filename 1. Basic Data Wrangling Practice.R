library(dplyr)
library(tidyverse)
library(dplyr)
sales <- tibble(
  order_id = 1:10,
  customer = c("Alice", "Bob", "Alice", "David", "Emma",
               "Bob", "Emma", "Alice", "David", "Emma"),
  product = c("Laptop", "Tablet", "Phone", "Laptop", "Tablet",
              "Phone", "Laptop", "Phone", "Tablet", "Laptop"),
  price = c(1200, 500, 800, 1200, 500, 800, 1200, 800, 500, 1200),
  quantity = c(1, 2, 1, 1, 3, 2, 1, 1, 2, 1),
  order_date = as.Date(c("2023-01-10", "2023-01-11", "2023-01-15",
                         "2023-02-01", "2023-02-05", "2023-02-20",
                         "2023-03-01", "2023-03-10", "2023-03-15", "2023-03-20"))
)

view(sales)
sales <- sales |> 
  mutate (total = price * quantity)
sales

sales |> 
  group_by(product) |> 
  summarise(total_revenue = sum(price * quantity))

sales |> 
  group_by(product) |> 
  summarise(total_revenue = sum(price * quantity))

sales |> 
  group_by(customer) |> 
  summarise(total_spend = sum(price * quantity)) |> 
  arrange(desc(total_spend)) |> 
  

  sales |> 
  group_by(customer) |> 
  summarise(total_spend = sum(price * quantity)) |> 
  arrange(desc(total_spend))

library(dplyr)
library(lubridate)

 sales |> 
  filter(month(order_date) == 2)
 
 library(dplyr)
 library(lubridate)
 
 feb_orders <- sales |> 
   filter(month(order_date) == 2)
 
 feb_orders
 
 highest_order <- sales |> 
   arrange(desc(total))
 highest_order