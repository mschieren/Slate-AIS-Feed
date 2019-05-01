declare @round varchar(16) select @round = '2019'
declare @winterquarter varchar(16) select @winterquarter = 'xwinter'
declare @springquarter varchar(16) select @springquarter = 'xspring'
declare @summerquarter varchar(16) select @summerquarter = 'summer'
declare @autumnquarter varchar(16) select @autumnquarter = 'autumn'

-- we use the declare statement above to control when specific quarters can feed into our SIS

select distinct
(select [value] from dbo.getSourceIndexTable(r.[id], 'SlateID')) as [SlateID], -- 'Ref'
(select [value] from dbo.getSourceIndexTable(r.[id], 'SlateAppID')) as [SlateAppID], -- Application Ref
(select [value] from dbo.getSourceIndexTable(r.[id], 'UCID')) as [UCID], -- PS Primary Key / EMPLID
(select [value] from dbo.getSourceIndexTable(r.[id], 'LastName')) as [LastName],
(select [value] from dbo.getSourceIndexTable(r.[id], 'FirstName')) as [FirstName],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MiddleName')) as [MiddleName],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PreferredName')) as [PreferredName],
(select [value] from dbo.getSourceIndexTable(r.[id], 'BirthCity')) as [BirthCity],
(select [value] from dbo.getSourceIndexTable(r.[id], 'BirthRegion')) as [BirthRegion],
(select [value] from dbo.getSourceIndexTable(r.[id], 'BirthCountry')) as [BirthCountry],

case 
when (select [value] from dbo.getSourceIndexTable(r.[id], 'SSN')) like '9%' then null 
when (select [value] from dbo.getSourceIndexTable(r.[id], 'SSN')) like '666%' then null 
when (select [value] from dbo.getSourceIndexTable(r.[id], 'SSN')) like '000%' then null 
else (select [value] from dbo.getSourceIndexTable(r.[id], 'SSN')) end as [SSN], 

-- this is an attempt at filtering out bad SSNs before reaching PS

