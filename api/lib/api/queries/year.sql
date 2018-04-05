select distinct

g.group_kurs 'id',
g.group_kurs 'name'

from zstu_schedule.groups as g
where not g.group_kurs = '0'
limit ?, ?