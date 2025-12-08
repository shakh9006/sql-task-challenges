-- Source: https://www.codewars.com/kata/66aa0b0a9936648e423dd7ee/train/sql

--Title: Runner Results with Position-Based Competitor Info

select
  u1.name as runner_name,
  r1.run_id,
  r1.position,
  r1.race_id,
  u2.name || ' (' || u2.runner_id || ')' AS "win/second"
  from runs r1
left join runs r2
  on r1.race_id = r2.race_id
    and ((r1.position = 1 and r2.position = 2) or (r1.position != 1 and r2.position = 1))
left join runners u1
  on r1.runner_id = u1.runner_id
left join runners u2
  on r2.runner_id = u2.runner_id
inner join races
  on races.race_id = r1.race_id
where r1.runner_id = 1
order by races.date;