convert(date,(select [value] from dbo.getSourceIndexTable(r.[id], 'DateOfBirth'))) as [DateOfBirth],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Gender')) as [Gender],
(select [value] from dbo.getSourceIndexTable(r.[id], 'RaceType')) as [RaceType],
(select [value] from dbo.getSourceIndexTable(r.[id], 'RaceCode')) as [RaceCode],
(select [value] from dbo.getSourceIndexTable(r.[id], 'CitizenshipStatus')) as [CitizenshipStatus],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Citizenship1')) as [Citizenship1],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Citizenship2')) as [Citizenship2],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Status')) as [Status],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Round')) as [Round],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Quarter')) as [Quarter],
replace(replace((select [value] from dbo.getSourceIndexTable(r.[id], 'Phone')),'ext.','x'),'+','') as [Phone], -- we were asked to remove special characters from Phone Numbers due to an issue with a system downstream from PS
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailStreet1')) as [MailStreet1],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailStreet2')) as [MailStreet2],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailStreet3')) as [MailStreet3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailCity')) as [MailCity],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailRegion')) as [MailRegion],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailPostal')) as [MailPostal],
(select [value] from dbo.getSourceIndexTable(r.[id], 'MailCountry')) as [MailCountry],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermStreet1')) as [PermStreet1],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermStreet2')) as [PermStreet2],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermStreet3')) as [PermStreet3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermCity')) as [PermCity],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermRegion')) as [PermRegion],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermPostal')) as [PermPostal],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PermCountry')) as [PermCountry],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Degree')) as [Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'DegreeProgram')) as [DegreeProgram],
(select [value] from dbo.getSourceIndexTable(r.[id], 'DegreeProgramCode')) as [DegreeProgramCode],
(select [value] from dbo.getSourceIndexTable(r.[id], 'SAT Verbal')) as [SAT Verbal],
(select [value] from dbo.getSourceIndexTable(r.[id], 'SAT Math')) as [SAT Math],
(select [value] from dbo.getSourceIndexTable(r.[id], 'SAT Writing')) as [SAT Writing],
(select [value] from dbo.getSourceIndexTable(r.[id], 'ACT English')) as [ACT English],
(select [value] from dbo.getSourceIndexTable(r.[id], 'ACT Math')) as [ACT Math],
(select [value] from dbo.getSourceIndexTable(r.[id], 'ACT Reading')) as [ACT Reading],
(select [value] from dbo.getSourceIndexTable(r.[id], 'ACT Science')) as [ACT Science],
(select [value] from dbo.getSourceIndexTable(r.[id], 'TOEFL')) as [TOEFL],
(select [value] from dbo.getSourceIndexTable(r.[id], 'DepositStatus')) as [DepositStatus],
(select [value] from dbo.getSourceIndexTable(r.[id], 'DepositDate')) as [DepositDate],
(select [value] from dbo.getSourceIndexTable(r.[id], 'DepositInfo')) as [DepositInfo],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1')) as [PrevSchool1],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1Key')) as [PrevSchool1Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1Category')) as [PrevSchool1Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1Verified')) as [PrevSchool1Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1Years')) as [PrevSchool1Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1Degree')) as [PrevSchool1Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool1DegreeYear')) as [PrevSchool1DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2')) as [PrevSchool2],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2Key')) as [PrevSchool2Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2Category')) as [PrevSchool2Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2Verified')) as [PrevSchool2Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2Years')) as [PrevSchool2Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2Degree')) as [PrevSchool2Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool2DegreeYear')) as [PrevSchool2DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3')) as [PrevSchool3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3Key')) as [PrevSchool3Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3Category')) as [PrevSchool3Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3Verified')) as [PrevSchool3Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3Years')) as [PrevSchool3Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3Degree')) as [PrevSchool3Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool3DegreeYear')) as [PrevSchool3DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4')) as [PrevSchool4],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4Key')) as [PrevSchool4Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4Category')) as [PrevSchool4Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4Verified')) as [PrevSchool4Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4Years')) as [PrevSchool4Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4Degree')) as [PrevSchool4Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool4DegreeYear')) as [PrevSchool4DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5')) as [PrevSchool5],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5Key')) as [PrevSchool5Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5Category')) as [PrevSchool5Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5Verified')) as [PrevSchool5Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5Years')) as [PrevSchool5Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5Degree')) as [PrevSchool5Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool5DegreeYear')) as [PrevSchool5DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6')) as [PrevSchool6],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6Key')) as [PrevSchool6Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6Category')) as [PrevSchool6Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6Verified')) as [PrevSchool6Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6Years')) as [PrevSchool6Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6Degree')) as [PrevSchool6Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool6DegreeYear')) as [PrevSchool6DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7')) as [PrevSchool7],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7Key')) as [PrevSchool7Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7Category')) as [PrevSchool7Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7Verified')) as [PrevSchool7Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7Years')) as [PrevSchool7Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7Degree')) as [PrevSchool7Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool7DegreeYear')) as [PrevSchool7DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8')) as [PrevSchool8],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8Key')) as [PrevSchool8Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8Category')) as [PrevSchool8Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8Verified')) as [PrevSchool8Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8Years')) as [PrevSchool8Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8Degree')) as [PrevSchool8Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool8DegreeYear')) as [PrevSchool8DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9')) as [PrevSchool9],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9Key')) as [PrevSchool9Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9Category')) as [PrevSchool9Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9Verified')) as [PrevSchool9Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9Years')) as [PrevSchool9Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9Degree')) as [PrevSchool9Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool9DegreeYear')) as [PrevSchool9DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10')) as [PrevSchool10],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10Key')) as [PrevSchool10Key],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10Category')) as [PrevSchool10Category],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10Verified')) as [PrevSchool10Verified],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10Years')) as [PrevSchool10Years],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10Degree')) as [PrevSchool10Degree],
(select [value] from dbo.getSourceIndexTable(r.[id], 'PrevSchool10DegreeYear')) as [PrevSchool10DegreeYear],
(select [value] from dbo.getSourceIndexTable(r.[id], 'Email')) as [Email],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlStreet1')) as [IntlStreet3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlStreet2')) as [IntlStreet3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlStreet3')) as [IntlStreet3],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlCity')) as [IntlCity],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlRegion')) as [IntlRegion],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlPostal')) as [IntlPostal],
(select [value] from dbo.getSourceIndexTable(r.[id], 'IntlCountry')) as [IntlCountry]

from [source.record] r
inner join [source] s on (s.[id] = r.[source])
where 

