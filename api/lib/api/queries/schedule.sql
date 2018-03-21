select 

a.activity_id 'id',
if (d.day_name like '%1', 1, if (d.day_name like '%2', 2, 0)) 'week',
SUBSTR(d.day_name, 1, GREATEST(LOCATE(' ', d.day_name, 1) - 1, 1)) 'day',
h.hour_name 'time',
r.room_name 'room',
tag.activity_tag_name 'type',
s.subject_name 'subject',
sg.subgroup_name 'subgroup',
t.teacher_name 'teacher',
g.group_name 'group',
f.faculty_abbr 'faculty'

from activities as a
inner join days as d on a.activity_day_id = d.day_id
inner join hours as h on a.activity_hour_id = h.hour_id
inner join rooms as r on a.activity_room_id = r.room_id
inner join activities_tags as tag on a.activity_tag_id = tag.activity_tag_id
inner join subjects as s on a.activity_subject_id = s.subject_id
inner join subgroups as sg on a.activity_subgroup_id = sg.subgroup_id
inner join teachers as t on a.activity_teacher_id = t.teacher_id
inner join groups as g on sg.subgroup_name like CONCAT(g.group_name, '%')
inner join faculties as f on g.group_faculty_id = f.faculty_id

where f.faculty_id = ?
    and g.group_id = ?
    and d.day_name like ?
    and t.teacher_name like ?
    and tag.activity_tag_name like ?
    and r.room_name like ?
    and h.hour_id like ?

order by d.day_id, h.hour_id

limit ?, ?