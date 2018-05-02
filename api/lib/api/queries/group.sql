select 

g.group_id 'id',
g.group_name 'name',
g.group_faculty_id 'facultyId',
g.group_kurs 'yearId'

from groups as g
where g.group_faculty_id = ?
    and g.group_kurs like CONCAT(?, '%')
order by g.group_id
limit ?, ?