([format] in (select [id] from [source.format] where ([name] in (
'BSDfeed', -- Biological Sciences Division / BSD
'DIVfeed', -- Divinity School
'GRAfeed', -- Graham School of Continuing and Professional Studies
'HARfeed', -- Harris School of Public Policy
'HUMfeed', -- Humanities Division
'IMEfeed', -- Institute for Molecular Engineering
'PSDfeed', -- Physical Sciences Division
'SSAfeed', -- School of Social Service Administration
'SSDFeed', -- Social Sciences Division

-- these are the 9 "fellowship" schools ;)

'COLFeed', -- Undergrad Student At Large Feed (the College has it's own separate Slate > SIS Feed, but we feed SALs through Apply-Grad for ease of processing)
'SUMRFeed' -- Summer Session Feed (these also feed from the Undergrad > Apply-Grad for ease of processing to SIS)
))))
and
(
((select [value] from dbo.getSourceIndexTable(r.[id], 'ReleasedDate')) is not null)
	and
((select [value] from dbo.getSourceIndexTable(r.[id], 'DecisionCode')) in ('AM','AW','AR','GP','GA','GD','AT','AD','AN','GU'))
	or
((select [value] from dbo.getSourceIndexTable(r.[id], 'DecisionUpdate')) = 1)
)
and
((select [value] from dbo.getSourceIndexTable(r.[id], 'DegreeProgramCode')) is not null)
and
((select [value] from dbo.getSourceIndexTable(r.[id], 'Round')) != '2016 SMRS')
and
(
((select [value] from dbo.getSourceIndexTable(r.[id], 'Round')) like convert(char(4),@round+1)+'%')
or
((select [value] from dbo.getSourceIndexTable(r.[id], 'Round')) like @round + '%')
)

union all

-- Outside of the general composite feed from our subsystems, we also feed a 'quick-admit' form from Apply-grad that contains programs whose applications/processing happens outside of Slate

select distinct
'GRD' + p.[ref] as [SlateID],
p.[ref] as [SlateAppID],
(select [value] from dbo.getFieldTopTable(p.[id], 'ucid')) as [UCID],
p.[last] as [LastName], 
p.[first] as [FirstName], 
p.[middle] as [MiddleName],
p.[preferred] as [PreferredName],
null as [BirthCity], 
null as [BirthRegion], 
null as [BirthCountry], 
p.[ssn] as [SSN], 
p.[birthdate] as [DateOfBirth], 
p.[sex] as [Gender], 
(case when p.[id] in (select [record] from [field] where [field] = 'hispanic' and [value] = '1') then 'SA' else (select top 1 _p.[export] 
from [field] _f 
inner join [lookup.prompt] _p on (_p.[id] = _f.[prompt]) 
where (_f.[record] = p.[id]) and (_f.[field] = 'race') and (_p.[export] is not null) and (_p.[value] not like '% - %') order by _p.[index] asc) end) as 
[RaceType], 
(case when p.[id] in (select [record] from [field] where [field] = 'hispanicOrigin') then (select [value] from dbo.getFieldExportTable(p.[id], 'hispanicOrigin')) else (select top 1 _p.[export] 
from [field] _f 
inner join [lookup.prompt] _p on (_p.[id] = _f.[prompt]) 
where (_f.[record] = p.[id]) and (_f.[field] = 'race') and (_p.[export] is not null) and (_p.[value] like '% - %') order by _p.[index] asc) end) 
as [RaceCode], 

(select top 1 coalesce(__p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = '4f66fc76-af49-40e8-9782-c321c6e6e458')) as [CitizenshipStatus], 

(select (select [alpha2] from world.dbo.[country] where (coalesce([sort],[name]) = (select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = 'dd25e029-7f80-45ca-99f0-3292ec1fec60'))))) as [Citizenship1], 

(select (select [alpha2] from world.dbo.[country] where (coalesce([sort],[name]) = (select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = '0782256f-4d9b-4700-9653-40965f04d691'))))) as [Citizenship2], 

'Admit/Attend' as [Status], 

(select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = 'a6972bf2-5197-46a3-9a42-5a668ab3c28c')) as [Round], 
(select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = '3529d78d-e3a8-48ce-9d40-62ca5f9ecd72')) as [Quarter], 
	
