#please make sure to install all of the following packages 
library(tidyverse)
library(ggplot2)
library(leaflet)
library(dplyr)
library(sf)
library(tibble)
library(knitr)
library(kableExtra)

#please make sure to change the path to the attached CSV file
Airbnb_data <- read.csv("CSV PATH")
Airbnb_data$availability.365[Airbnb_data$availability.365>365]<-NA #filter the illogical values
Airbnb_data$price <- as.integer(gsub('\\$','',Airbnb_data$price))#makes it integer
Airbnb_data$service.fee <- as.integer(gsub('\\$','',Airbnb_data$service.fee))
Airbnb_data<- Airbnb_data[Airbnb_data$number.of.reviews>10,] #filteres appartments with under 10 reviews 
only_homes <-Airbnb_data[Airbnb_data$room.type == 'Entire home/apt',]
only_homes <-only_homes[only_homes$reviews.per.month<= 20,]

#Q1
#create table1
only_manhattan <- Airbnb_data[Airbnb_data$neighbourhood.group == 'Manhattan',]
table1 <-only_homes %>%
  filter(neighbourhood != "") %>%   # Exclude rows where neighbourhood is empty
  group_by(neighbourhood) %>%
  na.omit() %>%
  summarise(mean_price = mean(price))
names(table1)[names(table1) == "neighbourhood"] <- "neighborhood"
table1 <- table1 %>% arrange(mean_price)# arrange the table



# Load the GeoJSON file
#please make sure to change the path to the attached GEOJSON file
neighborhoods <- st_read("GEOJSON PATH")
neighborhoods = na.omit(left_join(neighborhoods, table1, by = c("neighborhood")))

pal <- colorNumeric(palette = "plasma", domain = neighborhoods$mean_price) # matches the color pallete
tooltip <- paste("Neighborhood:", neighborhoods$neighborhood,
                 "\n,Mean Price:", round(neighborhoods$mean_price, 2))

# Plot the map
leaflet(neighborhoods) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(
    fillColor = ~pal(mean_price),
    fillOpacity = 0.7, 
    color = "#BDBDC3", 
    weight = 1,
    label = tooltip,
    labelOptions = labelOptions(direction = "auto")
  )%>%
  #the overmouse info
  addLegend(pal = pal,
            values = ~mean_price,
            opacity = 0.7,
            title = "Mean Price",
            position = "bottomright") 


#Q2
#ALL OF NY
only_homes %>%
  ggplot(aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(only_homes$price)), linetype = "dashed", color = "red")+
  geom_text(x = max(na.omit(only_homes$price)), y = max(density(na.omit(only_homes$price))$y),  # Add the SD number to the top right
            label = paste("SD =", round(sd(only_homes$price,na.rm = TRUE), 2)))+
  ylab("Density") +
  xlab("Price") +
  ggtitle("Density of Prices:", 'New York') +
  scale_y_continuous(labels = scales::number_format())

#MIDTOWN
only_homes[only_homes$neighbourhood == 'Midtown',] %>%
  ggplot(aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(only_homes[only_homes$neighbourhood == 'Midtown',]$price)), linetype = "dashed", color = "red")+
  geom_text(x = max(na.omit(only_homes$price)), y = max(density(na.omit(only_homes$price))$y),  # Add the SD number to the top right
            label = paste("SD =", round(sd(only_homes[only_homes$neighbourhood == 'Midtown',]$price,na.rm = TRUE), 2)))+
  ylab("Density") +
  xlab("Price") +
  ggtitle("Density of Prices:", 'Midtown') +
  scale_y_continuous(labels = scales::number_format())

#Schuylerville
only_homes_schuylerville <- only_homes[only_homes$neighbourhood == 'Schuylerville',]
ggplot(only_homes_schuylerville, aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(only_homes_schuylerville$price)), linetype = "dashed", color = "red") +
  annotate("text", x = max(na.omit(only_homes_schuylerville$price)), y = max(density(na.omit(only_homes_schuylerville$price))$y),
           label = paste("SD =", round(sd(na.omit(only_homes_schuylerville$price), na.rm = TRUE), 2)),
           hjust = 1, vjust = 1) +
  ylab("Density") +
  xlab("Price") +
  ggtitle("Density of Prices:", 'Schuylerville')  +
  scale_y_continuous(labels = scales::number_format())

