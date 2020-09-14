# Leonard Ma and Rickey Dong
# Period 9 Annual Intro CS with Mr. DW
# Project 00: Big Data, BIGGER Fun
# ------------------------------------------------------------------------------------
# The data that we will be processing and analyzing in this Python
# program is about airplane travel. Our data shows information about 
# airplane delay times of different airports across different dates 
# with different airline companies. We'll be analyzing a variety
# of factors, such as airlines, flight date, etc.
# The link to the data source about delay times is
# https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time
# The link to the data source about airline company codes is
# https://www.transtats.bts.gov/Download_Lookup.asp?Lookup=L_CARRIER_HISTORY
# When analyzing the delay times, note that negative time means early and
# positive time means tardy.
# Make sure to full screen the graphs for full immersion.
# ------------------------------------------------------------------------------------
import matplotlib.pyplot as plt
import numpy as np

# corresponding indicies to each type of data
DAYOFWEEK = 0
AIRCODE = 0
AIRPORTTERMINAL = 0
LAT = 1
FLIGHTDATE = 1
AIRCOMPANY = 1
LONG = 2
AIRCRAFTCOMPANY = 2
ORIGINCITY = 3
ORIGINSTATE = 4
DESTINATION = 5
ARRIVALDELAY = 6
ETT = 7
DISTANCE = 8
EMPTY = 9
#=========================================================================
# ~creating dictionary of corresponding airline codes to airline names~
# Function codecompanydict takes a string and returns a dictionary 
# with all of the airline codes as keys and airline companies as values

f = open("airline_list.txt")
airlinestr = f.read()
f.close()

def codecompanydict(s):
    ret = {}
    key = ''
    g = s[s.find("\n")+ 1: ].split('\n')
    for thing in g:
        thing = thing.split(',')
        if len(thing) == 2:
            variable = '('
            index = thing[AIRCOMPANY].find(variable) - 1
            key = thing[AIRCODE][1:len(thing[AIRCODE]) - 1]
            ret[key] = thing[AIRCOMPANY][1:index]
    return ret

airlines = codecompanydict(airlinestr)
#=========================================================================
# ~creating a list for each individual flight~
# Function listperflight takes a string and separates the data into individual lists for 
# each flight and gets rid of any missing data and returns all of those lists
# direction_sep  further separates into two lists: arrivals and deparatures

f = open("delay_data.csv")
delaystr = f.read()
f.close()

def listperflight(s):
  ret = []
  g = s[s.find("\n")+ 1: ].split("\n")
  for thing in g:
    gooddata = True
    thing = thing.split(',')
    index = 0
    while index <= DISTANCE:
      if thing[index] == '':
        gooddata = False
      if index == DAYOFWEEK or index > DESTINATION:        
        if gooddata == True:
          thing[index] = float(thing[index])
      else:
          if index != FLIGHTDATE:
            thing[index] = thing[index]
      index += 1
    thing.pop(EMPTY)
    if gooddata == True:
      ret.append(thing)
  return ret

def direction_sep(g, direction):
  ret = []
  for g0 in g:
    if direction == "departure":
      if g0[ORIGINSTATE] == "NY":
        ret.append(g0)
    else:
      if g0[ORIGINSTATE] != "NY":
        ret.append(g0)
  return ret 

delaylist = listperflight(delaystr)
delaylist_DEPARTURE = direction_sep(delaylist, "departure")
delaylist_ARRIVAL = direction_sep(delaylist, "arrival")
#-------------------------------------------------------------------------------------
# ~compares information in parameter column to the ratio between delay time and 
# Estimated Travel Time (ETT)~
# Function sortby takes a string and a desired column to compare the information
# between that column and how slow/fast a plane traveled compared 
# to an ETT (our custom unit of time: mins delay/scheduled hour of flight)

def sortby(s, column):
  ret = {}
  key = ''
  for thing in s:
    if (thing[column] not in ret):
      key = thing[column]
      g = []
      g.append(thing[ARRIVALDELAY])
      g.append(thing[ETT])
      ret[key] = g
    else:
      g = []
      g.append(thing[ARRIVALDELAY] + ret[thing[column]][0])
      g.append(thing[ETT] + ret[thing[column]][1])
      ret[thing[column]] = g
  for key,l in ret.items():
    ret[key] = (l[0]/l[1])*60 
  return ret

#====================================================
#dictionary key fixers to make them easier to understand

def dictkey_AIRCRAFTCOMPANY(sorted_data, airlines):
  ret = {}
  for key, l in sorted_data.items():
    ret[(airlines.get(key))] = l
  return ret