replace(p.[phone],'+','') as [Phone], 
dbo.getToken(char(10), ad.[street], 1) as [MailStreet1], 
dbo.getToken(char(10), ad.[street], 2) as [MailStreet2], 
dbo.getToken(char(10), ad.[street], 3) as [MailStreet3],
ad.[city] as [MailCity], 
ad.[region] as [MailRegion], 
ad.[postal] as [MailPostal], 
adc.[alpha2] as [MailCountry],
dbo.getToken(char(10), adp.[street], 1) as [PermStreet1], 
dbo.getToken(char(10), adp.[street], 2) as [PermStreet2], 
dbo.getToken(char(10), adp.[street], 3) as [PermStreet3], 
adp.[city] as [PermCity], 
(select top 1 [id] from [lookup.region] where ([id] = adp.[region])) as [PermRegion], 
adp.[postal] as [PermPostal], 
adpc.[alpha2] as [PermCountry],

(select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = 'a36bcd73-1cbc-4554-8846-15fb13d000d8')) as [Degree], 
(select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = '4cf009f0-e0f1-47b9-97d1-21f8181403e2')) as [DegreeProgram], 
	
null as [DegreeProgramCode], 

null as [SAT Verbal], 
null as [SAT Math], 
null as [SAT Writing], 
null as [ACT English], 
null as [ACT Math], 
null as [ACT Reading], 
null as [ACT Science], 
null as [TOEFL],
null as [DepositStatus],
null as [DepositDate],
null as [DepositInfo],

null as [PrevSchool1], 
null as [PrevSchool1Key], 
null as [PrevSchool1Category],
null as [PrevSchool1Verified],
null as [PrevSchool1Years],
null as [PrevSchool1Degree],
null as [PrevSchool1DegreeYear],

null as [PrevSchool2], 
null as [PrevSchool2Key], 
null as [PrevSchool2Category],
null as [PrevSchool2Verified],
null as [PrevSchool2Years],
null as [PrevSchool2Degree],
null as [PrevSchool2DegreeYear],

null as [PrevSchool3], 
null as [PrevSchool3Key], 
null as [PrevSchool3Category],
null as [PrevSchool3Verified],
null as [PrevSchool3Years],
null as [PrevSchool3Degree],
null as [PrevSchool3DegreeYear],

null as [PrevSchool4], 
null as [PrevSchool4Key], 
null as [PrevSchool4Category],
null as [PrevSchool4Verified],
null as [PrevSchool4Years],
null as [PrevSchool4Degree],
null as [PrevSchool4DegreeYear],

null as [PrevSchool5], 
null as [PrevSchool5Key], 
null as [PrevSchool5Category],
null as [PrevSchool5Verified],
null as [PrevSchool5Years],
null as [PrevSchool5Degree],
null as [PrevSchool5DegreeYear],

null as [PrevSchool6], 
null as [PrevSchool6Key], 
null as [PrevSchool6Category],
null as [PrevSchool6Verified],
null as [PrevSchool6Years],
null as [PrevSchool6Degree],
null as [PrevSchool6DegreeYear],

null as [PrevSchool7], 
null as [PrevSchool7Key], 
null as [PrevSchool7Category],
null as [PrevSchool7Verified],
null as [PrevSchool7Years],
null as [PrevSchool7Degree],
null as [PrevSchool7DegreeYear],

null as [PrevSchool8], 
null as [PrevSchool8Key], 
null as [PrevSchool8Category],
null as [PrevSchool8Verified],
null as [PrevSchool8Years],
null as [PrevSchool8Degree],
null as [PrevSchool8DegreeYear],

null as [PrevSchool9], 
null as [PrevSchool9Key], 
null as [PrevSchool9Category],
null as [PrevSchool9Verified],
null as [PrevSchool9Years],
null as [PrevSchool9Degree],
null as [PrevSchool9DegreeYear],

null as [PrevSchool10], 
null as [PrevSchool10Key], 
null as [PrevSchool10Category],
null as [PrevSchool10Verified],
null as [PrevSchool10Years],
null as [PrevSchool10Degree],
null as [PrevSchool10DegreeYear],

p.[email] as [Email]

--/*
,
dbo.getToken(char(10), adi.[street], 1) as [IntlStreet1], 
dbo.getToken(char(10), adi.[street], 2) as [IntlStreet2], 
dbo.getToken(char(10), adi.[street], 3) as [IntlStreet3],
adi.[city] as [IntlCity], 
(select top 1 [id] from [lookup.region] where ([id] = adi.[region])) as [IntlRegion], 
adi.[postal] as [IntlPostal], 
adic.[alpha2] as [IntlCountry]
--*/