#Dyker hights
Dyker_Heights_data <- only_homes[only_homes$neighbourhood == 'Dyker Heights' & !is.na(only_homes$price),]
ggplot(Dyker_Heights_data, aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(Dyker_Heights_data$price)), linetype = "dashed", color = "red") +
  geom_text(x = max(Dyker_Heights_data$price, na.rm = TRUE), y = max(density(Dyker_Heights_data$price)$y),
            label = paste("SD =", round(sd(Dyker_Heights_data$price, na.rm = TRUE), 2))) +
  ylab("Density") +
  xlab("Price") +
  ggtitle(paste("Density of Prices:", "Dyker Heights")) +
  scale_y_continuous(labels = scales::number_format())

#Concourse
only_homes[only_homes$neighbourhood == 'Concourse',] %>%
  ggplot(aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(only_homes[only_homes$neighbourhood == 'Concourse',]$price)), linetype = "dashed", color = "red")+
  geom_text(x = max(na.omit(only_homes$price)), y = max(density(na.omit(only_homes$price))$y),  # Add the SD number to the top right
            label = paste("SD =", round(sd(only_homes[only_homes$neighbourhood == 'Concourse',]$price,na.rm = TRUE), 2)))+
  ylab("Density") +
  xlab("Price") +
  ggtitle("Density of Prices:", 'Concourse') +
  scale_y_continuous(labels = scales::number_format())

#Rego Park
only_homes[only_homes$neighbourhood == 'Rego Park',] %>%
  ggplot(aes(x = price)) +
  geom_density() +
  geom_vline(xintercept = mean(na.omit(only_homes[only_homes$neighbourhood == 'Rego Park',]$price)), linetype = "dashed", color = "red")+
  geom_text(x = max(na.omit(only_homes$price)), y = max(density(na.omit(only_homes$price))$y),  # Add the SD number to the top right
            label = paste("SD =", round(sd(only_homes[only_homes$neighbourhood == 'Rego Park',]$price,na.rm = TRUE), 2)))+
  ylab("Density") +
  xlab("Price") +
  ggtitle("Density of Prices:", 'Rego Park') +
  scale_y_continuous(labels = scales::number_format())


#Q3

# Remove rows with NA 
only_homes <- only_homes %>%
  filter(!is.na(price),
         !is.na(host_identity_verified),
         !is.na(instant_bookable),
         !is.na(cancellation_policy),
         !is.na(Construction.year),
         !is.na(number.of.reviews),
         !is.na(review.rate.number),
         !is.na(NAME),  # Remove rows with NA in NAME 
         NAME != "",    # Remove rows with empty NAME
         trimws(NAME) != "",  # Remove rows with whitespace NAME
         !is.na(neighbourhood),  # Remove rows with NA in neighbourhood 
         neighbourhood != "",    # Remove rows with empty neighbourhood
         trimws(neighbourhood) != "")  # Remove rows with whitespace neighbourhood

# test 1: Price Score
only_homes <- only_homes %>%
  mutate(price_score = case_when(
    price < 200 ~ 100,
    price >= 200 & price < 300 ~ 90,
    price >= 300 & price < 400 ~ 80,
    price >= 400 & price < 500 ~ 70,
    price >= 500 & price < 600 ~ 60,
    TRUE ~ 50
  ))
#test 2: 
# Host Identity Score
only_homes <- only_homes %>%
  mutate(host_identity_score = ifelse(host_identity_verified == "verified", 15, 0))

# Instant Bookable Score
only_homes <- only_homes %>%
  mutate(instant_bookable_score = ifelse(instant_bookable == TRUE, 10, 0))

# Cancellation Policy Score
only_homes <- only_homes %>%
  mutate(cancellation_policy_score = case_when(
    cancellation_policy == "strict" ~ 0,
    cancellation_policy == "moderate" ~ 5,
    cancellation_policy == "flexible" ~ 10,
    TRUE ~ 0
  ))

# Construction Year Score
only_homes <- only_homes %>%
  mutate(construction_year_score = ifelse(Construction.year >= 2018, 10, 0))

