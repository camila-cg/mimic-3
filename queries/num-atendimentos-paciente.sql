set schema 'mimiciii';

-- qtde atendimentos por cada paciente
select p.subject_id, count(*) as qtd_adm
from patients p 
inner join admissions  u
on p.subject_id = u.subject_id
group by p.subject_id
order by qtd_adm desc;

-- agrupando a qtde de atendimentos de cada paciente
-- para saber a qtde de pacientes por qtde de atendimentos
with teste as (
select p.subject_id, count(*) as qtd_adm
from patients p 
inner join admissions  u
on p.subject_id = u.subject_id
group by p.subject_id
order by qtd_adm desc
) select qtd_adm, count(*) as cont
from teste
group by qtd_adm
order by cont desc;

--atendimentos com gênero
select a.*, p.gender
from patients p 
inner join admissions a
on p.subject_id = a.subject_id;

--serviços com gênero
select a.*, p.gender
from patients p 
inner join services a
on p.subject_id = a.subject_id;