from [form.response] __r
inner join [form] __f on (__f.[id] = __r.[form])
left outer join [form] __fp on (__fp.[id] = __f.[parent])
left outer join [user] __u on (__u.[id] = __f.[user])
left outer join [user] __u2 on (__u2.[id] = __r.[user])
left outer join [person] p on (p.[id] = __r.[record])
left outer join [address] ad on (ad.[record] = p.[id]) and (ad.[type] is null) and (ad.[rank] = 1)
left outer join [lookup.country] adc on (adc.[id] = ad.[country])
left outer join [address] adp on (adp.[record] = p.[id]) and (adp.[type] = 'permanent') and (adp.[rank] = 1)
left outer join [lookup.country] adpc on (adpc.[id] = adp.[country])

left outer join [address] adi on (adi.[record] = p.[id]) and (adi.[type] = 'permanent') and (adi.[rank] = 1) and (adi.[country] != 'US') and (adi.[record] in (select [id] from [person] where ([id] = p.[id]) and ([citizenship] = 'FN')))
left outer join [lookup.country] adic on (adic.[id] = adi.[country])

left outer join [field] hs_f on (hs_f.[record] = p.[id]) and (hs_f.[field] = 'ceeb')
left outer join [dataset.row] hs on (hs.[dataset] = 'B1818A40-245E-407D-9C7A-7326A232F56D') and (hs.[key] = hs_f.[index])
left outer join [activity] __pd on (__pd.[id] = __r.[payment_due]) and (__r.[payment_due] is not null)
where
(__f.[id] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') 
and 
(__r.[pending] = 0) 
and 
(__r.[active] = 1)
and
((select top 1 coalesce(__ffp.[value], __p.[value], __frf.[value]) from [form.response.field] __frf left outer join [form.field.prompt] __ffp on (__ffp.[form] = 'F1D305F3-F280-446E-9BC9-BD535E2BEFD1') and (__ffp.[field] = __frf.[field]) and (__ffp.[id] = __frf.[index]) left outer join [lookup.prompt] __p on (__p.[id] = try_convert(uniqueidentifier, __frf.[index])) where (__frf.[response] = __r.[id]) and (__frf.[field] = 'a6972bf2-5197-46a3-9a42-5a668ab3c28c')) =  @round)

--	and	not exists (select * from [field] where ([record] = p.[id]) and ([field] = 'ucid') and ([value] is not null))

union all

-- finally, we have a small selection of speciality applications that exist in Apply-Grad because they function outside of traditional divisional control, we also append these programs to our master SIS feed

select distinct
'GRD' + p.[ref] as [SlateID],
p.[ref] as [SlateAppID],
(select [value] from dbo.getFieldTopTable(p.[id], 'ucid')) as [UCID],
p.[last] as [LastName], 
p.[first] as [FirstName], 
p.[middle] as [MiddleName],
p.[preferred] as [PreferredName],
null as [BirthCity], 
null as [BirthRegion], 
null as [BirthCountry], 
p.[ssn] as [SSN], 
p.[birthdate] as [DateOfBirth], 
p.[sex] as [Gender], 
(case when p.[id] in (select [record] from [field] where [field] = 'hispanic' and [value] = '1') then 'SA' else (select top 1 _p.[export] 
from [field] _f 
inner join [lookup.prompt] _p on (_p.[id] = _f.[prompt]) 
where (_f.[record] = p.[id]) and (_f.[field] = 'race') and (_p.[export] is not null) and (_p.[value] not like '% - %') order by _p.[index] asc) end) as 
[RaceType], 
(case when p.[id] in (select [record] from [field] where [field] = 'hispanicOrigin') then (select [value] from dbo.getFieldExportTable(p.[id], 'hispanicOrigin')) else (select top 1 _p.[export] 
from [field] _f 
inner join [lookup.prompt] _p on (_p.[id] = _f.[prompt]) 
where (_f.[record] = p.[id]) and (_f.[field] = 'race') and (_p.[export] is not null) and (_p.[value] like '% - %') order by _p.[index] asc) end) 
as [RaceCode], 

p.[citizenship] as [CitizenshipStatus], 
(select [alpha2] from world.dbo.[country] where ([id] = p.[citizenship1])) as [Citizenship1], 
(select [alpha2] from world.dbo.[country] where ([id] = p.[citizenship2])) as [Citizenship2], 

dl.[name] as [Status], 
convert(char(4),lp.[year]) as [Round],
coalesce((select [value] from dbo.getFieldTable(a.[id], 'quarter')),'Autumn') as [Quarter],

replace(p.[phone],'+','') as [Phone], 
dbo.getToken(char(10), ad.[street], 1) as [MailStreet1], 
dbo.getToken(char(10), ad.[street], 2) as [MailStreet2], 
dbo.getToken(char(10), ad.[street], 3) as [MailStreet3],
ad.[city] as [MailCity], 
ad.[region] as [MailRegion], 
ad.[postal] as [MailPostal], 
adc.[alpha2] as [MailCountry],
dbo.getToken(char(10), adp.[street], 1) as [PermStreet1], 
dbo.getToken(char(10), adp.[street], 2) as [PermStreet2], 
dbo.getToken(char(10), adp.[street], 3) as [PermStreet3], 
adp.[city] as [PermCity], 
(select top 1 [id] from [lookup.region] where ([id] = adp.[region])) as [PermRegion], 
adp.[postal] as [PermPostal], 
adpc.[alpha2] as [PermCountry],

(select [value] from dbo.getFieldTable(a.[id], 'program')) as [Degree], 
(select [value] from dbo.getFieldTable(a.[id], 'program_type')) as [DegreeProgram],
	
null as [DegreeProgramCode], 

null as [SAT Verbal], 
null as [SAT Math], 
null as [SAT Writing], 
null as [ACT English], 
null as [ACT Math], 
null as [ACT Reading], 
null as [ACT Science], 
null as [TOEFL],
null as [DepositStatus],
null as [DepositDate],
null as [DepositInfo],

s1.[name] as [PrevSchool1], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s1.[name])),s1.[key]
	) as [PrevSchool1Key], 