# Number of Reviews Score
only_homes <- only_homes %>%
  mutate(number_of_reviews_score = ifelse(number.of.reviews > 30, 15, 0))

# Review Rate Number Score
only_homes <- only_homes %>%
  mutate(review_rate_number_score = review.rate.number * 8) # Multiply by 8 to get scores of 8, 16, 24, 32, 40

# Combine all Test 2 scores
only_homes <- only_homes %>%
  mutate(test_2_score = host_identity_score + instant_bookable_score + cancellation_policy_score +
           construction_year_score + number_of_reviews_score + review_rate_number_score)

#final score as the mean of Test 1 and Test 2 scores
only_homes <- only_homes %>%
  mutate(Final_result = (price_score + test_2_score) / 2)

# the first 1000 appartments
score_table <- only_homes %>%
  select(NAME, neighbourhood, Final_result) %>%
  arrange(desc(Final_result)) %>%
  head(1000)

# create a new index column
score_table <- score_table %>%
  mutate(Index = row_number()) %>%
  select(Index, everything())

# create a score table
score_table <- score_table %>%
  kable("html", escape = F, align = c('l', 'l', 'l', 'r'), caption = "Scores Table") %>%
  kable_styling("striped", full_width = F)

# print the beautiful table
print(score_table)

#Q4

n_bootstrap_samples <- 1000 #num of samples
bootstrap_sample_means <- numeric(n_bootstrap_samples)

# generate bootstrap samples
for(i in 1:n_bootstrap_samples) {
  bootstrap_sample <- sample(only_homes$price, size = nrow(only_homes), replace = TRUE)
  bootstrap_sample_means[i] <- mean(bootstrap_sample, na.rm = TRUE) #make a vector of the means
}

bootstrap_mean <- mean(bootstrap_sample_means) #calculate the mean of the means
bootstrap_standard_error <- sd(bootstrap_sample_means) #calculate the standart deviation
confidence_interval <- quantile(bootstrap_sample_means, c(0.025, 0.975)) #calculate the 95%
# print the results
print(paste0("Bootstrap Mean: ", bootstrap_mean))
print(paste0("Bootstrap Standard Error: ", bootstrap_standard_error))
print(paste0("95% Confidence Interval: [", confidence_interval[1], ", ", confidence_interval[2], "]"))

bootstrap_df <- data.frame(means = bootstrap_sample_means) #create data frame to display it 

p <- ggplot(bootstrap_df, aes(x = means)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = diff(range(bootstrap_sample_means))/30,
                 fill = "skyblue", color = "black", alpha = 0.8) +
  geom_density(color = "red", size = 1) +
  geom_vline(aes(xintercept = mean(means)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = confidence_interval[1]), color = "blue", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = confidence_interval[2]), color = "blue", linetype = "dashed", size = 1) +
  annotate("text", x = Inf, y = Inf,
           label = paste("Bootstrap Mean: ", round(bootstrap_mean, 2), "\n",
                         "Bootstrap Standard Error: ", round(bootstrap_standard_error, 2), "\n",
                         "95% Confidence Interval: [", round(confidence_interval[1], 2), ", ", round(confidence_interval[2], 2), "]"), 
           hjust = "right", vjust = "top", size = 3) +
  #labels
  labs(x = "Sample Means", y = "Density",
              title = "Distribution of Bootstrap Sample Means") +
  theme_minimal()

# print the plot 
#(please do it separately)
print(p)

#Q5
#the correlation between price and the others
correlations <- cor(only_homes[, c('price', 'number.of.reviews', 'review.rate.number', 'availability.365', 'minimum.nights', 'calculated.host.listings.count')], use = "complete.obs")
correlations_with_price <- correlations['price',][-1]# excluding the correlation of price with itself
# convert to a data frame
correlations_df <- data.frame(Variable = names(correlations_with_price), Correlation = correlations_with_price)
# create the bar plot
ggplot(correlations_df, aes(x = reorder(Variable, Correlation), y = Correlation, fill = Correlation)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(x = "Variables", y = "Correlation with Price", title = "Correlation of Selected Variables with Price", fill = "Correlation") +
  scale_fill_gradient2(low = "red", high = "green", mid = "white", midpoint = 0) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