def dictkey_FLIGHTDATE(sorted_data):
  ret = {}
  notordered = {}
  key1 = 1
  for key, l in sorted_data.items():
    notordered[int(key[-2:])] = l
  while key1 < 32:
    ret[key1] = notordered[key1]
    key1 += 1
  return ret

#====================================================
# Used to sort amount of flight delays by day of flight
sortby_DAYOFWEEK_ARRIVAL = sortby(delaylist_ARRIVAL, DAYOFWEEK)
sortby_DAYOFWEEK_DEPARTURE = sortby(delaylist_DEPARTURE, DAYOFWEEK)

DAYOFWEEKXvalnames = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"]
DAYOFWEEKYval_ARRIVAL = list(sortby_DAYOFWEEK_ARRIVAL.values())
DAYOFWEEKYval_DEPARTURE = list(sortby_DAYOFWEEK_DEPARTURE.values())

#=========================================================================
# Used to sort data by specific day in month of January
sortby_FLIGHTDATE = dictkey_FLIGHTDATE(sortby(delaylist, FLIGHTDATE))

FLIGHTDATEXvalnames = list(sortby_FLIGHTDATE.keys())
FLIGHTDATEYval = list(sortby_FLIGHTDATE.values())

#=========================================================================
# Used to sort delays by airlines in bar graph form in delay/hour scheduled flight

sortby_AIRCRAFTCOMPANY_ARRIVAL = dictkey_AIRCRAFTCOMPANY(sortby(delaylist_ARRIVAL, AIRCRAFTCOMPANY), airlines)

sortby_AIRCRAFTCOMPANY_DEPARTURE = dictkey_AIRCRAFTCOMPANY(sortby(delaylist_DEPARTURE, AIRCRAFTCOMPANY), airlines)

airconames = sorted(sortby_AIRCRAFTCOMPANY_ARRIVAL, key=str.lower)

def dict_alphabetical(airconames, s):
    ret = []
    for i in airconames:
        ret.append(s[i])
    return ret

sortby_AIRCRAFTCOMPANY_ARRIVAL = dict_alphabetical(airconames, sortby_AIRCRAFTCOMPANY_ARRIVAL)

sortby_AIRCRAFTCOMPANY_DEPARTURE = dict_alphabetical(airconames, sortby_AIRCRAFTCOMPANY_DEPARTURE)
#==============================================================================
# Used to sort delays by distance for a scatterplot

sortby_DISTANCE_DELAY = sortby(delaylist, DISTANCE)
distancesXval = list(sortby_DISTANCE_DELAY.keys())
delaysdistYval = list(sortby_DISTANCE_DELAY.values())
#==============================================================================
# Used to create lists for pie charts of percentages of flights, delayed flights for each company

# total number of delayed flights in dataset
def countnumberofdelayedflights(s):
    number = 0
    for flight in s:
        if flight[ARRIVALDELAY] > 0:
            number += 1
    return number

# total number of flights in dataset
def countnumberofflights(s):
    number = 0
    for flight in s:
        number += 1
    return number

# number of delayed flights for each airline
def whichcompaniessuck(s):
    num = {}
    ret = {}
    key = ''
    for flight in s:
        if (flight[AIRCRAFTCOMPANY] not in num):
            if flight[ARRIVALDELAY] > 0:
                key = flight[AIRCRAFTCOMPANY]
                num[key] = 1
        else:
            if flight[ARRIVALDELAY] > 0:
                num[flight[AIRCRAFTCOMPANY]] += 1
    for airline, count in num.items():
        ret[airline] = (count / countnumberofdelayedflights(s)) * 100
    return ret

# number of flights for each airline
def howmanyflights(s):
    num = {}
    ret = {}
    key = ''
    for flight in s:
        if (flight[AIRCRAFTCOMPANY] not in num):
            key = flight[AIRCRAFTCOMPANY]
            num[key] = 1
        else:
            num[flight[AIRCRAFTCOMPANY]] += 1
    for airline, count in num.items():
        ret[airline] = (count / countnumberofflights(s)) * 100
    return ret

AIRLINE_DELAYED = dictkey_AIRCRAFTCOMPANY(whichcompaniessuck(delaylist), airlines)
listofcompanynames_0 = list(AIRLINE_DELAYED.keys())
listoftheirdelayspercent_0 = list(AIRLINE_DELAYED.values())