s1.[type] as [PrevSchool1Category],
case when f1.[value] = '1' then 'Yes' else null end as [PrevSchool1Verified],

concat(convert(varchar(16),s1.[from],1), '-', convert(varchar(16),s1.[to],1)) as [PrevSchool1Years],
(select [value] from dbo.getPromptExportTable(s1.[degree])) as [PrevSchool1Degree],
format(s1.[conferred], 'yyyy') as [PrevSchool1DegreeYear],

s2.[name] as [PrevSchool2], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s2.[name])),s2.[key]
	) as [PrevSchool2Key], 
s2.[type] as [PrevSchool2Category],
case when f2.[value] = '1' then 'Yes' else null end as [PrevSchool2Verified],

concat(convert(varchar(16),s2.[from],1), '-', convert(varchar(16),s2.[to],1)) as [PrevSchool2Years],
(select [value] from dbo.getPromptExportTable(s2.[degree])) as [PrevSchool2Degree],
format(s2.[conferred], 'yyyy') as [PrevSchool2DegreeYear],

s3.[name] as [PrevSchool3], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s3.[name])),s3.[key]
	) as [PrevSchool3Key], 
s3.[type] as [PrevSchool3Category],
case when f3.[value] = '1' then 'Yes' else null end as [PrevSchool3Verified],

concat(convert(varchar(16),s3.[from],1), '-', convert(varchar(16),s3.[to],1)) as [PrevSchool3Years],
(select [value] from dbo.getPromptExportTable(s3.[degree])) as [PrevSchool3Degree],
format(s3.[conferred], 'yyyy') as [PrevSchool3DegreeYear],

s4.[name] as [PrevSchool4], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s4.[name])),s4.[key]
	) as [PrevSchool4Key], 
s4.[type] as [PrevSchool4Category],
case when f4.[value] = '1' then 'Yes' else null end as [PrevSchool4Verified],

concat(convert(varchar(16),s4.[from],1), '-', convert(varchar(16),s4.[to],1)) as [PrevSchool4Years],
(select [value] from dbo.getPromptExportTable(s4.[degree])) as [PrevSchool4Degree],
format(s4.[conferred], 'yyyy') as [PrevSchool4DegreeYear],

s5.[name] as [PrevSchool5], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s5.[name])),s5.[key]
	) as [PrevSchool5Key], 
s5.[type] as [PrevSchool5Category],
case when f5.[value] = '1' then 'Yes' else null end as [PrevSchool5Verified],

