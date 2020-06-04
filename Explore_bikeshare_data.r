
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

head(ny)

head(wash)

head(chi)

#Function for loading data
Loaddata = function(){
    ny = read.csv('new_york_city.csv')
    wash = read.csv('washington.csv')
    chi = read.csv('chicago.csv')
    library(ggplot2)
    theme_set(theme_minimal(10))
}

# How many of each user type used the Bikeshare in New York?

#Load in data and settings
Loaddata()
#plot graph
ggplot(aes(x=User.Type), data = subset(ny, User.Type !="")) +
    geom_bar( color = '#a68fbf',
                fill = '#a68fbf') +
    ggtitle('Count by User Type in New York') +
    xlab('User Type') +
    ylab('User Count')

#This chart shows that in New York, the majority of users are subscribers, not passholder customers. There were about 10 times as many subscribers as customers, with Customers at roughly 5500 people and Subscribers at 49000. 119 uses were documented as empty cells, and this data was removed for clarity. 

#Which stations in Washington were used as the end point the most?

#load in data and settings
Loaddata()
#create a table of the count in each category
numbr<-count(wash$End.Station)
#graph the data from the table above
ggplot(aes(x=x, y=freq), data = subset(numbr, freq>600)) +
    geom_col(color ='#ffffff',
            fill = '#131a7c') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + #turn data labels on x axis by 45 deg
    ggtitle('Stations Used as End Points the Most in Washington') +
    xlab('Station name') +
    ylab('Number of Times Used as End Station')

# Looking at how many times each station was used as the end station and narrowing the results down to those which were used over 600 times. At just over 1750 entries, Union Station was the most common destination for bikeshare users in Washington, with 'Jefferson Dr & 14th St SW' coming second at around 1600 uses and Lincoln Memorial as the third with 1500 uses.

#What is the ride duration distribution by age in Chicago?

#load in data and settings
Loaddata()
#plot graph
ggplot(aes(y=Trip.Duration/60, x=2017-Birth.Year), data=chi) +
    geom_point(position=position_jitter(h=0),
              alpha=0.1,
              color='#006699') +
    coord_cartesian(ylim=c(0,100), xlim=c(18,100))  +
    ggtitle('Ride Duration by Age') +
    xlab('Age[in years]') +
    ylab('Ride Duration [in minutes]')

#The data show that the majority of rides were made by people between ages 20 to about 65. The longest rides were made by people under 50, and the most heavily populated area of the graph is for those between ages 25-38 who travelled for less than 15 minutes. Outliers in the dataset were removed (including people over the age of 100 and people who cycled over 100 minutes). There is no direct corelation between age and time cycled. 

system('python -m nbconvert Explore_bikeshare_data.ipynb')
