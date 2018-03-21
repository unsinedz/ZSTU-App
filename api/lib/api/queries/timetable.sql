select 

h.hour_id 'id',
h.hour_name 'timeInterval'

from hours as h
order by h.hour_id
limit ?, ?