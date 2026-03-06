students <- tibble(
  name = c("Anna", "Ben", "Clara", "David", "Ella", "Frank"),
  major = c("Math", "Math", "Physics", "Physics", "Math", "Physics"),
  year = c(1, 2, 1, 3, 2, 3),
  grade = c(88, 92, 85, 90, 95, 87)
)
students
library(dplyr )
# 1.Compute average grade by major.
students |> 
  group_by(major) |> 
  summarise((avg_grade=mean(grade,na.rm = TRUE)))

# 2.Compute average grade by major AND year
students |> 
  group_by(major,year) |> 
  summarise((avg_grade=mean(grade, na.rm =TRUE)))

# 3.Count how many students per major.
students |> 
  count(major)

# 4.Find the top student in each major.

#Recommended (Modern dplyr way)
students |>
  group_by(major) |> 
  slice_max(grade, n =1)

#Alternative using filter()
students |> 
  group_by(major) |> 
  filter(grade == max(grade))

#Even Cleaner (New .by syntax)
students |> 
  slice_max(grade, n = 1, .by = major)
students |>
  slice_max(grade, n = 1, .by = major)

packageVersion("dplyr")
install.packages("dplyr")

# 5.Add a column that shows each student’s grade minus their major average.



students |>
  group_by(major) |>
  mutate(grade_diff = grade - mean(grade)) |>
  ungroup()

#alternate method 
students |> 
  mutate(grade_diff =grade - mean(grade), .by =major)


#You want the 2nd highest arr_delay for each carrier in R. Using dplyr, there are several ways to do it.
1⃣# Using slice_max() (most common)
f2 <- flights |> 
  group_by(carrier) |> 
  slice_max(arr_delay, n = 2) |> 
  slice_min(arr_delay, n = 1)|> 
  select(carrier,arr_delay)
print(f2)

#Using slice_max() with min_rank()
f3 <- flights |> 
  group_by(carrier) |> 
  filter(min_rank(desc(arr_delay)) == 2) |> 
  select(carrier,arr_delay)
View(f3)

#Using arrange() + slice()
f4 <- flights |> 
  group_by(carrier) |> 
  arrange(desc(arr_delay)) |> 
  slice(2)
print(f4)

#Using nth()
f5 <- flights
group_by(carrier) |> 
  summarise(second_highest = nth(sort(arr_delay, decreasing = TRUE),2))
print(f5)

f5 <- flights |>
  group_by(carrier) |>
  summarise(second_highest = nth(sort(arr_delay, decreasing = TRUE), 2)) |> 
  select(carrier,arr_delay)
print(f5)
