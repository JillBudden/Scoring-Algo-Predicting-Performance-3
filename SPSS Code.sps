****************************
Created by: Jill Budden
Client: W
Test: LII
*****************************

*****************************************************************************************Demographics and PQ*****************************************************************************************.

RENAME VARIABLES (Q3915021 Q3915041 = gender bdate).


*Creating race variables for 7-x webtests tests.
*Creating Race Variables.
DO IF (Q3915011_3915061 = 3915061).
	compute cvb = 0.
END IF.
DO IF (Q3915011_3915031 = 3915031).
	compute cvb = 1.
END IF.
variable labels Q3915011_3915061 'Caucasian'.
variable labels Q3915011_3915031 'African American'.
variable labels cvb 'Caucasian versus African American'.
value labels cvb 0 'Caucasian' 1 'African American'.

DO IF (Q3915011_3915061 = 3915061).
	compute cvi = 0.
END IF.
DO IF (Q3915011_3915011 = 3915011).
	compute cvi = 1.
END IF.
variable labels Q3915011_3915011 'American Indian or Alaskan Native'.
variable labels cvi 'Caucasian versus American Indian or Alaskan Native'.
value labels cvi 0 'Caucasian' 1 'American Indian or Alaskan Native'.

DO IF (Q3915011_3915061 = 3915061).
	compute cvn = 0.
END IF.
DO IF (Q3915011_3915051 = 3915051).
	compute cvn = 1.
END IF.
variable labels Q3915011_3915051 'Native Hawaiian or Other Pacific Islander'.
variable labels cvn 'Caucasian versus Native Hawaiian or Other Pacific Islander'.
value labels cvn 0 'Caucasian' 1 'Native Hawaiian or Other Pacific Islander'.

DO IF (Q3915011_3915061 = 3915061).
	compute cva = 0.
END IF.
DO IF (Q3915011_3915021 = 3915021).
	compute cva = 1.
END IF.
variable labels Q3915011_3915021'Asian'.
variable labels cva 'Caucasian versus Asian'.
value labels cva 0 'Caucasian' 1 'Asian'.

DO IF (Q3915011_3915061 = 3915061).
	compute cvh = 0.
END IF.
DO IF (Q3915011_3915041 = 3915041).
	compute cvh = 1.
END IF.
variable labels Q3915011_3915041'Hispanic'.
variable labels cvh 'Caucasian versus Hispanic'.
value labels cvh 0 'Caucasian' 1 'Hispanic'.

DO IF (Q3915011_3915061 = 3915061).
	compute cvo = 0.
END IF.
DO IF (Q3915011_3915071 = 3915071).
	compute cvo = 1.
END IF.
variable labels Q3915011_3915071 'Other'.
variable labels cvo 'Caucasian versus Other Category'.
value labels cvo 0 'Caucasian' 1 'Other Category'.
exe .

