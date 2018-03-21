select 

g.group_id 'id',
g.group_name 'name',
g.group_faculty_id 'faculty',
g.group_kurs 'year'

from groups as g
where g.group_faculty_id = ?
    and group_kurs like CONCAT(?, '%')
order by g.group_id
limit ?, ?