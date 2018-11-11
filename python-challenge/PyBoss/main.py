import os

import csv 



#choose 1 or 2

file_num = 1



#creates file path as file

file = os.path.join('..', 'Resources', 'employee_data.csv')



#state abbr dictionary

us_state_abbrev = {

    'Alabama': 'AL',

    'Alaska': 'AK',

    'Arizona': 'AZ',

    'Arkansas': 'AR',

    'California': 'CA',

    'Colorado': 'CO',

    'Connecticut': 'CT',

    'Delaware': 'DE',

    'Florida': 'FL',

    'Georgia': 'GA',

    'Hawaii': 'HI',

    'Idaho': 'ID',

    'Illinois': 'IL',

    'Indiana': 'IN',

    'Iowa': 'IA',

    'Kansas': 'KS',

    'Kentucky': 'KY',

    'Louisiana': 'LA',

    'Maine': 'ME',

    'Maryland': 'MD',

    'Massachusetts': 'MA',

    'Michigan': 'MI',

    'Minnesota': 'MN',

    'Mississippi': 'MS',

    'Missouri': 'MO',

    'Montana': 'MT',

    'Nebraska': 'NE',

    'Nevada': 'NV',

    'New Hampshire': 'NH',

    'New Jersey': 'NJ',

    'New Mexico': 'NM',

    'New York': 'NY',

    'North Carolina': 'NC',

    'North Dakota': 'ND',

    'Ohio': 'OH',

    'Oklahoma': 'OK',

    'Oregon': 'OR',

    'Pennsylvania': 'PA',

    'Rhode Island': 'RI',

    'South Carolina': 'SC',

    'South Dakota': 'SD',

    'Tennessee': 'TN',

    'Texas': 'TX',

    'Utah': 'UT',

    'Vermont': 'VT',

    'Virginia': 'VA',

    'Washington': 'WA',

    'West Virginia': 'WV',

    'Wisconsin': 'WI',

    'Wyoming': 'WY',

}



# empty lists for parsed data

emp_id = []

first_name = []

last_name = []

dob =[]

ssn = []

state = []



#opens csv file and reads in as ordered dictionary

#no need to skip header row because itt serves as dict keys

with open(file, 'r') as csvfile:  

    reader = csv.DictReader(csvfile)

    # appends information to empty lists after being altered

    for row in reader:

        emp_id.append(row['Emp ID'])

        first_name.append(row['Name'].split(" ")[0])

        last_name.append(row['Name'].split(" ")[1])

        dob.append(row['DOB'].split('-')[1] + '/' + row['DOB'].split('-')[2] + '/' + row['DOB'].split('-')[0])

        ssn.append('***-**-' + row['SSN'].split('-')[2])

        state.append(us_state_abbrev[row['State']])

        

# zips lists together

new_data = zip(emp_id, first_name, last_name, dob, ssn, state)



#names output file

output_file = os.path.join('Output', 'clean_emp_data' + str(file_num) + '.csv')



#open and writes to csv

with open(output_file, 'w') as csvwrite:

    cleanfile = csv.writer(csvwrite, delimiter = ",")

    cleanfile.writerow(['Emp ID', 'First Name', 'Last Name', 'DOB', 'SSN', 'State'])

    cleanfile.writerows(new_data)