/*This is iffy
DO IF (Q3915011_3915061 = 3915061).
	compute cvm = 0.
END IF.
DO IF (Q3915011_3915011 = 3915011 or Q3915011_3915021 = 3915021 or Q3915011_3915031 = 3915031 or Q3915011_3915041 = 3915041 or Q3915011_3915051 = 3915051 or Q3915011_3915071 = 3915071).
	compute cvm = 1.
END IF.
variable labels cvm 'Caucasian versus All Minorities'.
value labels cvm 0 'Caucasian' 1 'All Minorities'.
exe.

*Constructing a single race variable - there are some problems when a candidate chooses more than one minority.
DO IF (Q3915011_3915061 = 3915061).
	compute race = 1.
END IF.
DO IF (Q3915011_3915011 = 3915011).
	compute race = 2.
END IF.
DO IF (Q3915011_3915031 = 3915031).
	compute race = 3.
END IF.
DO IF (Q3915011_3915051 = 3915051).
	compute race = 4.
END IF.
DO IF (Q3915011_3915021 = 3915021).
	compute race = 5.
END IF.
DO IF (Q3915011_3915041 = 3915041).
	compute race = 6.
END IF.
DO IF (Q3915011_3915071 = 3915071).
	compute race = 7.
END IF.
variable label race 'Race (as a single categorical variable)'.
value labels race 1 'Caucasian' 2 'American Indian or Alaskan Native' 3 'African American'
4 'Native Hawaiian or Other Pacific Islander' 5 'Asian' 6 'Hispanic' 7 'Other Category'.
exe.

recode Q3915031 (3915311=1) (3915321=2) (3915331=3) (3915341=4) (3915351=5) (3915361=6) into education .
value labels education
 1 'Some high school'
 2 'High school diploma or equivalent'
 3 '2-year technical school or associate degree'
 4 '4-year college degree (e.g., BA or BS)'
 5 'Masters degree'
 6 'Doctorate' .
exe .
variable label education 'education'.
exe.

*Gender.
RECODE Gender (940=1) (945=2) (6602021=1) (6602011=2) (3915211=1) (3915221=2) (ELSE = SYSMIS).
value labels gender 1 'Male' 2 'Female'.

*Converting string bdate into date birthdate.
COMPUTE birthdate = numeric(bdate, ADATE10). 

FORMAT birthdate (ADATE10).
FORMAT todaysdate (ADATE10).

*Creating a variable that holds todays date.
COMMENT $time is a numeric system variable that holds data and time.
compute currentdate = XDATE.DATE($TIME).

*formatting to american date.
format currentdate (ADATE11).

*Creating a variable that tells me how old each candidate is.
COMPUTE age = DATEDIFF(currentdate, birthdate, "year"). 

*Selecting only those who are aged 16 and older.
DO IF (age le 15).
	compute age = $SYSMIS.
END IF.

*Creating 40 and over variable.
DO IF (age ge 40).
	compute Over40 = 1.
ELSE.
	compute Over40 = 0.
END IF.
Variable Labels Over40 'Age over 40'.
Value labels Over40 0 'Under 40' 1 '40 and Over'.
exe.


variable labels
Q3901011	'I can see a clear link between the assessment and what I think is required by the job.'
Q3901021	'I tried my best on the assessment.'
Q3901031	'People who score well on the assessment will be good performers on the job.'
Q3901041	'It would be obvious to anyone that the items on the assessment are related to the job.'
Q3901051	'Doing well on the assessment probably means that a person can do the job well.'
Q3901061	 'I represented my experiences and opinions accurately when answering the questions on the assessment.'
Q3901071	'The assessment will provide an accurate evaluation of a candidates job-related background and experiences.'.
exe .

 value labels Q3901011 to Q3901071 
3900011 	'1'
3900021	'2'
3900031	'3'
3900041	'4'
3900051	'5'.
exe .
 
recode Q3901011 to Q3901071 (3900011=1) (3900021=2) (3900031=3) (3900041=4) (3900051=5) into ir1 to ir7.

Variable Labels
ir1 'I can see a clear link between the assessment and what I think is required by the job.'
ir2 'I tried my best on the assessment.'
ir3 'People who score well on the assessment will be good performers on the job.'
ir4 'It would be obvious to anyone that the items on the assessment are related to the job.'
ir5 'Doing well on the assessment probably means that a person can do the job well.'
ir6 'I represented my experiences and opinions accurately when answering the questions on the assessment.'
ir7 'The assessment will provide an accurate evaluation of a candidates job-related background and experiences.'.
exe .

Value Labels ir1 to ir7
1 'Strongly Disagree'
2 'Disagree'
3 'Neither Agree nor Disagree'
4 'Agree'
5 'Strongly Agree'.

variable labels 
	Q3901081 'Hours:'
	Q3901091 'Minutes:'
	Q3901101 'Do you have any additional comments about the assessment?'.
exe.



/*last category is actually 'more than 9'
recode Q3901081
(3900081=0) (3900091=1) (3900101=2) (3900111=3) (3900121=4) (3900131=5) (3900141=6) (3900151=7) (3900161=8) (3900171=9) (3900181=10) into hours .

recode Q3901091
(3900191=0 ) (3900201=1 ) (3900211=2 ) (3900221=3 ) (3900231=4 ) (3900241=5 ) (3900251=6 ) (3900261=7 ) (3900271=8 ) (3900281=9 ) (3900291=10) (3900301=11) 
(3900311=12) (3900321=13) (3900331=14) (3900341=15) (3900351=16) (3900361=17) (3900371=18) (3900381=19) (3900391=20) (3900401=21) (3900411=22) (3900421=23) 
(3900431=24) (3900441=25) (3900451=26) (3900461=27) (3900471=28) (3900481=29) (3900491=30) (3900501=31) (3900511=32) (3900521=33) (3900531=34) (3900541=35) 
(3900551=36) (3900561=37) (3900571=38) (3900581=39) (3900591=40) (3900601=41) (3900611=42) (3900621=43) (3900631=44) (3900641=45) (3900651=46) (3900661=47) 
(3900671=48) (3900681=49) (3900691=50) (3900701=51) (3900711=52) (3900721=53) (3900731=54) (3900741=55) (3900751=56) (3900761=57) (3900771=58) (3900781=59)
into minutes.
exe.


variable labels
	Q3911041 'Organizational Tenure (years)'
	Q3911051 'Organizational Tenure (months)'
	Q3911061 'Tenure in current position (years)'
	Q3911071 'Tenure in current position (months)'. 
exe.

/*last category is actually 'more than 50'
recode Q3911041 Q3911061
(3920011=0 ) (3920021=1 ) (3920031=2 ) (3920041=3 ) (3920051=4 ) (3920061=5 ) (3920071=6 ) (3920081=7 ) (3920091=8 ) (3920101=9 ) (3920111=10) (3920121=11) 
(3920131=12) (3920141=13) (3920151=14) (3920161=15) (3920171=16) (3920181=17) (3920191=18) (3920201=19) (3920211=20) (3920221=21) (3920231=22) (3920241=23) 
(3920251=24) (3920261=25) (3920271=26) (3920281=27) (3920291=28) (3920301=29) (3920311=30) (3920321=31) (3920331=32) (3920341=33) (3920351=34) (3920361=35) 
(3920371=36) (3920381=37) (3920391=38) (3920401=39) (3920411=40) (3920421=41) (3920431=42) (3920441=43) (3920451=44) (3920461=45) (3920471=46) (3920481=47) 
(3920491=48) (3920501=49) (3920511=50) (3920521=51)
into org_yrs pos_yrs. 

recode Q3911051 Q3911071
(3920641=0 ) (3920531=1 ) (3920541=2 ) (3920551=3 ) (3920561=4 ) (3920571=5 ) (3920581=6 ) (3920591=7 ) (3920601=8 ) (3920611=9 ) (3920621=10) (3920631=11)
into org_mths pos_mths.

COMPUTE orgten = (org_yrs*12) + (org_mths) .
COMPUTE jobten = (pos_yrs*12) + (pos_mths) .

variable labels
	hours 'Hours:'
	minutes 'Minutes:'
	org_yrs 'Organizational Tenure (years)'
	org_mths 'Organizational Tenure (months)'
	pos_yrs 'Tenure in current position (years)'
	pos_mths 'Tenure in current position (months)'
	orgten 'Organizational Tenure Total (Measured in Months)'
	jobten 'Position Tenure Total (Measured in Months)'.
exe.

/*E3
recode Q3905011 to Q3905241 (3900041=4) (3900051=5) (3900011=1) (3900021=2) (3900031=3) into e1 to e24.

Variable labels
e1 'In my department, my ideas and opinions are appreciated.'
e2 'People trust each other in my department.'
e3 'My job provides me with chances to grow and develop.'
e4 'I rarely think about quitting my job.'
e5 'In my department, people are assigned tasks that allow them to use their best skills.'
e6 'My department makes efficient use of its resources, time, and budget.'
e7 'I get sufficient feedback about how well I am doing.'
e8 'In my department, people are held accountable for low performance.'
e9 'Overall, I have a good understanding of what I am supposed to be doing in my job.'
e10 'I feel that I will be a long-term Associate in this company.'
e11 'People in my department quickly resolve conflicts when they arise.'
e12 'I am kept well informed about changes in the organization that affect my department.'
e13 'In this organization, different departments reach out to help and support each other.'
e14 'I cannot think of any reasons why I would quit my current job.'
e15 'People in my department understand and respect the things that make me unique.'
e16 'In my department, meetings are focused and efficient.'
e17 'People in my department cooperate with each other to get the job done.'
e18 'I find personal meaning and fulfillment in my work.'
e19 'I will probably <B>not</B> look for a new job within the next 6 months.'
e20 'I can make meaningful decisions about how I do my job.'
e21 'In my department, everyone tries to pick up new skills and knowledge.'
e22 'I am satisfied with my job.'
e23 'I would recommend employment at my organization to my friends or family.'
e24 'I feel a sense of loyalty to this company.'.


***E3 Scoring/Labels.

COMPUTE e3_CABER		= MEAN(e1, e2, e3, e5, e6, e7, e8, e9, e11,e12, e13, 
					e15, e16, e17, e18, e20, e21) * 17.
COMPUTE e3_outcomes	= MEAN(e22, e23, e24) * 3.
COMPUTE int_stay 		= MEAN(e4, e10, e14, e19) * 4.

variable labels 
	e3_CABER 	'Employee Engagement'
	int_stay	 	'Employee Intent to Stay' .
execute .

VARIABLE LABELS
	e3_CABER	'E3 Employee Engagement'
	e3_outcomes	'E3 outcomes'
	int_stay 	'Intent to Stay'.
	EXECUTE.

DESCRIPTIVES
  VARIABLES=e3_CABER int_stay  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

*To Eliminate Univariate Outliers.
RECODE 	Ze3_CABER Zint_stay  
  		(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE.

*****************************************************************************************Item-level Scoring - LII Validation*****************************************************************************************.

/*Recoding from question ids to rcb variables.

RECODE Q51002 (51001=1) (51003=2) (51005=3) (51007=4) into rQ51002.
RECODE Q51004 (51009=1) (51011=2) (51013=3) (51015=4) into rQ51004.
RECODE Q51006 (51017=1) (51019=2) (51021=3) (51023=4) into rQ51006.
RECODE Q51008 (51025=1) (51027=2) (51029=3) (51031=4) into rQ51008.
RECODE Q51010 (51033=1) (51035=2) (51037=3) (51039=4) into rQ51010.
RECODE Q51012 (51041=1) (51043=2) (51045=3) (51047=4) into rQ51012.
RECODE Q51014 (51049=1) (51051=2) (51053=3) (51055=4) into rQ51014.
RECODE Q51016 (51057=1) (51059=2) (51061=3) (51063=4) into rQ51016.
RECODE Q51018 (51065=1) (51067=2) (51069=3) (51071=4) into rQ51018.
RECODE Q51020 (51073=1) (51075=2) (51077=3) (51079=4) into rQ51020.
RECODE Q51022 (51081=1) (51083=2) (51085=3) (51087=4) into rQ51022.
RECODE Q51024 (51089=1) (51091=2) (51093=3) (51095=4) into rQ51024.
RECODE Q51026 (51097=1) (51099=2) (51101=3) (51103=4) into rQ51026.
RECODE Q51028 (51105=1) (51107=2) (51109=3) (51111=4) into rQ51028.
RECODE Q51030 (51113=1) (51115=2) (51117=3) (51119=4) into rQ51030.
RECODE Q51032 (51121=1) (51123=2) (51125=3) (51127=4) into rQ51032.
RECODE Q51036 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51036.
RECODE Q51038 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51038.
RECODE Q51040 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51040.
RECODE Q51042 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51042.
RECODE Q51044 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51044.
RECODE Q51046 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51046.
RECODE Q51048 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51048.
RECODE Q51050 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51050.
RECODE Q51052 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51052.
RECODE Q51054 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into rQ51054.
RECODE Q51058 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51058.
RECODE Q51060 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51060.
RECODE Q51062 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51062.
RECODE Q51064 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51064.
RECODE Q51066 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51066.
RECODE Q51068 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51068.
RECODE Q51070 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51070.
RECODE Q51072 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51072.
RECODE Q51074 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51074.
RECODE Q51076 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into rQ51076.
RECODE Q51080 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51080.
RECODE Q51082 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51082.
RECODE Q51084 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51084.
RECODE Q51086 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51086.
RECODE Q51088 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51088.
RECODE Q51090 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51090.
RECODE Q51092 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51092.
RECODE Q51094 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51094.
RECODE Q51098 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51098.
RECODE Q51100 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51100.
RECODE Q51102 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51102.
RECODE Q51104 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51104.
RECODE Q51106 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51106.
RECODE Q51108 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51108.
RECODE Q51110 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51110.
RECODE Q51112 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51112.
RECODE Q51116 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51116.
RECODE Q51118 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51118.
RECODE Q51120 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51120.
RECODE Q51122 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51122.
RECODE Q51124 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51124.
RECODE Q51126 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51126.
RECODE Q51128 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51128.
RECODE Q51130 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51130.
RECODE Q51134 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51134.
RECODE Q51136 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51136.
RECODE Q51138 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51138.
RECODE Q51140 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51140.
RECODE Q51142 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51142.
RECODE Q51144 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51144.
RECODE Q51146 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51146.
RECODE Q51148 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51148.
RECODE Q51152 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51152.
RECODE Q51154 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51154.
RECODE Q51156 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51156.
RECODE Q51158 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51158.
RECODE Q51160 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51160.
RECODE Q51162 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51162.
RECODE Q51164 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51164.
RECODE Q51166 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51166.
RECODE Q51170 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51170.
RECODE Q51172 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51172.
RECODE Q51174 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51174.
RECODE Q51176 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51176.
RECODE Q51178 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51178.
RECODE Q51180 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51180.
RECODE Q51182 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51182.
RECODE Q51184 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51184.
RECODE Q51188 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51188.
RECODE Q51190 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51190.
RECODE Q51192 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51192.
RECODE Q51194 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51194.
RECODE Q51196 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51196.
RECODE Q51198 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51198.
RECODE Q51200 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51200.
RECODE Q51202 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51202.
RECODE Q51206 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51206.
RECODE Q51208 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51208.
RECODE Q51210 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51210.
RECODE Q51212 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51212.
RECODE Q51214 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51214.
RECODE Q51216 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51216.
RECODE Q51218 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51218.
RECODE Q51220 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51220.
RECODE Q51224 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51224.
RECODE Q51226 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51226.
RECODE Q51228 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51228.
RECODE Q51230 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51230.
RECODE Q51232 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51232.
RECODE Q51234 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51234.
RECODE Q51236 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51236.
RECODE Q51238 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51238.
RECODE Q51242 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51242.
RECODE Q51244 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51244.
RECODE Q51246 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51246.
RECODE Q51248 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51248.
RECODE Q51250 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51250.
RECODE Q51252 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51252.
RECODE Q51254 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51254.
RECODE Q51256 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51256.
RECODE Q51260 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51260.
RECODE Q51262 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51262.
RECODE Q51264 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51264.
RECODE Q51266 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51266.
RECODE Q51268 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51268.
RECODE Q51270 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51270.
RECODE Q51272 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51272.
RECODE Q51274 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51274.
RECODE Q51278 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51278.
RECODE Q51280 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51280.
RECODE Q51282 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51282.
RECODE Q51284 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51284.
RECODE Q51286 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51286.
RECODE Q51288 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51288.
RECODE Q51290 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51290.
RECODE Q51292 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into rQ51292.
RECODE Q51294 (51159=1) (51161=2) (51163=3) into rQ51294.
RECODE Q51296 (51165=1) (51167=2) (51169=3) (51171=4) (51173=5) into rQ51296.
RECODE Q51298 (51175=1) (51177=2) (51179=3) (51181=4) into rQ51298.
RECODE Q51300 (51183=1) (51185=2) (51187=3) (51189=4) into rQ51300.
RECODE Q51302 (51191=1) (51193=2) (51195=3) (51197=4) into rQ51302.
RECODE Q51304 (51199=1) (51201=2) (51203=3) (51205=4) (51207=5) into rQ51304.
RECODE Q51306 (51209=1) (51211=2) (51213=3) (51215=4) (51217=5) into rQ51306.
RECODE Q51308 (51219=1) (51221=2) (51223=3) (51225=4) (51227=5) into rQ51308.
RECODE Q51310 (51229=1) (51231=2) (51233=3) (51235=4) (51237=5) into rQ51310.
RECODE Q51312 (51239=1) (51241=2) (51243=3) (51245=4) into rQ51312.
RECODE Q51314 (51247=1) (51249=2) (51251=3) (51253=4) into rQ51314.
RECODE Q51316 (51255=1) (51257=2) (51259=3) (51261=4) (51263=5) into rQ51316.
RECODE Q51318 (51265=1) (51267=2) (51269=3) (51271=4) into rQ51318.
RECODE Q51320 (51273=1) (51275=2) (51277=3) (51279=4) into rQ51320.
RECODE Q51322 (51281=1) (51283=2) (51285=3) (51287=4) (51289=5) into rQ51322.
RECODE Q51324 (51291=1) (51293=2) (51295=3) into rQ51324.
RECODE Q51326 (51297=1) (51299=2) (51301=3) (51303=4) (51305=5) into rQ51326.
RECODE Q51328 (51307=1) (51309=2) (51311=3) (51313=4) (51315=5) into rQ51328.

/*Recoding from question ids to cb variables.


recode Q51002 (51001=1) (51003=0) (51005=0) (51007=0) into cQ51002. 
recode Q51004 (51009=0) (51011=1) (51013=0) (51015=0) into cQ51004. 
recode Q51006 (51017=0) (51019=0) (51021=1) (51023=0) into cQ51006. 
recode Q51008 (51025=0) (51027=1) (51029=0) (51031=0) into cQ51008. 
recode Q51010 (51033=0) (51035=0) (51037=1) (51039=0) into cQ51010. 
recode Q51012 (51041=0) (51043=0) (51045=0) (51047=1) into cQ51012. 
recode Q51014 (51049=1) (51051=0) (51053=0) (51055=0) into cQ51014. 
recode Q51016 (51057=0) (51059=0) (51061=1) (51063=0) into cQ51016. 
recode Q51018 (51065=0) (51067=0) (51069=0) (51071=1) into cQ51018. 
recode Q51020 (51073=0) (51075=0) (51077=0) (51079=1) into cQ51020. 
recode Q51022 (51081=0) (51083=0) (51085=0) (51087=1) into cQ51022. 
recode Q51024 (51089=0) (51091=0) (51093=0) (51095=1) into cQ51024. 
recode Q51026 (51097=1) (51099=0) (51101=0) (51103=0) into cQ51026. 
recode Q51028 (51105=0) (51107=1) (51109=0) (51111=0) into cQ51028. 
recode Q51030 (51113=1) (51115=0) (51117=0) (51119=0) into cQ51030. 
recode Q51032 (51121=0) (51123=0) (51125=0) (51127=1) into cQ51032. 
exe. 

*/Template AB keying
*
*recode Q51036 (51129=5) (51131=4) (51133=3) (51135=2) (51137=1) into cQ51036.
*recode Q51038 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into cQ51038.
*recode Q51040 (51129=3) (51131=4) (51133=5) (51135=4) (51137=3) into cQ51040.
*recode Q51042 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) into cQ51042.
*recode Q51044 (51129=5) (51131=4) (51133=3) (51135=2) (51137=1) into cQ51044.
*recode Q51046 (51129=2) (51131=3) (51133=4) (51135=5) (51137=4) into cQ51046.
*recode Q51048 (51129=2) (51131=3) (51133=4) (51135=5) (51137=4) into cQ51048.
*recode Q51050 (51129=3) (51131=4) (51133=5) (51135=4) (51137=3) into cQ51050.
*recode Q51052 (51129=4) (51131=5) (51133=4) (51135=3) (51137=2) into cQ51052.
*recode Q51054 (51129=2) (51131=3) (51133=4) (51135=5) (51137=4) into cQ51054.
*recode Q51058 (51139=4) (51141=5) (51143=4) (51145=3) (51147=2) into cQ51058.
*recode Q51060 (51139=2) (51141=3) (51143=4) (51145=5) (51147=4) into cQ51060.
*recode Q51062 (51139=2) (51141=3) (51143=4) (51145=5) (51147=4) into cQ51062.
*recode Q51064 (51139=2) (51141=3) (51143=4) (51145=5) (51147=4) into cQ51064.
*recode Q51066 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) into cQ51066.
*recode Q51068 (51139=3) (51141=4) (51143=5) (51145=4) (51147=3) into cQ51068.
*recode Q51070 (51139=4) (51141=5) (51143=4) (51145=3) (51147=2) into cQ51070.
*recode Q51072 (51139=3) (51141=4) (51143=5) (51145=4) (51147=3) into cQ51072.
*recode Q51074 (51139=2) (51141=3) (51143=4) (51145=5) (51147=4) into cQ51074.
*recode Q51076 (51139=5) (51141=4) (51143=3) (51145=2) (51147=1) into cQ51076.

