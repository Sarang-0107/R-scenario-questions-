flights

class(flights)

glimpse(flights)

select(flights,dep_time,arr_time,carrier)

#modern ctrl+shift+m

flights |> select(dep_time) #one column

flights |> select(dep_time,arr_time,carrier) #more column

#position

flights |> glimpse() |> select(flight:dest) #range of column

flights |> glimpse() |> select(11:14) #range using index

flights |> glimpse() |> select(2,7,10) #getting by individual index

flights |> glimpse() |> select(3,11:14) #range using index

#you sort the dervied column variable in desc

#delay_per_mile = arr_delay/distance

flights |> 
  
  mutate(delay_per_mile= arr_delay/distance) |> 
  
  select(year,month,day,carrier,delay_per_mile) |> 
  
  arrange(desc(delay_per_mile))

#you want to sort the variable after filtering

#top delayed flights from JFK origin

flights |> 
  
  filter(origin=='JFK') |> 
  
  select(year,month,day,carrier,origin,dest,arr_delay) |> 
  
  arrange(desc(arr_delay))

#sorting within the groups

#i want to sort the desc.arr_delay based on each carrier

flights |> 
  
  group_by(carrier) |> 
  
  select(carrier,arr_delay) |> 
  
  arrange(desc(arr_delay))  #this is not right way

#this is correct way ##.by_group = TRUE

f_d<- flights |> 
  
  group_by(carrier) |> 
  
  select(carrier,arr_delay) |> 
  
  arrange(desc(arr_delay),.by_group = TRUE) |> 
  
  left_join(airlines,by = "carrier") |> 
  
  select(air_plane= name,
         
         carrier)
f_d
#another way without .by_group parameter

flights |> 
  
  group_by(carrier,arr_delay) |> 
  
  select(carrier,arr_delay) |> 
  
  arrange(carrier,desc(arr_delay))


#sarang functions , 2nd hightes of carrier per arr_d
flights |> 
  group_by(carrier) |> 
  slice_max(arr_delay,n=2) |> 
  slice_tail(n=1) |> 
  select(carrier,arr_delay)


f1 <- flights |> 
  group_by(carrier) |> 
  slice_max(arr_delay, n=3) |> 
  select(carrier,arr_delay)
f2 <- f1[2,]

f1 <- flights |> 
  group_by(carrier) |> 
  slice_max(arr_delay, n=3) |> 
  select(carrier, arr_delay)

f2 <- slice(f1, 2)