concat(convert(varchar(16),s5.[from],1), '-', convert(varchar(16),s5.[to],1)) as [PrevSchool5Years],
(select [value] from dbo.getPromptExportTable(s5.[degree])) as [PrevSchool5Degree],
format(s5.[conferred], 'yyyy') as [PrevSchool5DegreeYear],

s6.[name] as [PrevSchool6], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s6.[name])),s6.[key]
	) as [PrevSchool6Key], 
s6.[type] as [PrevSchool6Category],
case when f6.[value] = '1' then 'Yes' else null end as [PrevSchool6Verified],

concat(convert(varchar(16),s6.[from],1), '-', convert(varchar(16),s6.[to],1)) as [PrevSchool6Years],
(select [value] from dbo.getPromptExportTable(s6.[degree])) as [PrevSchool6Degree],
format(s6.[conferred], 'yyyy') as [PrevSchool6DegreeYear],

s7.[name] as [PrevSchool7], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s7.[name])),s7.[key]
	) as [PrevSchool7Key], 
s7.[type] as [PrevSchool7Category],
case when f7.[value] = '1' then 'Yes' else null end as [PrevSchool7Verified],

concat(convert(varchar(16),s7.[from],1), '-', convert(varchar(16),s7.[to],1)) as [PrevSchool7Years],
(select [value] from dbo.getPromptExportTable(s7.[degree])) as [PrevSchool7Degree],
format(s7.[conferred], 'yyyy') as [PrevSchool7DegreeYear],

s8.[name] as [PrevSchool8], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s8.[name])),s8.[key]
	) as [PrevSchool8Key], 
s8.[type] as [PrevSchool8Category],
case when f8.[value] = '1' then 'Yes' else null end as [PrevSchool8Verified],

concat(convert(varchar(16),s8.[from],1), '-', convert(varchar(16),s8.[to],1)) as [PrevSchool8Years],
(select [value] from dbo.getPromptExportTable(s8.[degree])) as [PrevSchool8Degree],
format(s8.[conferred], 'yyyy') as [PrevSchool8DegreeYear],

s9.[name] as [PrevSchool9], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s9.[name])),s9.[key]
	) as [PrevSchool9Key], 
s9.[type] as [PrevSchool9Category],
case when f9.[value] = '1' then 'Yes' else null end as [PrevSchool9Verified],

concat(convert(varchar(16),s9.[from],1), '-', convert(varchar(16),s9.[to],1)) as [PrevSchool9Years],
(select [value] from dbo.getPromptExportTable(s9.[degree])) as [PrevSchool9Degree],
format(s9.[conferred], 'yyyy') as [PrevSchool9DegreeYear],

s10.[name] as [PrevSchool10], 

coalesce(
(select top 1 [key] from [dataset.row] where ([name] = s10.[name])),s10.[key]
	) as [PrevSchool10Key], 
s10.[type] as [PrevSchool10Category],
case when f10.[value] = '1' then 'Yes' else null end as [PrevSchool10Verified],

concat(convert(varchar(16),s10.[from],1), '-', convert(varchar(16),s10.[to],1)) as [PrevSchool10Years],
(select [value] from dbo.getPromptExportTable(s10.[degree])) as [PrevSchool10Degree],
format(s10.[conferred], 'yyyy') as [PrevSchool10DegreeYear],
p.[email] as [Email],
dbo.getToken(char(10), adi.[street], 1) as [IntlStreet1], 
dbo.getToken(char(10), adi.[street], 2) as [IntlStreet2], 
dbo.getToken(char(10), adi.[street], 3) as [IntlStreet3],
adi.[city] as [IntlCity], 
(select top 1 [id] from [lookup.region] where ([id] = adi.[region])) as [IntlRegion], 
adi.[postal] as [IntlPostal], 
adic.[alpha2] as [IntlCountry]

from [application] a
inner join [person] p on (p.[id] = a.[person])
inner join [lookup.round] lr on (lr.[id] = a.[round])
inner join [lookup.period] lp on (lp.[id] = lr.[period])
left outer join [decision] d on (d.[application] = a.[id]) and (d.[rank] = 1)
left outer join [lookup.decision] dl on (dl.[id] = d.[code])
left outer join [address] ad on (ad.[record] = p.[id]) and (ad.[type] is null) and (ad.[rank] = 1)
left outer join [lookup.country] adc on (adc.[id] = ad.[country])
left outer join [address] adp on (adp.[record] = p.[id]) and (adp.[type] = 'permanent') and (adp.[rank] = 1)
left outer join [lookup.country] adpc on (adpc.[id] = adp.[country])