*/Empirically keyed AB items (with Schwan and Highmark data) -- with Evan NOTES.

recode Q51036 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) (else=sysmis) into cQ51036 .
recode Q51038 (51129=3) (51131=4) (51133=5) (51135=4) (51137=3) (else=sysmis) into cQ51038 .
recode Q51040 (51129=3) (51131=4) (51133=5) (51135=4) (51137=3) (else=sysmis) into cQ51040 .
recode Q51042 (51129=3) (51131=4) (51133=5) (51135=4) (51137=3) (else=sysmis) into cQ51042 .
recode Q51044 (51129=2.7) (51131=3.7) (51133=4.7) (51135=4.3) (51137=3.3) (else=sysmis) into cQ51044 .
recode Q51046 (51129=4) (51131=5) (51133=4) (51135=3) (51137=2) (else=sysmis) into cQ51046 .
recode Q51048 (51129=2) (51131=3) (51133=4) (51135=5) (51137=4) (else=sysmis) into cQ51048 .
recode Q51050 (51129=1) (51131=2) (51133=3) (51135=4) (51137=5) (else=sysmis) into cQ51050 .
recode Q51052 (51129=3.8) (51131=4.8) (51133=4.2) (51135=3.2) (51137=2.2) (else=sysmis) into cQ51052 .
recode Q51054 (51129=1.3) (51131=2.3) (51133=3.3) (51135=4.3) (51137=4.7) (else=sysmis) into cQ51054 .
recode Q51058 (51139=4.3) (51141=4.7) (51143=3.7) (51145=2.7) (51147=1.7) (else=sysmis) into cQ51058 .
recode Q51060 (51139=3.5) (51141=4.5) (51143=4.5) (51145=3.5) (51147=2.5) (else=sysmis) into cQ51060 .
recode Q51062 (51139=1.6) (51141=2.6) (51143=3.6) (51145=4.6) (51147=4.4) (else=sysmis) into cQ51062 .
recode Q51064 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) (else=sysmis) into cQ51064 .
recode Q51066 (51139=1) (51141=2) (51143=3) (51145=4) (51147=5) (else=sysmis) into cQ51066 .
recode Q51068 (51139=3) (51141=4) (51143=5) (51145=4) (51147=3) (else=sysmis) into cQ51068 .
recode Q51070 (51139=2.5) (51141=3.5) (51143=4.5) (51145=4.5) (51147=3.5) (else=sysmis) into cQ51070 .
recode Q51072 (51139=5) (51141=4) (51143=3) (51145=2) (51147=1) (else=sysmis) into cQ51072 .
recode Q51074 (51139=3) (51141=4) (51143=5) (51145=4) (51147=3) (else=sysmis) into cQ51074 .
recode Q51076 (51139=4.6) (51141=4.4) (51143=3.4) (51145=2.4) (51147=1.4) (else=sysmis) into cQ51076 .

recode Q51080 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51080.
recode Q51082 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51082.
recode Q51084 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51084.
recode Q51086 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51086.
recode Q51088 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51088.
recode Q51090 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51090.
recode Q51092 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51092.
recode Q51094 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51094.
recode Q51098 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51098.
recode Q51100 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51100.
recode Q51102 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51102.
recode Q51104 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51104.
recode Q51106 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51106.
recode Q51108 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51108.
recode Q51110 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51110.
recode Q51112 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51112.
recode Q51116 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51116.
recode Q51118 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51118.
recode Q51120 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51120.
recode Q51122 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51122.
recode Q51124 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51124.
recode Q51126 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51126.
recode Q51128 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51128.
recode Q51130 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51130.
recode Q51134 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51134.
recode Q51136 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51136.
recode Q51138 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51138.
recode Q51140 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51140.
recode Q51142 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51142.
recode Q51144 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51144.
recode Q51146 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51146.
recode Q51148 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51148.
recode Q51152 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51152.
recode Q51154 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51154.
recode Q51156 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51156.
recode Q51158 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51158.
recode Q51160 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51160.
recode Q51162 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51162.
recode Q51164 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51164.
recode Q51166 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51166.
recode Q51170 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51170.
recode Q51172 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51172.
recode Q51174 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51174.
recode Q51176 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51176.
recode Q51178 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51178.
recode Q51180 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51180.
recode Q51182 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51182.
recode Q51184 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51184.
recode Q51188 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51188.
recode Q51190 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51190.
recode Q51192 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51192.
recode Q51194 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51194.
recode Q51196 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51196.
recode Q51198 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51198.
recode Q51200 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51200.
recode Q51202 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51202.
recode Q51206 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51206.
recode Q51208 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51208.
recode Q51210 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51210.
recode Q51212 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51212.
recode Q51214 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51214.
recode Q51216 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51216.
recode Q51218 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51218.
recode Q51220 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51220.
recode Q51224 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51224.
recode Q51226 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51226.
recode Q51228 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51228.
recode Q51230 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51230.
recode Q51232 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51232.
recode Q51234 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51234.
recode Q51236 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51236.
recode Q51238 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51238.
recode Q51242 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51242.
recode Q51244 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51244.
recode Q51246 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51246.
recode Q51248 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51248.
recode Q51250 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51250.
recode Q51252 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51252.
recode Q51254 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51254.
recode Q51256 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51256.
recode Q51260 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51260.
recode Q51262 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51262.
recode Q51264 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51264.
recode Q51266 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51266.
recode Q51268 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51268.
recode Q51270 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51270.
recode Q51272 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51272.
recode Q51274 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51274.
recode Q51278 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51278.
recode Q51280 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51280.
recode Q51282 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51282.
recode Q51284 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51284.
recode Q51286 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51286.
recode Q51288 (51149=1) (51151=2) (51153=3) (51155=4) (51157=5) into cQ51288.
recode Q51290 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51290.
recode Q51292 (51149=5) (51151=4) (51153=3) (51155=2) (51157=1) into cQ51292.
recode Q51294 (51159=5) (51161=3) (51163=1) into cQ51294.  
recode Q51296 (51165=5) (51167=4) (51169=3) (51171=2) (51173=1) into cQ51296.
recode Q51298 (51175=1) (51177=1) (51179=1) (51181=5) into cQ51298. 
recode Q51300 (51183=5) (51185=1) (51187=1) (51189=1) into cQ51300. 
recode Q51302 (51191=2) (51193=5) (51195=4) (51197=3) into cQ51302. 
recode Q51304 (51199=1) (51201=2) (51203=3) (51205=4) (51207=5) into cQ51304.
recode Q51306 (51209=1) (51211=2) (51213=3) (51215=4) (51217=5) into cQ51306.
recode Q51308 (51219=1) (51221=2) (51223=3) (51225=4) (51227=5) into cQ51308.
recode Q51310 (51229=1) (51231=2) (51233=3) (51235=4) (51237=5) into cQ51310.
recode Q51312 (51239=5) (51241=1) (51243=1) (51245=1) into cQ51312. 
recode Q51314 (51247=1) (51249=1) (51251=1) (51253=5) into cQ51314. 
recode Q51316 (51255=5) (51257=4) (51259=3) (51261=2) (51263=1) into cQ51316.
recode Q51318 (51265=1) (51267=5) (51269=1) (51271=1) into cQ51318. 
recode Q51320 (51273=2) (51275=3) (51277=5) (51279=1) into cQ51320. 
recode Q51322 (51281=1) (51283=2) (51285=3) (51287=4) (51289=5) into cQ51322.
recode Q51324 (51291=5) (51293=3) (51295=1) into cQ51324.  
recode Q51326 (51297=5) (51299=4) (51301=3) (51303=2) (51305=1) into cQ51326.
recode Q51328 (51307=5) (51309=4) (51311=3) (51313=2) (51315=1) into cQ51328.
exe.

