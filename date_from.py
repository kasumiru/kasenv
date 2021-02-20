from datetime import datetime
from dateutil import relativedelta

def get_date_delta():
    date1 = datetime(1991, 7, 20)
    date2 = datetime(1999, 6, 6)
    
    diff = relativedelta.relativedelta(date2, date1)
    
    years = diff.years
    months = diff.months
    days = diff.days
    
    return '{} years {} months {} days'.format(years, months, days)

date = get_date_delta(sys.argv[0],sysargv[1])
print(date)