AIRLINE_FLIGHTS = dictkey_AIRCRAFTCOMPANY(howmanyflights(delaylist), airlines)
listofcompanynames_1 = list(AIRLINE_FLIGHTS.keys())
listoftheirflightspercent_1 = list(AIRLINE_FLIGHTS.values())

#-------------------------------------------------------------------------------------
# PLOTS

# pie chart between total number of delayed flights and contributing companies
print("From this pie chart shown, it appears that Delta Airlines is the biggest contributor to delayed flight cases in NY by number. However, we must also take into account how much of the data reported is Delta flights, especially since they are such a massive company.")
labels = listofcompanynames_0
sizes = listoftheirdelayspercent_0
fig1, ax1 = plt.subplots()
ax1.pie(sizes, labels = labels, autopct='%1.1f%%', textprops = {'fontsize': 6})
plt.suptitle("Companies' Contribution to the Number of Flight Delays in New York")
plt.show()

#====================================================================================
# pie chart of total flights and company

print("""


Based on this pie chart, companies like Delta and Jetblue have the most amount of flights in this data set. This makes sense, since both of them have huge bases in NYC,
and this contributes to the high delay contributions seen in the first pie chart.""")

labels = listofcompanynames_1
sizes = listoftheirflightspercent_1
fig1, ax1 = plt.subplots()
ax1.pie(sizes, labels = labels, autopct='%1.1f%%', textprops = {'fontsize': 6})
plt.suptitle("Companies' Contribution to the Total Number of Flights Operated in New York")
plt.show()

#=====================================================================
# scatter plot between distance and delay

print("""

From this scatter plot shown, our hypothesis that the longer the distance of the flight, there would be more occurrences of a delayed arrival is incorrect.
We thought this because we thought there would be more of a margin for error such as laziness from the pilots or increased drowsiness of the pilots.
However, from the graph, it seems that the flights have the same delay time average regardless of the distance of the flight.""")

plt.scatter(distancesXval, delaysdistYval, 10)
plt.ylabel('Average Delay Time In Minutes Per Hour')
plt.xlabel('Distance of a Flight in Miles')
plt.suptitle('Correlation Between Length of a Flight and Potential Room for Delay')
plt.show()

#=====================================================================================

#Grouped bar graph showing correlation between day of week and arrival/departure delays

print("""

From this double bar graph, we see Saturdays as the day with the most delays. It also shows that arrivals in New York have significiantly more delays than those departing from New York.""")

x = np.arange(len(DAYOFWEEKXvalnames))
width = 0.3

fig, ax = plt.subplots()
rects1 = ax.bar(x - width/2, DAYOFWEEKYval_ARRIVAL, width, label = 'ARRIVALS')
rects2 = ax.bar(x + width/2, DAYOFWEEKYval_DEPARTURE, width, label = 'DEPARTURES')

ax.set_ylabel('Average Delay Time In Minutes Per Hour')
ax.set_xlabel('Day of the Week')
ax.set_xticks(x)
ax.set_xticklabels(DAYOFWEEKXvalnames)
ax.legend()
ax.set_title('Correlation Between Day of the Week and Delay Times')
plt.show()

#===================================================================================
#Bar graph of delays for all NY flights in relation to each day in the month of January
print("""

From this double bar graph shown, it is apparent that there is a phenomena where airlines have 'streaks.' Some times, as shown in Days 16-18, airlines can have bad streaks in consecutive delays.""")
plt.bar(FLIGHTDATEXvalnames,FLIGHTDATEYval)
plt.ylabel("Average Delay Time In Minutes Per Hour")
plt.xlabel("Dates of January")
plt.suptitle("Delays Across the Month of January")
plt.show()

#============================================================================
#Grouped bar graph comparing airlines to average delay time (separtely for arrivals and departures)

print("""

PSA: Don't take PSA Airlines. If they get delayed, good luck.""")

x = np.arange(len(airconames))
width = 0.3
fig, ax = plt.subplots()
rects1 = ax.bar(x - width/2, sortby_AIRCRAFTCOMPANY_ARRIVAL, width, label = 'ARRIVALS')
rects2 = ax.bar(x + width/2, sortby_AIRCRAFTCOMPANY_DEPARTURE, width, label = 'DEPARTURES')

ax.set_ylabel('Average Delay Time in Minutes Per Hour')
ax.set_xlabel('Airline Company')
ax.set_xticks(x)
ax.set_xticklabels(airconames)
ax.autoscale(tight=True)
for tick in ax.get_xticklabels():
    tick.set_rotation(20)
ax.legend()
ax.tick_params(labelsize=8)
ax.set_title('Companies and The Severity of their Delays')
plt.show()