*****************************************************************************************Scale-level Scoring - LII Validation*****************************************************************************************.
*Unstandardized.

numeric sji_sit ab_del ab_coach dsp_ao dsp_ldro dsp_net dsp_od dsp_pd dsp_sinc dsp_soci dsp_adpt dsp_lrno dsp_dm dsp_wq dsp_ca dsp_loc be_intv be_lead be_coach (f8.2) .

***WRJ Scales***

*count sji_sit_mss = cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51022, cQ51024, cQ51026, cQ51028, cQ51030, cQ51032 (sysmis) .
*DO IF (sji_sit_mss GE 0).
*compute sji_sit = (sum(sum(cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51022, cQ51024, cQ51026, cQ51028, cQ51030, cQ51032),(sji_sit_mss * 0)) * 1) .
*ELSE.
*compute sji_sit = mean(cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51022, cQ51024, cQ51026, cQ51028, cQ51030, cQ51032) * 1 * 16 .
*END IF.

*/NEW Dropping cQ51022, cQ51028, cQ51030.

count sji_sit_mss = cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51024, cQ51026, cQ51032 (sysmis) .
DO IF (sji_sit_mss GE 0).
compute sji_sit = (sum(sum(cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51024, cQ51026, cQ51032),(sji_sit_mss * 0)) * 1) .
ELSE.
compute sji_sit = mean(cQ51002, cQ51004, cQ51006, cQ51008, cQ51010, cQ51012, cQ51014, cQ51016, cQ51018, cQ51020, cQ51024, cQ51026, cQ51032) * 1 * 13 .
END IF.

count ab_del_mss = cQ51036, cQ51038, cQ51040, cQ51042, cQ51044, cQ51046, cQ51048, cQ51050, cQ51052, cQ51054 (sysmis) .
DO IF (ab_del_mss GE 3).
compute ab_del = (sum(sum(cQ51036, cQ51038, cQ51040, cQ51042, cQ51044, cQ51046, cQ51048, cQ51050, cQ51052, cQ51054),(ab_del_mss * 1)) * 1) .
ELSE.
compute ab_del = mean(cQ51036, cQ51038, cQ51040, cQ51042, cQ51044, cQ51046, cQ51048, cQ51050, cQ51052, cQ51054) * 1 * 10 .
END IF.

count ab_coach_mss = cQ51058, cQ51060, cQ51062, cQ51064, cQ51066, cQ51068, cQ51070, cQ51072, cQ51074, cQ51076 (sysmis) .
DO IF (ab_coach_mss GE 3).
compute ab_coach = (sum(sum(cQ51058, cQ51060, cQ51062, cQ51064, cQ51066, cQ51068, cQ51070, cQ51072, cQ51074, cQ51076),(ab_coach_mss * 1)) * 1) .
ELSE.
compute ab_coach = mean(cQ51058, cQ51060, cQ51062, cQ51064, cQ51066, cQ51068, cQ51070, cQ51072, cQ51074, cQ51076) * 1 * 10 .
END IF.

***WSD Scales***

count dao_mss = cQ51102, cQ51110, cQ51120, cQ51130, cQ51154, cQ51176, cQ51214, cQ51292 (sysmis) .
DO IF (dao_mss GE 3).
compute dsp_ao = (sum(sum(cQ51102, cQ51110, cQ51120, cQ51130, cQ51154, cQ51176, cQ51214, cQ51292),(dao_mss * 1)) * 1) .
ELSE.
compute dsp_ao = mean(cQ51102, cQ51110, cQ51120, cQ51130, cQ51154, cQ51176, cQ51214, cQ51292) * 1 * 8 .
END IF.

count dldro_mss = cQ51098, cQ51136, cQ51172, cQ51192, cQ51208, cQ51236, cQ51266, cQ51272 (sysmis) .
DO IF (dldro_mss GE 3).
compute dsp_ldro = (sum(sum(cQ51098, cQ51136, cQ51172, cQ51192, cQ51208, cQ51236, cQ51266, cQ51272),(dldro_mss * 1)) * 1) .
ELSE.
compute dsp_ldro = mean(cQ51098, cQ51136, cQ51172, cQ51192, cQ51208, cQ51236, cQ51266, cQ51272) * 1 * 8 .
END IF.

count dnet_mss = cQ51080, cQ51134, cQ51142, cQ51182, cQ51190, cQ51262, cQ51282, cQ51286 (sysmis) .
DO IF (dnet_mss GE 3).
compute dsp_net = (sum(sum(cQ51080, cQ51134, cQ51142, cQ51182, cQ51190, cQ51262, cQ51282, cQ51286),(dnet_mss * 1)) * 1) .
ELSE.
compute dsp_net = mean(cQ51080, cQ51134, cQ51142, cQ51182, cQ51190, cQ51262, cQ51282, cQ51286) * 1 * 8 .
END IF.

count dod_mss = cQ51124, cQ51152, cQ51202, cQ51216, cQ51220, cQ51226, cQ51260, cQ51284 (sysmis) .
DO IF (dod_mss GE 3).
compute dsp_od = (sum(sum(cQ51124, cQ51152, cQ51202, cQ51216, cQ51220, cQ51226, cQ51260, cQ51284),(dod_mss * 1)) * 1) .
ELSE.
compute dsp_od = mean(cQ51124, cQ51152, cQ51202, cQ51216, cQ51220, cQ51226, cQ51260, cQ51284) * 1 * 8 .
END IF.

count dpd_mss = cQ51118, cQ51148, cQ51184, cQ51252 (sysmis) .
DO IF (dpd_mss GE 3).
compute dsp_pd = (sum(sum(cQ51118, cQ51148, cQ51184, cQ51252),(dpd_mss * 1)) * 1) .
ELSE.
compute dsp_pd = mean(cQ51118, cQ51148, cQ51184, cQ51252) * 1 * 4 .
END IF.

count dsinc_mss = cQ51094, cQ51146, cQ51194, cQ51224, cQ51250 (sysmis) .
DO IF (dsinc_mss GE 3).
compute dsp_sinc = (sum(sum(cQ51094, cQ51146, cQ51194, cQ51224, cQ51250),(dsinc_mss * 1)) * 1) .
ELSE.
compute dsp_sinc = mean(cQ51094, cQ51146, cQ51194, cQ51224, cQ51250) * 1 * 5 .
END IF.

count dsoci_mss = cQ51126, cQ51156, cQ51158, cQ51178, cQ51180, cQ51212, cQ51256 (sysmis) .
DO IF (dsoci_mss GE 3).
compute dsp_soci = (sum(sum(cQ51126, cQ51156, cQ51158, cQ51178, cQ51180, cQ51212, cQ51256),(dsoci_mss * 1)) * 1) .
ELSE.
compute dsp_soci = mean(cQ51126, cQ51156, cQ51158, cQ51178, cQ51180, cQ51212, cQ51256) * 1 * 7 .
END IF.

count dadpt_mss = cQ51104, cQ51116, cQ51160, cQ51174, cQ51232, cQ51234, cQ51244, cQ51278 (sysmis) .
DO IF (dadpt_mss GE 3).
compute dsp_adpt = (sum(sum(cQ51104, cQ51116, cQ51160, cQ51174, cQ51232, cQ51234, cQ51244, cQ51278),(dadpt_mss * 1)) * 1) .
ELSE.
compute dsp_adpt = mean(cQ51104, cQ51116, cQ51160, cQ51174, cQ51232, cQ51234, cQ51244, cQ51278) * 1 * 8 .
END IF.

count dlrno_mss = cQ51084, cQ51112, cQ51122, cQ51164, cQ51188, cQ51248, cQ51268, cQ51290 (sysmis) .
DO IF (dlrno_mss GE 3).
compute dsp_lrno = (sum(sum(cQ51084, cQ51112, cQ51122, cQ51164, cQ51188, cQ51248, cQ51268, cQ51290),(dlrno_mss * 1)) * 1) .
ELSE.
compute dsp_lrno = mean(cQ51084, cQ51112, cQ51122, cQ51164, cQ51188, cQ51248, cQ51268, cQ51290) * 1 * 8 .
END IF.

count ddm_mss = cQ51106, cQ51138, cQ51144, cQ51162, cQ51166, cQ51196, cQ51228, cQ51288 (sysmis) .
DO IF (ddm_mss GE 3).
compute dsp_dm = (sum(sum(cQ51106, cQ51138, cQ51144, cQ51162, cQ51166, cQ51196, cQ51228),(ddm_mss * 1)) * 1) .
ELSE.
compute dsp_dm = mean(cQ51106, cQ51138, cQ51144, cQ51162, cQ51166, cQ51196, cQ51228) * 1 * 8 .
END IF.

