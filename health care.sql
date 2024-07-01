create database healthcare;
use healthcare;
select * from dialysis1;
select * from dialysis2;

-- KPI 1 Number of Patients across various summaries

select
sum(Patients_Hypercalcemia_Sum) as Hypercalcemia_Summary,
sum(Patients_Phosphorus_Sum) as Phosphorus_Summary,
sum(Patients_Hospitalization_Sum) as Hospitalization_Summary,
sum(Patients_Survival_Sum) as Survival_Summary,
sum(Patients_Long_Term_Catheter_Sum) as LongTermCatheter_Summary,
sum(Patients_Fistula_Sum) as Fistula_Summary,
sum(Patients_SWR) as SWR_Summary,
sum(Patients_PPPW) as PPPW_Summary,
sum(Patients_nPCR_Sum) as nPCR_Summary from dialysis1;

-- KPI 2 Profit Vs Non-Profit Stats

select 
Profit_NP,
count(*) as Count from dialysis1 
group by Profit_NP;

-- KPI 3 Chain Organizations w.r.t. Total Performance Score as No Score

SELECT 
d1.Chain_org as Chain_Organization, count(d2.`Total Performance Score`) as Total_Performace_Score
FROM dialysis1 d1
JOIN dialysis2 d2 ON d1.Prov_Num = d2.`CMS Certification Number (CCN)`
WHERE d2.`Total Performance Score`  = "No Score"
group by 1
order by 2 desc;

-- KPI 4 Dialysis Stations Stats

select 
Chain_Org, sum(Dial_Stations) as Delivery_Stations
from dialysis1
group by 1
order by 2 desc;

-- KPI 5 # of Category Text  - As Expected

select
count(case when Survival_Cat_Text= 'As Expected' then 1 end) as Patients_Survival_Cat_Text,
count(case when Infection_Cat_Text = 'As Expected' then 1 end) as Patients_Infection_Cat_Texts,
count(case when SWR_Cat_Text = 'As Expected' then 1 end) as Patients_Swr_Category_Text,
count(case when Transfusion_Cat_Text= 'As Expected' then 1 end) as Patients_Transfusion_Cat_Text,
count(case when Fistula_Cat_Text= 'As Expected' then 1 end) as Patients_Fistula_Cat_Text,
count(case when PPPW_Cat_Text= 'As Expected' then 1 end) as Patients_PPPW_Cat_Text,
count(case when Hospitalization_Cat_Text= 'As Expected' then 1 end) as Patients_Hospitalization_Cat_Text
from dialysis1;

-- KPI 6 Average Payment Reduction Rate

select concat(round((sum(`PY2020 Payment Reduction Percentage`)
/count(case when `PY2020 Payment Reduction Percentage`!= 'No Reduction' then 1 end)*100),2),'%') 
as 'Average Payment Reduction Rate' from dialysis2;
