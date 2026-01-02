-- Source: https://www.codewars.com/kata/6926de8ca1f37bc6445af392/train/sql

--Title: Exact Match: Agents Sharing the Same Workload

WITH agent_sets AS (
  SELECT
      agent_id,
      ARRAY_AGG(DISTINCT ticket_id ORDER BY ticket_id) AS tickets
  FROM agent_ticket_assignments
  GROUP BY agent_id
)
SELECT
    a.agent_id AS agent1_id,
    b.agent_id AS agent2_id
FROM agent_sets a
JOIN agent_sets b
  ON a.tickets = b.tickets
 AND a.agent_id < b.agent_id
ORDER BY 1, 2;