count dwq_mss = cQ51088, cQ51092, cQ51128, cQ51140, cQ51198, cQ51206, cQ51246, cQ51274 (sysmis) .
DO IF (dwq_mss GE 3).
compute dsp_wq = (sum(sum(cQ51088, cQ51092, cQ51128, cQ51140, cQ51198, cQ51206, cQ51246, cQ51274),(dwq_mss * 1)) * 1) .
ELSE.
compute dsp_wq = mean(cQ51088, cQ51092, cQ51128, cQ51140, cQ51198, cQ51206, cQ51246, cQ51274) * 1 * 8 .
END IF.

count dca_mss = cQ51090, cQ51200, cQ51218, cQ51230, cQ51238, cQ51242, cQ51264, cQ51270 (sysmis) .
DO IF (dca_mss GE 3).
compute dsp_ca = (sum(sum(cQ51090, cQ51200, cQ51218, cQ51230, cQ51238, cQ51242, cQ51264, cQ51270),(dca_mss * 1)) * 1) .
ELSE.
compute dsp_ca = mean(cQ51090, cQ51200, cQ51218, cQ51230, cQ51238, cQ51242, cQ51264, cQ51270) * 1 * 8 .
END IF.

count dloc_mss = cQ51082, cQ51086, cQ51100, cQ51108, cQ51170, cQ51210, cQ51254, cQ51280 (sysmis) .
DO IF (dloc_mss GE 3).
compute dsp_loc = (sum(sum(cQ51082, cQ51086, cQ51100, cQ51108, cQ51170, cQ51210, cQ51254, cQ51280),(dloc_mss * 1)) * 1) .
ELSE.
compute dsp_loc = mean(cQ51082, cQ51086, cQ51100, cQ51108, cQ51170, cQ51210, cQ51254, cQ51280) * 1 * 8 .
END IF.
count intv_mss = cQ51298, cQ51300, cQ51312, cQ51314, cQ51318 (sysmis) .
DO IF (intv_mss GE 3).
compute be_intv = (sum(sum(cQ51298, cQ51300, cQ51312, cQ51314, cQ51318),(intv_mss * 1)) * 1) .
ELSE.
compute be_intv = mean(cQ51298, cQ51300, cQ51312, cQ51314, cQ51318) * 1 * 5 .
END IF.

***BE Scales***

count lead_mss = cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328 (sysmis) .
DO IF (lead_mss GE 3).
compute be_lead = (sum(sum(cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328),(lead_mss * 1)) * 1) .
ELSE.
compute be_lead = mean(cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328) * 1 * 8 .
END IF.

*count lead_mss = cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328 (sysmis) .
*DO IF (lead_mss GE 3).
*compute be_lead = (sum(sum(cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328),(lead_mss * 1)) * 1) .
*ELSE.
*compute be_lead = mean(cQ51296, cQ51302, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328) * 1 * 7 .
*END IF.