left outer join [address] adi on (adi.[record] = p.[id]) and (adi.[type] = 'permanent') and (adi.[rank] = 1) and (adi.[country] != 'US') and (adi.[record] in (select [id] from [person] where ([id] = p.[id]) and ([citizenship] = 'FN')))
left outer join [lookup.country] adic on (adic.[id] = adi.[country])

left outer join [field] hs_f on (hs_f.[record] = p.[id]) and (hs_f.[field] = 'ceeb')
left outer join [dataset.row] hs on (hs.[dataset] = 'B1818A40-245E-407D-9C7A-7326A232F56D') and (hs.[key] = hs_f.[index])
left outer join [activity] acd on (acd.[record] = a.[id]) and (acd.[code] = 'PAYMENT') and (acd.[body] = 'Enrollment Deposit') and (acd.[summary] like 'Payment Due: %')
left outer join [activity] acdp on (acdp.[record] = a.[id]) and (acdp.[code] = 'PAYMENT') and (acdp.[body] = 'Enrollment Deposit') and (acdp.[summary] like 'Payment Received: %')

left outer join [school] s1 on (s1.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) order by [rank])) 
left outer join [field] f1 on (f1.[record] = s1.[id]) and (f1.[field] = 'school_verified') and (f1.[value] = '1') 

left outer join [school] s2 on (s2.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id])) order by [rank])) 
left outer join [field] f2 on (f2.[record] = s2.[id]) and (f2.[field] = 'school_verified') and (f2.[value] = '1') 

left outer join [school] s3 on (s3.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id])) order by [rank])) 
left outer join [field] f3 on (f3.[record] = s3.[id]) and (f3.[field] = 'school_verified') and (f3.[value] = '1') 

left outer join [school] s4 on (s4.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id])) order by [rank])) 
left outer join [field] f4 on (f4.[record] = s4.[id]) and (f4.[field] = 'school_verified') and (f4.[value] = '1')  

left outer join [school] s5 on (s5.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id])) order by [rank])) 
left outer join [field] f5 on (f5.[record] = s5.[id]) and (f5.[field] = 'school_verified') and (f5.[value] = '1')  

left outer join [school] s6 on (s6.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id], s5.[id])) order by [rank])) 
left outer join [field] f6 on (f6.[record] = s6.[id]) and (f6.[field] = 'school_verified') and (f6.[value] = '1')  

left outer join [school] s7 on (s7.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id], s5.[id], s6.[id])) order by [rank])) 
left outer join [field] f7 on (f7.[record] = s7.[id]) and (f7.[field] = 'school_verified') and (f7.[value] = '1')  

left outer join [school] s8 on (s8.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id], s5.[id], s6.[id], s7.[id])) order by [rank])) 
left outer join [field] f8 on (f8.[record] = s8.[id]) and (f8.[field] = 'school_verified') and (f8.[value] = '1')  

left outer join [school] s9 on (s9.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id], s5.[id], s6.[id], s7.[id], s8.[id])) order by [rank])) 
left outer join [field] f9 on (f9.[record] = s9.[id]) and (f9.[field] = 'school_verified') and (f9.[value] = '1')  

left outer join [school] s10 on (s10.[id] = (select top 1 [id] from [school] where ([record] = p.[id]) and ([key] is not null) and ([id] not in (select [record] from [field] where ([field] = 'feed_school') and ([value] = '0'))) and ([id] not in (s1.[id], s2.[id], s3.[id], s4.[id], s5.[id], s6.[id], s7.[id], s8.[id], s9.[id])) order by [rank])) 
left outer join [field] f10 on (f10.[record] = s10.[id]) and (f10.[field] = 'school_verified') and (f10.[value] = '1')  

where
(a.[submitted] is not null) 
and not exists(select * from [tag] where ([record] = p.[id]) and ([tag] = 'test')) 
and (lp.[active] = 1) 
and (a.[round] in (select [id] from [lookup.round] where ([key] IN ('REU','EXCH'))))
and exists
(select * from [field] where ([record] = a.[id]) and ([field] = 'program'))
and exists
(select * from [field] where ([record] = a.[id]) and ([field] = 'program_type'))
