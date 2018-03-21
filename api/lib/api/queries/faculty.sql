select 

f.faculty_id 'id',
f.faculty_abbr 'abbr',
f.faculty_name 'name'

from faculties as f
order by f.faculty_id
limit ?, ?