/*NEW Dropping cQ51302.

count lead_mss = cQ51296, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328 (sysmis) .
DO IF (lead_mss GE 3).
compute be_lead = (sum(sum(cQ51296, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328),(lead_mss * 1)) * 1) .
ELSE.
compute be_lead = mean(cQ51296, cQ51304, cQ51306, cQ51316, cQ51322, cQ51326, cQ51328) * 1 * 7 .
END IF.

count coach_mss = cQ51294, cQ51308, cQ51310, cQ51320, cQ51324 (sysmis) .
DO IF (coach_mss GE 3).
compute be_coach = (sum(sum(cQ51294, cQ51308, cQ51310, cQ51320, cQ51324),(coach_mss * 1)) * 1) .
ELSE.
compute be_coach = mean(cQ51294, cQ51308, cQ51310, cQ51320, cQ51324) * 1 * 5 .
END IF.
EXECUTE.

variable labels
sji_sit 'WRJ Situational Judgment' 
ab_del 'WRJ AB - Delegation'
ab_coach 'WRJ AB - Coaching'
dsp_ao 'WSD Achievement Orientation' 
dsp_ldro 'WSD Leadership Orientation' 
dsp_net 'WSD Networking'  
dsp_od 'WSD Outgoing Disposition' 
dsp_pd 'WSD Positive Disposition' 
dsp_sinc 'WSD Sincerity'  
dsp_soci 'WSD Social Intelligence' 
dsp_adpt 'WSD Adaptability'  
dsp_lrno 'WSD Learning Orientation' 
dsp_dm 'WSD DM Style' 
dsp_wq 'WSD Work Quality' 
dsp_ca 'WSD Confident Approach' 
dsp_loc 'WSD Locus of Control'
be_intv 'BE Initiative'  
be_lead 'BE Leadership'  
be_coach 'BE Coaching' .
EXECUTE.


*Counting Items Missing for a Filter - Should be the Full Set of Items.  Do occular inspection of scale_mss variables*

COUNT items_missing 	= cQ51002 to cQ51328 (sysmis).			
EXECUTE. 

*deleting Items missing variables
delete variables sji_sit_mss ab_del_mss ab_coach_mss dao_mss dldro_mss dnet_mss dod_mss
  dpd_mss dsinc_mss dsoci_mss dadpt_mss dlrno_mss ddm_mss dwq_mss dca_mss
  dloc_mss intv_mss lead_mss coach_mss. 


***Recoding Predictor Outliers as SYSMIS.

*Cleaning Up Standardized Variables - This is Important to Keep You From Creating New Standardized Variables Rather than Replacing the Old.
*NOTE: The First Time, You Will Get an Error (b/c the Standardized Variables Have Not Yet Been Created).

DELETE VARIABLES 	Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd
  		Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc
  		Zbe_intv Zbe_lead Zbe_coach .

*Run This to Base the Standardized Variables on Cases Remaining After the _Predictor_ Filters.

USE ALL.
COMPUTE filter_$=(pred_filters = 0).
FILTER BY filter_$.
EXECUTE .


TITLE 'Westinghouse LII Validation Analyses'.
SUBTITLE 'Predictor Scale Descriptives'.
DESCRIPTIVES VARIABLES=	sji_sit ab_del ab_coach dsp_ao dsp_ldro dsp_net dsp_od dsp_pd dsp_sinc
  				dsp_soci dsp_adpt dsp_lrno dsp_dm dsp_wq dsp_ca dsp_loc be_intv be_lead
  				be_coach
   /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

/*This Counts The Outliers For Use in a Filter.
RECODE 	Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd
  		Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc
  		Zbe_intv Zbe_lead Zbe_coach 	
(Lowest thru -3.29 = 1) (3.29 thru Highest = 1) (ELSE = 0)
	INTO
	out01 to out19.
COMPUTE count_outliers = sum(out01 to out19).
EXECUTE.

**Deleting outlier variables 
DELETE VARIABLES 	out01 to out19. 



*Recoding to Eliminate Univariate Outliers on All Predictor Scales.
RECODE  	Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd
  		Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc
  		Zbe_intv Zbe_lead Zbe_coach
  	(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE .


/*Composite scores.

NUMERIC  wrj_cmp dsp_cmp be_cmp wsd_dfs wsd_ep wsd_insp wsd_lrnag wsd_shds wsd_spo (F8.2).

COMPUTE wrj_cmp 	= mean(Zsji_sit, Zab_del, Zab_coach).
COMPUTE dsp_cmp 	= mean(Zdsp_ao, Zdsp_ldro, Zdsp_net, Zdsp_od, Zdsp_pd, Zdsp_sinc, Zdsp_soci, Zdsp_adpt, Zdsp_lrno, Zdsp_dm, Zdsp_wq, Zdsp_ca, Zdsp_loc).
COMPUTE be_cmp	= mean(Zbe_intv, Zbe_lead, Zbe_coach).
COMPUTE wsd_dfs 	= mean(Zdsp_ao, Zdsp_ldro).
COMPUTE wsd_ep 	= mean(Zdsp_net, Zdsp_od).
COMPUTE wsd_insp 	= mean(Zdsp_pd, Zdsp_sinc, Zdsp_soci).
COMPUTE wsd_lrnag 	= mean(Zdsp_adpt, Zdsp_lrno).
COMPUTE wsd_shds 	= mean(Zdsp_dm, Zdsp_wq).
COMPUTE wsd_spo 	= mean(Zdsp_ca, Zdsp_loc).
exe.

DELETE VARIABLES 	Zwrj_cmp Zdsp_cmp Zbe_cmp Zwsd_dfs Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds
  Zwsd_spo .

TITLE 'Westinghouse LII Validation Study - Predictor Composite Descriptives'.
USE ALL.
COMPUTE filter_$=(pred_filters = 0).
FILTER BY filter_$.
EXECUTE .

DESCRIPTIVES
  VARIABLES= wrj_cmp dsp_cmp be_cmp wsd_dfs wsd_ep wsd_insp wsd_lrnag wsd_shds wsd_spo 
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

*IMPORTANT - To Eliminate Univariate Outliers on All Predictor Composites.
RECODE  	Zwrj_cmp Zdsp_cmp Zbe_cmp Zwsd_dfs Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds
  Zwsd_spo 	 
  		(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE .
	


COMPUTE cb_ovr	= mean(Zwrj_cmp, Zwsd_dfs, Zwsd_ep, Zwsd_insp, Zwsd_lrnag, Zwsd_shds,
  Zwsd_spo, Zbe_cmp).
exe.

VARIABLE LABELS
	wrj_cmp		'Work-related Judgment Composite'
	dsp_cmp		'Work Style and Disposition Composite'
	be_cmp			'Background Experience Composite'
	cb_ovr			'LII 1.0 Overall'
	wsd_dfs			'Drives for Success Factor'
	wsd_ep 		'Engages People Factor'
	wsd_insp 		'Inspires Confidence Factor'
	wsd_lrnag 		'Learning Agility Factor'
	wsd_shds 		'Shows Discipline Factor'
	wsd_spo		'Sustains Positive Outlook Factor'.
EXECUTE.

*Cleaning Up Standardized Variables.
DELETE VARIABLES Zcb_ovr .

*Standardizing Based on Cases Remaining After the _Predictor_ Filters.
USE ALL.
COMPUTE filter_$=(pred_filters = 0).
FILTER BY filter_$.
EXECUTE .

TITLE 'Westinghouse LII Validation Study - Overall Test Score Descriptives'.
DESCRIPTIVES
  VARIABLES=cb_ovr
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

*IMPORTANT - To Eliminate Univariate Outliers on the Overall Predictor Score.
RECODE  	Zcb_ovr
  		(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE .


FILTER OFF.
USE ALL.
EXECUTE .


*****************************************************************************************BEGIN Criterion creation- LII Validation*****************************************************************************************.

numeric ws_avg coa_avg dm_avg comm_avg mc_avg ld_avg (f8.2).
 
/*Run This to Base the Standardized Variables on Cases Remaining After the _Criterion_ Filters.

compute ws_avg	= mean(work_stand1, work_stand2, work_stand3, work_stand4, work_stand_overall).
compute coa_avg	= mean(coaching1, coaching2, coaching3, coaching4, coaching_overall).
compute dm_avg	= mean(dec_making1, dec_making2, dec_making3, dec_making4, dec_making5, dec_making6, dec_making7, dec_making_overall).
compute comm_avg	= mean(comm1, comm2, comm3, comm4, comm5, comm6, comm_overall).
compute mc_avg	= mean(manage_confl1, manage_confl2, manage_confl3, manage_confl4, manage_confl5, manage_confl6, manage_confl7, manage_confl_overall).
compute ld_avg		= mean(leader_disp1, leader_disp2, leader_disp3, leader_disp4, leader_disp5, leader_disp6, leader_disp_overall).
exe.

          
variable labels
ws_avg	'Work Standards'
coa_avg	 'Coaching'
dm_avg	'Decision Making'
comm_avg 'Communication'
mc_avg	'Managing Conflict'
ld_avg 'Leadership Disposition'.
EXECUTE.
 

DELETE VARIABLES Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
                                 Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls
                                 Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance .

USE ALL.
COMPUTE filter_$=(crit_filters= 0).
FILTER BY filter_$.
EXECUTE .

SUBTITLE 'Criterion Competency Descriptives'.
DESCRIPTIVES
  VARIABLES= ws_avg coa_avg dm_avg comm_avg mc_avg ld_avg
                       turnover_for_direct_reports operational_costs compl_security_regs coml_safety_standards enforce_internal_controls cust_serv_culture process_innovation drive_efficiency create_alignment engage_employees drive_performance         
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

*To Eliminate Univariate Outliers.
RECODE 	Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls
                        Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  		(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE.

numeric ovr_unit cando willdo interp leader bottom (F8.2). 

COMPUTE ovr_unit        = mean (Zws_avg, Zcoa_avg, Zdm_avg, Zcomm_avg, Zmc_avg, Zld_avg).
COMPUTE cando 	= mean (Zdm_avg) .
COMPUTE willdo 	= mean (Zws_avg) .
COMPUTE interp 	= mean (Zcomm_avg, Zmc_avg).
COMPUTE leader	= mean (Zcoa_avg, Zld_avg).
COMPUTE bottom	= mean (Zturnover_for_direct_reports, Zoperational_costs, Zcompl_security_regs, Zcoml_safety_standards, Zenforce_internal_controls,
                                                Zcust_serv_culture, Zprocess_innovation, Zdrive_efficiency, Zcreate_alignment, Zengage_employees, Zdrive_performance).
exe.

VARIABLE LABELS
	ovr_unit 'Overall Performance Composite'
	cando  'Can Do Performance Composite'
	willdo  'Will Do Performance Composite'
	interp  'Interpersonal Performance Composite' 
	leader	'Leadership Performance Composite'
	bottom	'Bottom-line/business driver Composite'.
	EXECUTE.

DELETE VARIABLES Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom.

SUBTITLE 'Criterion Competency Descriptives'.
DESCRIPTIVES
  VARIABLES= ovr_unit cando willdo interp leader bottom
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

*To Eliminate Univariate Outliers.
RECODE 	Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
  		(Lowest thru -3.29=SYSMIS)  (3.29 thru Highest=SYSMIS).
EXECUTE.

FILTER OFF.
USE ALL.
EXECUTE .

VARIABLE LABELS
Zwsd_dfs 'Zscore(Drives for Success Factor)'
Zwsd_ep 'Zscore(Engages People Factor)'
Zwsd_insp 'Zscore(Inspires Confidence Factor)'
Zwsd_lrnag 'Zscore(Learning Agility Factor)'
Zwsd_shds 'Zscore(Shows Discipline Factor)'
Zwsd_spo 'Zscore(Sustains Positive Outlook Factor)'.
EXECUTE.


****************************************************************BEGIN FILTER CREATION**************************************************************.

***************Potential RATER ERROR criterion filters (using Evan's syntax)**************************

*****STEP 1******

***First, create a single variable averaging all of the individual dimensions, but WITHOUT overall performance ratings
***Second, create a variable as the variance of all dimension items (NOT including overall items)
***Insert these variable names in the right side of the computations below
***Also, insert the name of your Familiarity Variable and your Frequency of Contact Variable (if available)

COMPUTE alldims 		= mean(Zws_avg, Zcoa_avg, Zdm_avg, Zcomm_avg, Zmc_avg, Zld_avg) .
COMPUTE pers_var 		= variance (work_stand1, work_stand2, work_stand3, work_stand4, coaching1, coaching2, coaching3, coaching4, dec_making1, 
                                                                 dec_making2, dec_making3, dec_making4, dec_making5, dec_making6, dec_making7, comm1, comm2, comm3, comm4, comm5, 
                                                                 comm6, manage_confl1, manage_confl2, manage_confl3, manage_confl4, manage_confl5, manage_confl6, manage_confl7,
                                                                 leader_disp1, leader_disp2, leader_disp3, leader_disp4, leader_disp5, leader_disp6) .
COMPUTE famil			= Frequency .
COMPUTE contact 		= Familiarity .
COMPUTE rater_accuracy	= Accuracy .
EXECUTE.

****STEP 2: RUN THE SYNTAX BELOW****
**************NOTE: IT WILL REPLACE THE WORKING FILE, SO SAVE BEFORE RUNNING THIS SECTION***************

*****Aggregating by Supervisor to Check Rater Quality--Start by Recoding Supervisor Name into a Numeric Code Variable
*****NOTE: This syntax deletes cases with blank supervisor names
*****To Aggregate by Rating Site, Replace "sup_id" with Location Code.by Rating Site, Replace "supid" with Location Code

AUTORECODE
  VARIABLES=mgr_ID /INTO sup_id
  /PRINT.


AGGREGATE OUTFILE=*
	/BREAK 								= sup_id 
	/COUNT 	'Number of Incumbents Rated'				= N 
	/avgfamil 	'Average Familiarity'					= mean(famil)
	/avgcont 	'Average Contact Frequency'				= mean(contact)
	/avgacc		'Average Accuracy'					= mean(rater_accuracy)
	/avgall 		'Mean Across Dims and Ratees'				= mean(alldims)
	/sdratee		'B/w Ratee Discriminability - SD Across Dims'		= sd(alldims)
	/varall		'Halo - Low Variance Within Ratee'			= mean(pers_var)
	/highall 		'Leniency - Pct of Ratees Above 4'			= pin(alldims,4.01,5)
	/lowall		'Severity - Pct of Ratees Below 2'			            = pin(alldims,1,1.99)
	/midall 		'Central Tendency - Pct of Ratees b/w 2.5 and 3.5'	= pin(alldims,2.5,3.5).
EXECUTE.

FILTER OFF.
USE ALL.
SELECT IF(sup_id > 1).
EXECUTE.


***Saves Standardized Values as Variables

DESCRIPTIVES
  VARIABLES=count avgfamil avgacc avgcont avgall sdratee varall highall lowall midall
   /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .

***Sets Leniency, Severity, and Central Tendency Values as Missing for Those Rating Only 1 Person
***Otherwise, these concepts really make no sense...

DO IF (count = 1) .
RECODE
  highall lowall midall  (ELSE=SYSMIS)  .
END IF .
EXECUTE .

***Number of Incumbents Report.

SORT CASES BY
  count (D) .
summarize
  /tables=sup_id count zcount 
  /title='Supervisors by Number of Incumbents Rated'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Average Familiarity Report.

SORT CASES BY
  avgfamil (A) .
summarize
  /tables=sup_id count avgfamil zavgfamil 
  /title='Supervisors by Average Familiarity Rating'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Average Accuracy Report.

SORT CASES BY
  avgacc (A) .
summarize
  /tables=sup_id count avgacc zavgacc
  /title='Supervisors by Average Accuracy Rating'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Average Contact Frequency Report--NOTE: CHECK CODING TO MAKE SURE THE ORDERING IS APPROPRIATE.

SORT CASES BY
  avgcont (A) .
summarize
  /tables=sup_id count avgcont zavgcont 
  /title='Supervisors by Average Contact Frequency Rating'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***SD Across Ratees Report.

SORT CASES BY
  sdratee   (A) .
summarize
  /tables=sup_id count sdratee zsdratee 
  /title='Supervisors by SD Across Ratees'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Within Ratee Variance Report.

SORT CASES BY
  varall (A) .
summarize
  /tables=sup_id count varall zvarall 
  /title='Supervisors by Within Ratee Variance'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Potenial Leniency Report.

SORT CASES BY
  highall  (D) .
summarize
  /tables=sup_id count highall zhighall
  /title='Supervisors by Percent Above 4 - Potential Leniency'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Potenial Severity Report.

SORT CASES BY
  lowall  (D) .
summarize
  /tables=sup_id count lowall zlowall
  /title='Supervisors by Percent Below 2 - Potential Severity'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.

***Potenial Central Tendency Report.

SORT CASES BY
  midall  (D) .
summarize
  /tables=sup_id count midall zmidall
  /title='Supervisors by Percent b/w 2.5 and 3.5 - Potential Central Tendency'
  /format=validlist nocasenum total missing='.'
  /statistics=none.
execute.


******STEP 3: look for potential outliers (Z score above or below 3.29)

*************************
CRITERION FILTERS -- ('1' is filtered OUT of sample)
*************************


 FREQUENCIES
  VARIABLES=frequency familiarity accuracy
  /ORDER=  ANALYSIS .



RECODE Frequency	(1 = 1) (ELSE = 0) 	INTO low_freq_filter.
RECODE Familiarity	(1 = 1) (ELSE = 0) 	INTO low_famil_filter.
*RECODE mgr_ID	('hmm116' = 1) (ELSE = 0)	INTO severity_error_filter.
*RECODE mgr_ID	('hmm005' = 1) (ELSE = 0)	INTO within_ratee_variance.	
RECODE Accuracy	(1 = 1) (ELSE = 0) 	INTO low_accuracy_filter.
EXECUTE.

variable labels
	low_freq_filter			'Filtered if low Frequency'	
	low_famil_filter			'Filtered if low Familiarity'
	low_accuracy_filter		'Filtered if low Accuracy'.
exe.


COMPUTE crit_filters = sum(low_accuracy_filter, low_freq_filter, low_famil_filter) .
RECODE crit_filters (0=0) (ELSE = 1) .
EXECUTE .

*************************
PREDICTOR FILTERS -- ('1' is filtered OUT of sample)
*************************

FREQUENCIES
  VARIABLES=items_missing count_outliers ir2 ir6 orgten jobten 
  /ORDER=  ANALYSIS .


RECODE items_missing  	(44 thru highest= 1)  (ELSE=0) 		INTO items_missing_filter .
RECODE count_outliers 	(2 thru Highest = 1) (ELSE = 0)		INTO outliers_filter.
exe.


***. 

RECODE orgten 	(Lowest thru 2 = 1) (ELSE = 0)		INTO orgten_filter.
RECODE jobten		(Lowest thru 3 = 1) (ELSE = 0)		INTO posten_filter.

COMPUTE pred_filters = sum(items_missing_filter, outliers_filter, orgten_filter).
RECODE pred_filters (0 = 0) (ELSE = 1). 
EXECUTE .


*************************
FINAL SAMPLE FILTER -- ('0' is filtered OUT of sample)
*************************

/*

delete variables val_samp val_samp_temp .

RECODE matched (1 = 0) (ELSE = 1) INTO matched_filter.
COMPUTE val_samp_temp = sum(pred_filters, crit_filters, matched_filter).
RECODE val_samp_temp (0 = 1) (ELSE = 0).
EXECUTE.

RENAME VARIABLES (val_samp_temp = val_samp).
EXECUTE.

variable labels
val_samp 'FINAL VALIDATION SAMPLE'.
exe.

value labels val_samp
0 'Filtered OUT of sample'
1 'Included in sample'.
exe. 


**********************************************************Initial look at relationships******************************************************************************************************

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc
  Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc  .

*graphs to examine relationships

GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ao WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ldro WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_net WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_od WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_pd WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_sinc WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)= Zdsp_soci WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_adpt WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_lrno WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_dm WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_wq WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ca WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_loc WITH Zovr_unit
  /MISSING=LISTWISE .


*see differences with filter
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc
  Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc  .
FILTER OFF.
USE ALL.
EXECUTE .

*graphs to examine relationships

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ao WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ldro WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_net WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_od WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_pd WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_sinc WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)= Zdsp_soci WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_adpt WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_lrno WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_dm WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_wq WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_ca WITH Zovr_unit
  /MISSING=LISTWISE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zdsp_loc WITH Zovr_unit
  /MISSING=LISTWISE .
FILTER OFF.
USE ALL.
EXECUTE .



***************************************************Initial look at data & Preliminary correlations*************************************************************************.

TITLE 'frequency tables of various filter variables'.
FREQUENCIES
  VARIABLES=low_famil_filter low_freq_filter severity_error_filter within_ratee_variance low_accuracy_filter crit_filters items_missing_filter outliers_filter orgten_filter posten_filter pred_filters
                      matched_filter val_samp
  /STATISTICS=SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=  ANALYSIS .


TITLE 'frequency tables of various filter variables'.
FREQUENCIES
  VARIABLES=low_famil_filter low_freq_filter low_accuracy_filter 
  /STATISTICS=SKEWNESS SESKEW KURTOSIS SEKURT
  /ORDER=  ANALYSIS .

TITLE 'histograpms of the predictor score distribution'.
FREQUENCIES
  VARIABLES=Zcb_ovr Zwrj_cmp Zdsp_cmp Zbe_cmp Zwsd_dfs Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds
                      Zwsd_spo Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq
                      Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
  /HISTOGRAM
  /ORDER=  ANALYSIS .


TITLE 'histograpms of the criterion score distribution'.
FREQUENCIES
  VARIABLES=Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                      Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg
                      Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                      Ze3_CABER Zint_stay 
 /HISTOGRAM
  /ORDER=  ANALYSIS .

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zcb_ovr Zwrj_cmp Zdsp_cmp Zbe_cmp 
                        Zwsd_dfs Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zcb_ovr Zwrj_cmp Zdsp_cmp Zbe_cmp 
                        Zwsd_dfs Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        WITH 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



*************************************************************************************************COMPOSITE MANIPULATIONS for final scoring********************************************************************.
***Factor level manipulations***.

TITLE 'Westinghouse LII WRJ regression'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit  
  /METHOD=ENTER Zsji_sit Zab_del Zab_coach.
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Westinghouse LII WSD regression'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit  
  /METHOD=ENTER Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt
                              Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc.
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Westinghouse LII BE regression'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT  Zovr_unit
  /METHOD=ENTER Zbe_intv Zbe_lead Zbe_coach.
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Drive for Success'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER Zdsp_ao Zdsp_ldro .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Engages People'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER Zdsp_net Zdsp_od .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Inspires Confidence'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER  Zdsp_pd Zdsp_sinc Zdsp_soci .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Learning Agility'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER  Zdsp_adpt Zdsp_lrno .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Shows Discipline'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER  Zdsp_dm Zdsp_wq .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Sustains Positive Outlook'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER  Zdsp_ca Zdsp_loc .
FILTER OFF.
USE ALL.
EXECUTE .



************************************************Create new composites**********************************************************.



COMPUTE wrj_cmp2	 	= mean(Zab_coach). 	 /*no Zsji_sit OR Zab_del .

COMPUTE dsp_cmp2	 	= mean(Zdsp_ldro, Zdsp_net, Zdsp_pd, Zdsp_sinc, Zdsp_soci, Zdsp_lrno, Zdsp_wq, Zdsp_loc, Zdsp_od, Zdsp_adpt, Zdsp_ca). 	        /*no Zdsp_ao .

COMPUTE be_cmp2	 	= mean(Zbe_lead, Zbe_coach). 	        /*no Zbe_intv .

COMPUTE wsd_dfs2	 	= mean(Zdsp_ldro). 	        /*no Zdsp_ao .


variable labels
wrj_cmp2		'WRJ composite -- NO Zsji_sit OR Zab_del' 
dsp_cmp2		'DSP composite -- NO Zdsp_ao '
be_cmp2	 	'BE composite -- NO Zbe_intv'
wsd_dfs2		'Drives for Success Composite -- no Zdsp_ao'
exe.

delete variables Zwrj_cmp2 Zwsd_cmp2 Zbe_cmp2 Zwsd_dfs2.

USE ALL.
COMPUTE filter_$=(pred_filters = 0).
FILTER BY filter_$.
EXECUTE .
DESCRIPTIVES
  VARIABLES=wrj_cmp2 dsp_cmp2 be_cmp2 wsd_dfs2
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
TITLE 'preliminary correlations between all adjusted compostites and criteria'.
CORRELATIONS
  /VARIABLES= Zwrj_cmp2 Zwsd_cmp2 Zbe_cmp2 Zwsd_dfs2
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
TITLE 'preliminary between all original compostites and criteria'.
CORRELATIONS
  /VARIABLES= Zwrj_cmp Zdsp_cmp Zbe_cmp Zwsd_dfs 
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



***********************************************************************************Overall Factor Weighting*********************************************************************


TITLE 'Westinghouse LII Validation Study'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN
  /DEPENDENT Zovr_unit
  /METHOD=ENTER Zwrj_cmp2 Zbe_cmp2 Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo .
EXECUTE .

compute LII_ovr2 =mean(Zwrj_cmp2 * 3, Zbe_cmp2 * 1, Zwsd_dfs2 * 2, Zwsd_ep * 1, Zwsd_insp * 3, Zwsd_lrnag * 2, Zwsd_shds * 1, Zwsd_spo * 4).
compute LII_ovr3 =mean(Zwrj_cmp2 * 2, Zbe_cmp2 * 1, Zwsd_dfs2 * 2, Zwsd_ep * 2, Zwsd_insp * 3, Zwsd_lrnag * 3, Zwsd_shds * 2, Zwsd_spo * 4).
compute LII_ovr4 =mean(Zwrj_cmp2 * 4, Zbe_cmp2 * 1, Zwsd_dfs2 * 2, Zwsd_ep * 1, Zwsd_insp * 4, Zwsd_lrnag * 2, Zwsd_shds * 1, Zwsd_spo * 5).
compute LII_ovr5 =mean(Zwrj_cmp2 * 3, Zbe_cmp2 * 1, Zwsd_dfs2 * 2, Zwsd_ep * 1, Zwsd_insp * 4, Zwsd_lrnag * 2, Zwsd_shds * 1, Zwsd_spo * 5).
compute LII_ovr6 =mean(Zwrj_cmp2 * 2, Zbe_cmp2 * 1, Zwsd_dfs2 * 2, Zwsd_ep * 1, Zwsd_insp * 3, Zwsd_lrnag * 2, Zwsd_shds * 1, Zwsd_spo * 4).
exe.

variable labels
LII_ovr2 'LII 2 - 3,1,2,1,3,2,1,4'
LII_ovr3 'LII 3 - 2,1,2,2,3,3,2,4'
LII_ovr4 'LII 4 - 4,1,2,1,4,2,1,5'
LII_ovr5 'LII 5 - 3,1,2,1,4,2,1,5'
LII_ovr6 'LII 6 - 2,1,2,1,3,2,1,4'.
exe.


DELETE VARIABLES zLII_ovr2 zLII_ovr3 zLII_ovr4 zLII_ovr5 zLII_ovr6.

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$.
EXECUTE .
SUBTITLE 'Overall Test Score Descriptives'. 
DESCRIPTIVES VARIABLES =LII_ovr2 LII_ovr3 LII_ovr4 LII_ovr5 LII_ovr6
/SAVE 
/STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .


*****************************************************************Preliminary Correlations (with adjusted composites) & Overall Scatterplot********************************************************


TITLE 'preliminary correlations between all scales and criteria'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr2 ZLII_ovr3 ZLII_ovr4 ZLII_ovr5 ZLII_ovr6 Zcb_ovr Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .



USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= LII_ovr2 LII_ovr3 LII_ovr4 LII_ovr5 LII_ovr6 Zcb_ovr Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        WITH 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .


TITLE 'scatterplots of overall test score with overall performance'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=ZLII_ovr4 WITH Zovr_unit 
  /MISSING=LISTWISE .


*********************LII_ovr4 is the winner!!!!

variable labels
LII_ovr4 'LII 4 - 4,1,2,1,4,2,1,5 -- FINAL' 
ZLII_ovr4 'Z score: LII 4 - 4,1,2,1,4,2,1,5 -- FINAL' .
exe.


DELETE VARIABLES LII_ovr2 LII_ovr3 LII_ovr5 LII_ovr6 zLII_ovr2 zLII_ovr3 zLII_ovr5 zLII_ovr6.


**********************************************************FULL CORRELATION TABLE*******************************************************************

TITLE 'FINAL correlations between all scales and criteria'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
                        Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .


*******************************************************************EXPECTANCY CHARTS/ODDS RATIOS********************************************************.

DELETE VARIABLES 	 NZcb_ovr_3Cats NLII_ovr NZovr_un NZcando NZwilldo NZinterp NZleader NZbottom NZws_avg NZcoa_av NZdm_avg NZcomm_a NZmc_avg NZld_avg NZturnov NZoperat NZcompl_
                                     NZcoml_s NZenforc NZcust_s NZproces NZdrive_ NZcreate NZengage NTI001 NZe3_CAB NZint_st
EXECUTE.


USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
RANK VARIABLES=	LII_ovr4 
			(A) /NTILES (4) /PRINT=NO /TIES=MEAN .

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
RANK VARIABLES=	Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                                    Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
                                    Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                                    Ze3_CABER Zint_stay
                                    (A) /NTILES (2) /PRINT=NO /TIES=MEAN .

RECODE NLII_ovr  (1 = 1) (2 thru 3 = 2) (4 = 3) INTO NZcb_ovr_3Cats.
EXECUTE. 


TITLE 'Westinghouse LII - Crosstabs'.
CROSSTABS
/TABLES=
NZcb_ovr_3Cats
BY  
NZovr_un NZcando NZwilldo NZinterp NZleader NZbottom NZws_avg NZcoa_av NZdm_avg NZcomm_a NZmc_avg NZld_avg NZturnov NZoperat NZcompl_
NZcoml_s NZenforc NZcust_s NZproces NZdrive_ NZcreate NZengage NTI001 NZe3_CAB NZint_st
/FORMAT= AVALUE TABLES
/CELLS= COUNT ROW .   


SUBTITLE 'Test Score and Overall Performance'.
CROSSTABS
/TABLES=NZcb_ovr_3Cats BY NZovr_un 
/FORMAT= AVALUE TABLES
/CELLS= COUNT ROW .

*******************************************************************************************Information for PPT presentation*******************************************************************************************.

TITLE 'Westinghouse LII Validation Study -- demographics'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
FREQUENCIES
  VARIABLES=gender race Over40 age
  /STATISTICS=STDDEV MEAN
  /ORDER=  ANALYSIS .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Westinghouse LII Validation Study -- outcome variables'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4   
  WITH 
  Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

TITLE 'Westinghouse LII Validation Study -- outcome variables'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4   
  WITH 
  Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Westinghouse LII Validation Study -- bottomline variables'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4   
  WITH 
  Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture 
  Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Westinghouse LII Validation Study -- engagement variables'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4    
  WITH 
  Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

*******************************************************************************************Correlations for Test X Dimension Spreadsheet*******************************************************************************************.

***Correlations for Test X Dimension Spreadsheet.

TITLE 'Correlations for Test X Dimension Spreadsheet - Part 1'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=	Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
		WITH
		ZLII_ovr4 Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'Correlations for Test X Dimension Spreadsheet - Part 2'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=	Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
		WITH
		Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



TITLE 'Correlations for Test X Dimension Spreadsheet - Part 3'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=	Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
		WITH
		ZLII_ovr4 Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



TITLE 'Correlations for Test X Dimension Spreadsheet - Part 4'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=	Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
		WITH
		Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



*******************************************************************************************Information for Westinghouse Report*******************************************************************************************.


title 'Table 3 and 4'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
FREQUENCIES
  VARIABLES=gender race 
  /ORDER=  ANALYSIS .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 5'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES=orgten jobten
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 6'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= LII_ovr4 Zwrj_cmp2 wsd_dfs2 wsd_ep wsd_insp wsd_lrnag wsd_shds wsd_spo be_cmp2 
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 7' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= ovr_unit cando willdo interp leader bottom
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 8' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 9' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= turnover_for_direct_reports operational_costs compl_security_regs coml_safety_standards 
                       enforce_internal_controls cust_serv_culture process_innovation drive_efficiency create_alignment 
                       engage_employees drive_performance
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Table 10' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= e3_CABER int_stay
  /STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .
  
title 'Table 11' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=ZLII_ovr4 Zwrj_cmp2
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo Zbe_cmp2 
                        WITH 
                        Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Predictor Composites and Bottom-line Criteria' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=ZLII_ovr4 Zwrj_cmp2 
                       Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo Zbe_cmp2 
                       WITH  
                       Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation 
                       Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Predictor composites and Attitudinal Criteria' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES=ZLII_ovr4 Zwrj_cmp2  
                       Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo Zbe_cmp2 
                       WITH  
                       Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

Title 'Appendix B - Scoring detail' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
DESCRIPTIVES
  VARIABLES= sji_sit ab_del ab_coach 
                       wsd_dfs2 wsd_ep wsd_insp wsd_lrnag wsd_shds wsd_spo 
                      be_intv be_lead be_coach
/STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Mega correlation table -- Criterion composites' 
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zbe_cmp2 Zsji_sit Zab_del Zab_coach Zbe_intv Zbe_lead Zbe_coach
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                       	WITH  
		 Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


title 'Mega correlation table -- Bottom-line'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zbe_cmp2 Zsji_sit Zab_del Zab_coach Zbe_intv Zbe_lead Zbe_coach
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
		WITH  
		Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Mega correlation table -- Bottom-line items continued'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zbe_cmp2 Zsji_sit Zab_del Zab_coach Zbe_intv Zbe_lead Zbe_coach
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
		WITH  
		Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .


title 'Mega correlation table -- Attitudinal criteria'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zbe_cmp2 Zsji_sit Zab_del Zab_coach Zbe_intv Zbe_lead Zbe_coach
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
		WITH  
		Ze3_CABER Zint_stay
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'Mega correlation table -- Criterion dimensions'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zbe_cmp2 Zsji_sit Zab_del Zab_coach Zbe_intv Zbe_lead Zbe_coach
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
		WITH  
		Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

************************************************Supplementary Analyses - Requested by Charles************************************************************************


Match files file='W:\WORKING\A&T_TECH\CLIENTS\Westinghouse\Analysis\Westinghouse LII MASTER_pre additional analysis data added.sav'
	/file='W:\WORKING\A&T_TECH\CLIENTS\Westinghouse\Data\Data for Supplementary Analyses master.sav'
            /IN suppliment_analyses_matched
	/BY cde_applicant_id.
EXECUTE.

**************** additional performance variables - objectives & competencies


variable labels
objectives 'additional performance variable -- OBJECTIVES'
competencies 'additional performance variable -- COMPETENCIES'.
exe.


DELETE VARIABLES Zobjectives Zcompetencies.

USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$.
EXECUTE .
SUBTITLE 'Overall Test Score Descriptives'. 
DESCRIPTIVES VARIABLES =objectives competencies
/SAVE 
/STATISTICS=MEAN STDDEV MIN MAX .
FILTER OFF.
USE ALL.
EXECUTE .

*Note - objectives and competencies are basically 2 categorical variables given that most of the ratings are "3's" & "4's"



**********************Correlation table -- relationships b/t additional performance variables and predictors

title 'correlations - test variables x additional variables 1'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= ZLII_ovr4 Zwrj_cmp2 Zdsp_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
                        WITH 
		Zobjectives Zcompetencies
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'correlations - test variables x additional variables 2'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zsji_sit Zab_del Zab_coach Zdsp_ao Zdsp_ldro Zdsp_net Zdsp_od Zdsp_pd Zdsp_sinc Zdsp_soci Zdsp_adpt Zdsp_lrno Zdsp_dm Zdsp_wq Zdsp_ca Zdsp_loc Zbe_intv Zbe_lead Zbe_coach
                        WITH 
		Zobjectives Zcompetencies
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



*************************Correlation table -- relationships b/t additional performance variables and criteria

title 'correlations -- additional variables x performance variables 1'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zovr_unit Zcando Zwilldo Zinterp Zleader Zbottom
                        Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
                        WITH 
                        Zobjectives Zcompetencies
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .

title 'correlations -- additional variables x performance variables 2'
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zturnover_for_direct_reports Zoperational_costs Zcompl_security_regs Zcoml_safety_standards Zenforce_internal_controls Zcust_serv_culture Zprocess_innovation Zdrive_efficiency Zcreate_alignment Zengage_employees Zdrive_performance
                        Ze3_CABER Zint_stay
                        WITH 
                       Zobjectives Zcompetencies
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .




**************************Scatterplots

TITLE 'scatterplots of overall test score with Objectives'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=LII_ovr4 WITH Zobjectives
  /MISSING=LISTWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'scatterplots of overall test score with Competencies'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=LII_ovr4 WITH Zcompetencies
  /MISSING=LISTWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'scatterplots of overall performance with Objectives'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zovr_unit WITH Zobjectives
  /MISSING=LISTWISE .
FILTER OFF.
USE ALL.
EXECUTE .


TITLE 'scatterplots of overall performance with Competencies'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
GRAPH
  /SCATTERPLOT(BIVAR)=Zovr_unit WITH Zcompetencies
  /MISSING=LISTWISE .
FILTER OFF.
USE ALL.
EXECUTE .


title 'correlations for clarification report'.
USE ALL.
COMPUTE filter_$=val_samp.
FILTER BY filter_$ .
EXECUTE .
CORRELATIONS
  /VARIABLES= Zwrj_cmp2 Zbe_cmp2 
                        Zwsd_dfs2 Zwsd_ep Zwsd_insp Zwsd_lrnag Zwsd_shds Zwsd_spo 
		WITH  
		Zws_avg Zcoa_avg Zdm_avg Zcomm_avg Zmc_avg Zld_avg 
  /PRINT=ONETAIL NOSIG
  /MISSING=PAIRWISE .
FILTER OFF.
USE ALL.
EXECUTE .



















