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

--serviços com gênero e faixa etária
select a.*, p.gender, p.age_group_first_admission as age_group
from patients_full p 
inner join services a
on p.subject_id = a.subject_id;

select icu.*
from icustays icu
inner join patients_full p 
on p.subject_id = icu.subject_id;

select icu.*
from icustays icu
inner join patients_full p 
on p.subject_id = icu.subject_id
where p.subject_id = 177;

-- qtde passagens pela UTI por cada paciente
select u.subject_id
--, u.hadm_id
,count(*) as qtd_adm
from patients p 
inner join icustays  u
on p.subject_id = u.subject_id
--group by u.subject_id, u.hadm_id
group by u.subject_id
order by qtd_adm desc;

-- qtde passagens pela UTI por cada paciente
select u.subject_id
--, u.hadm_id
,count(*) as qtd_adm
from patients p 
inner join icustays  u
on p.subject_id = u.subject_id
--group by u.subject_id, u.hadm_id
group by u.subject_id
order by qtd_adm desc;

select sum(teste.qtd_adm) FROM(
select u.subject_id
--, u.hadm_id
,count(*) as qtd_adm 
from patients p 
inner join icustays  u
on p.subject_id = u.subject_id
--group by u.subject_id, u.hadm_id
group by u.subject_id) as teste
order by qtd_adm desc;

-- agrupando pacientes na uti --> 46476 pacientes foram para UTI
select u.subject_id
from icustays  u
group by u.subject_id
order by u.subject_id desc;

select u.hadm_id
from icustays  u
group by u.hadm_id
order by u.subject_id desc;

-- agrupando pacientes na uti por atendimento--> 46476 pacientes foram para UTI
select u.subject_id, u.hadm_id
from icustays  u
group by u.subject_id, u.hadm_id
order by u.subject_id desc;

select count(*) from diagnoses_icd d;
select count(*) from d_icd_diagnoses d;

select * from d_icd_diagnoses d where d.icd9_code = '7895';

-- Diagnósticos com dados gerais dos pacientes
select d.*, dd.short_title, dd.long_title,
p.gender, p.expire_flag, p.age_group_first_admission as age_group
from diagnoses_icd d
inner join d_icd_diagnoses dd
on dd.icd9_code = d.icd9_code
inner join patients_full p 
on p.subject_id = d.subject_id;

select * from d_icd_diagnoses;
