-- Categorizing projects based on keywords in the project description
-- Categories: 1) ITT, Vehicles, and Equipment 2) Lump Sum 3) Fixed Asset


--Group projects into the ITT, Vehicles, and Equipment category
--managing agency: ALL
--SELECT * FROM cpdb_dcpattributes
UPDATE cpdb_dcpattributes SET typecategory = 'ITT, Vehicles, and Equipment'
WHERE (
upper(description) LIKE '%VEHICLE%'
OR upper(description) LIKE '%AMBULANCE%'
OR upper(description) LIKE '%BUSES%'
OR upper(description) LIKE '%TRUCK%'
OR upper(description) LIKE '%TRAILER%'
OR upper(description) LIKE '%VANS%'

OR upper(description) LIKE '%EQUIPMENT%'
OR upper(description) LIKE '%CRANE%'
OR upper(description) LIKE '%FURNITURE%'
OR upper(description) LIKE '%PORTABLE%'

OR upper(description) LIKE '% IT %'
OR upper(description) LIKE '%AUDIO%'
OR upper(description) LIKE '%CAMERA%'
OR upper(description) LIKE '%COMPUTERS%'
OR upper(description) LIKE '%DATA%'
OR upper(description) LIKE '%DOITT%'
OR upper(description) LIKE '%FISA%'
OR upper(description) LIKE '%GIS%'
OR upper(description) LIKE '%HARDWARE%'
OR upper(description) LIKE '%MAINFRAME%'
OR upper(description) LIKE '%MOBILE%'
OR upper(description) LIKE '%PHONE%'
OR upper(description) LIKE '%PRINTER%'
OR upper(description) LIKE '%SERVER%'
OR upper(description) LIKE '%SOFTWARE%'
OR upper(description) LIKE '%RADIO %'
OR upper(description) LIKE '%RADIOS%'
OR upper(description) LIKE '%VIDEO%'
OR upper(description) LIKE '%VOIP%'
OR upper(description) LIKE '%WIFI%'

-- New trigger words
OR upper(description) LIKE '%A/V%'
OR upper(description) LIKE '% AV %'
OR upper(description) LIKE '%ACCESS%UPGRADE%'
OR upper(description) LIKE '%AIMS%'
OR upper(description) LIKE '%ANALYTICS%'
OR upper(description) LIKE '%ANTENA%'
OR upper(description) LIKE '%APPARATUS%'
OR upper(description) LIKE '%ARREST%PROCESSING%'
OR upper(description) LIKE '%ARRESTOR%'
OR upper(description) LIKE '%ASSET%TRACKER%'
OR upper(description) LIKE '%AUTOMATIC%'
OR upper(description) LIKE '%AUTOMATION%'
OR upper(description) LIKE '%BARGE%'
OR upper(description) LIKE '%BED%'
OR upper(description) LIKE '% BMS %'
OR upper(description) LIKE '%BOATS%'
OR upper(description) LIKE '% BUS %'
OR upper(description) LIKE '%BUS'
OR upper(description) LIKE '%CART%'
OR upper(description) LIKE '%CATHETERIZATION%'
OR upper(description) LIKE '%CCTV%'
OR upper(description) LIKE '%CHECKBOOK%NYC%'
OR upper(description) LIKE '%CISCO%'
OR upper(description) LIKE '%CITYTIME%'
OR upper(description) LIKE '%COMMUNICATIONS%'
OR upper(description) LIKE '%COMMUNICATION%EQUI%'
OR upper(description) LIKE '%COMPRESSOR%'
OR upper(description) LIKE '%COMPUTER%EQUIP%'
OR upper(description) LIKE '%COMPUTER%REPL%'
OR upper(description) LIKE '%COMPUTER%SYS%'
OR upper(description) LIKE '%COMP%UPGRADE%'
OR upper(description) LIKE '%COMPUTERIZED%'
OR upper(description) LIKE '%COPIER%'
OR upper(description) LIKE '%CT%SCAN%'
OR upper(description) LIKE '%CURTAIN%'
OR upper(description) LIKE '%CYTOMETER%'
OR upper(description) LIKE '%DCTV%'
OR upper(description) LIKE '%DESKTOP%'
OR upper(description) LIKE '%DEVICE%'
OR upper(description) LIKE '%DIGITAL%'
OR upper(description) LIKE '%DISINFECTION%'
OR upper(description) LIKE '%E-TICKET%'
OR upper(description) LIKE '%ECTP%'
OR upper(description) LIKE '%ELECTRONIC%'
OR upper(description) LIKE '%EMAIL%'
OR upper(description) LIKE '%ENCRYPT%'
OR upper(description) LIKE '%ENGINE%'
OR upper(description) LIKE '%ENTERPRISE%SOLUTIONS%'
OR upper(description) LIKE '%EQ%PURCHASE%'
OR upper(description) LIKE '%EQUIP%'
OR upper(description) LIKE '%FERRY%BO%'
OR upper(description) LIKE '%FFE%'
OR upper(description) LIKE '%FILM%'
OR upper(description) LIKE '%FIREBOAT%'
OR upper(description) LIKE '%FLAT%BED%'
OR upper(description) LIKE '%FLEET%'
OR upper(description) LIKE '%FMS%'
OR upper(description) LIKE '%FORKLIFT%'
OR upper(description) LIKE '%GENERATOR%'
OR upper(description) LIKE '%GPS%'
OR upper(description) LIKE '%HDTV%'
OR upper(description) LIKE '%HELICOPTER%'
OR upper(description) LIKE '%HHS%ACC%'
OR upper(description) LIKE '%INFO%MANAGE%'
OR upper(description) LIKE '%INFO%SECURITY%'
OR upper(description) LIKE '%INTERFACE%'
OR upper(description) LIKE 'IT %'
OR upper(description) LIKE '% IT'
OR upper(description) LIKE '%IVR %'
OR upper(description) LIKE '%KEYWORD%'
OR upper(description) LIKE '%KITS%'
OR upper(description) LIKE '%LADDER%'
OR upper(description) LIKE '% LAN %'
OR upper(description) LIKE '%LUNG%UNIT%'
OR upper(description) LIKE '%MACHINE%'
OR upper(description) LIKE '%MAMOGRAM%'
OR upper(description) LIKE '%MANHOLE%COVER%'
OR upper(description) LIKE '%MANHOLE%RING%'
OR upper(description) LIKE '%MANOMETRY%'
OR upper(description) LIKE '%MED%EQMT%'
OR upper(description) LIKE '%MEDIA%UPGRADE%'
OR upper(description) LIKE '%MICROFILM%'
OR upper(description) LIKE '%MICROSCOPE%'
OR upper(description) LIKE '%MICROSPECT%'
OR upper(description) LIKE '%MINI%BUS%'
OR upper(description) LIKE '%MINI%VAN%'
OR upper(description) LIKE '%MOBILIZING%'
OR upper(description) LIKE '%MONITOR%'
OR upper(description) LIKE '%MOORING%UPGRADE%'
OR upper(description) LIKE '%MOSAICS%'
OR upper(description) LIKE '%MOVEABLE%'
OR upper(description) LIKE '%MRI%'
OR upper(description) LIKE '%NETWORK%'
OR upper(description) LIKE '%NOVAS%'
OR upper(description) LIKE '%NYCAPP%'
OR upper(description) LIKE '%NYCAPS%'
OR upper(description) LIKE '%NYCSERV%'
OR upper(description) LIKE '%OAISIS%'
OR upper(description) LIKE '%PAPERLESS%'
OR upper(description) LIKE '%PASSENGER%VAN%'
OR upper(description) LIKE '%PIANO%'
OR upper(description) LIKE '%PORTAL%'
OR upper(description) LIKE '%POWER%WASHER%'
OR upper(description) LIKE '%PRINTING%'
OR upper(description) LIKE '%PROJECTORS%'
OR upper(description) LIKE '%PROJECTION%SYS%'
OR upper(description) LIKE '%PROJECTION%SOUND%SYSTEM%'
OR upper(description) LIKE '%PUMPERS%'
OR upper(description) LIKE '%PURCHASE%'
OR upper(description) LIKE '%REAL%TIME%INFO%'
OR upper(description) LIKE '%REAL%TIME%SIGN%'
OR upper(description) LIKE '%RECORDER%'
OR upper(description) LIKE '%REFRIGERATOR%'
OR upper(description) LIKE '%REPORTING%'
OR upper(description) LIKE '%RESPONSE%BOAT%'
OR upper(description) LIKE '% RIG %'
OR upper(description) LIKE '%ROBOT%'
OR upper(description) LIKE '%ROUTER%'
OR upper(description) LIKE '%SATELLITE%'
OR upper(description) LIKE '%SCANNER%'
OR upper(description) LIKE '%SCANNING%'
OR upper(description) LIKE '%SCHOOL%BUS%'
OR upper(description) LIKE '%SELF%CHECK%'
OR upper(description) LIKE '%SEQUENCER%'
OR upper(description) LIKE '%SHUTTLE%'
OR upper(description) LIKE '%SIMULATOR%'
OR upper(description) LIKE '%SKID%STEER%'
OR upper(description) LIKE '%SPECTROMETER%'
OR upper(description) LIKE '%SPECTROPHMETER%'
OR upper(description) LIKE '%SUBURBANS%'
OR upper(description) LIKE '%SURVEILLANCE%'
OR upper(description) LIKE '%SONOGRAM%'
OR upper(description) LIKE '%SOUND%SYST%'
OR upper(description) LIKE '%STREAMING%'
OR upper(description) LIKE '%SWEEPER%'
OR upper(description) LIKE '%SYSTEM%INTEGRATOR%'
OR upper(description) LIKE '%SYSTEM%UPGRADE%'
OR upper(description) LIKE '% TABLES%'
OR upper(description) LIKE '% TECH%'
OR upper(description) LIKE 'TECH%'
OR upper(description) LIKE '%TELECOM%'
OR upper(description) LIKE '%TELEMETRY%'
OR upper(description) LIKE '%TOOLCAT%'
OR upper(description) LIKE '%TRACTOR%'
OR upper(description) LIKE '%TRAM%'
OR upper(description) LIKE '%TRANSPORTATION%BUS%'
OR upper(description) LIKE '%TROLLEY%'
OR upper(description) LIKE '%ULTRASOUND%'
OR upper(description) LIKE '%VAN'
OR upper(description) LIKE '%VASCULAR%'
OR upper(description) LIKE '%VENDING%'
OR upper(description) LIKE '%VESSEL%'
OR upper(description) LIKE '%VIRTUAL%'
OR upper(description) LIKE '%VOICE%'
OR upper(description) LIKE '%WAGON%'
OR upper(description) LIKE '%WEB%PROXY%'
OR upper(description) LIKE '%WEBSITE%'
OR upper(description) LIKE '%WI-FI%'
OR upper(description) LIKE '%WIRELESS%'
OR upper(description) LIKE '%WIRETAP%'
OR upper(description) LIKE '%WORK%STATION%'
OR upper(description) LIKE '% X%RAY%'
OR upper(description) LIKE '%ZAMBONI%'

-- Systems
OR upper(description) LIKE '%ADDRESS%SYST%'
OR upper(description) LIKE '%ADMIN%SYS%'
OR upper(description) LIKE '%ASSET%SYS%'
OR upper(description) LIKE '%ASSIGNMENT%SYST%'
OR upper(description) LIKE '%ALARM%SYST%'
OR upper(description) LIKE '%AUTOMATED%SYST%'
OR upper(description) LIKE '%BILLING%SYST%'
OR upper(description) LIKE '%BIOVAULT%SYST%'
OR upper(description) LIKE '%COMMUNICATION%SYST%'
OR upper(description) LIKE '%CRIME%SYST%'
OR upper(description) LIKE '%ENROLLMENT%SYS%'
OR upper(description) LIKE '%EQ %SYS%'
OR upper(description) LIKE '%FAST%PASS%SYS%'
OR upper(description) LIKE '%FILING%SYS%'
OR upper(description) LIKE '%FIN% SYS%'
OR upper(description) LIKE '%IMAGING%SYST%'
OR upper(description) LIKE '%INFO%SYST%'
OR upper(description) LIKE '%INGEST%SYST%'
OR upper(description) LIKE '%INTELL%SYST%'
OR upper(description) LIKE '%LAUNDRY%SYS%'
OR upper(description) LIKE '%LICENSING%SYS%'
OR upper(description) LIKE '%LOAD%SYS%'
OR upper(description) LIKE '%MANAGEMENT%SYST%'
OR upper(description) LIKE '%MEASUREMENT%SYST%'
OR upper(description) LIKE '%MED%SYST%'
OR upper(description) LIKE '%MEDIA%SYST%'
OR upper(description) LIKE '%PRESERVATION%SYST%'
OR upper(description) LIKE '%PREVENTION%SYST%'
OR upper(description) LIKE '%PROCESSING%SYST%'
OR upper(description) LIKE '%SECURITY%SYST%'
OR upper(description) LIKE '%SYSTEMWIDE%SYST%'
OR upper(description) LIKE '%TAX%SYST%'
OR upper(description) LIKE '%TICKET%SYST%'
OR upper(description) LIKE '%TRACKING%SYST%'
OR upper(description) LIKE '%WORKFORCE%SYST%'
)
AND( upper(description) NOT LIKE '%GARAGE%' );


--Group projects into the Lump Sum category
--managing agency: ALL
--SELECT * FROM cpdb_dcpattributes
UPDATE cpdb_dcpattributes SET typecategory = 'Lump Sum'
WHERE (
upper(description) LIKE '%LUMP SUM%'
OR upper(description) LIKE '% FUND%'
OR upper(description) LIKE 'FUND%'
OR upper(description) LIKE '%SURVEY%'
OR upper(description) LIKE '%SUPERVISION%'
OR upper(description) LIKE '%PROGRAM%'

--new
OR upper(description) LIKE '%10%YEAR%PLAN%'
OR upper(description) LIKE '%ACQUISITION%CITYWIDE%'
OR upper(description) LIKE '%AGENCY%PROPOSED%PROJECT%'
OR upper(description) LIKE '%AGREEMENT%'
OR upper(description) LIKE '%APPLICATION%'
OR upper(description) LIKE '%ASSESSMENT%'
OR upper(description) LIKE '%ASSOC%'
OR upper(description) LIKE '%AUDITOR%'
OR upper(description) LIKE '%AVIATION%'
OR upper(description) LIKE '%BIOSWALES%STORMWATER%'
OR upper(description) LIKE '%BPL%INFRASTRUCTURE%RECONSTRUCTION%'
OR upper(description) LIKE '%BUNDLE%PROJECTS%'
OR upper(description) LIKE '%CAPITAL%COMP%'
OR upper(description) LIKE '%CAMPAIGN%'
OR upper(description) LIKE '%CALTHOLIC%MANAGE%'
OR upper(description) LIKE '%CITY%WIDE%ACQUISITION%'
OR upper(description) LIKE '%CITY%WIDE%MANAGEMENT%'
OR upper(description) LIKE '%CITY%WIDE%MEASURES%'
OR upper(description) LIKE '%CITY%WIDE%SECURITY%'
OR upper(description) LIKE '%COACH%'
OR upper(description) LIKE '%COALITION%'
OR upper(description) LIKE '%COMB%'
OR upper(description) LIKE '%COMMITTEE%'
OR upper(description) LIKE '%COMPLIANCE%'
OR upper(description) LIKE '%COMPUTER%PROG%'
OR upper(description) LIKE '%CONTRACT%'
OR upper(description) LIKE '%CONSERVATION%'
OR upper(description) LIKE '%CONSULTANT%'
OR upper(description) LIKE '%CONTRACTS%'
OR upper(description) LIKE '%COOKING%PROJECT%'
OR upper(description) LIKE '%COOPERATIVE%'
OR upper(description) LIKE '%CORP%'
OR upper(description) LIKE '%COUNCIL%'
OR upper(description) LIKE '%DISTRIBUTION%FY%'
OR upper(description) LIKE '%ELLA%FY%'
OR upper(description) LIKE '%EMERGENCY%CONT%'
OR upper(description) LIKE '%EMERGENCY%SAFETY%SYSTEMS%'
OR upper(description) LIKE '%EXAMINATION%'
OR upper(description) LIKE '%FERRY%PROJECTS%'
OR upper(description) LIKE '%FUND'
OR upper(description) LIKE '%GENERAL%'
OR upper(description) LIKE '%HUD %'
OR upper(description) LIKE '%HOLD %'
OR upper(description) LIKE '% HOLD%'
OR upper(description) LIKE '%IFA %'
OR upper(description) LIKE '%IMPACT%STATEMENT%'
OR upper(description) LIKE '%IMPROVEMENT%CITYWIDE%'
OR upper(description) LIKE '% INC%'
OR upper(description) LIKE '%INITIATIVE%'
OR upper(description) LIKE '%INTITIATIVE%'
OR upper(description) LIKE '%INSPCTN%'
OR upper(description) LIKE '%INSPECTN%'
OR upper(description) LIKE '%INSPECTION%'
OR upper(description) LIKE '%INVESTIG%'
OR upper(description) LIKE '%JOB%ORDER%CONTRACT%'
OR upper(description) LIKE '% LLC%'
OR upper(description) LIKE '%LUMP%'
OR upper(description) LIKE '%MANAGEMENT%'
OR upper(description) LIKE '%MAINTENANCE%'
OR upper(description) LIKE '%MASTER%PLAN%'
OR upper(description) LIKE '%MGNT%SVCS%'
OR upper(description) LIKE '%MGNT%SVCES%'
OR upper(description) LIKE '%MISC %'
OR upper(description) LIKE '%MISC. %'
OR upper(description) LIKE '%MISCELANNOUES%'
OR upper(description) LIKE '%MITIGATION%PGM%'
OR upper(description) LIKE '%MITIGATION%PROGRAM%'
OR upper(description) LIKE '%MONITORING%'
OR upper(description) LIKE '%NATIONAL%ASSOC%'
OR upper(description) LIKE '%NEW%NEED%'
OR upper(description) LIKE '%OPPORTUNIT%'
OR upper(description) LIKE '%ORGANIZATION%'
OR upper(description) LIKE '%OVERSIGHT%'
OR upper(description) LIKE '%PARTNERSHIP%'
OR upper(description) LIKE '%PED%SAFETY%'
OR upper(description) LIKE '%PEDESTRIAN%SAFETY%'
OR upper(description) LIKE '%PEDESTRIAN%SYS%'
OR upper(description) LIKE '%PILOT%'
OR upper(description) LIKE '%PLANNED%PARENTHOOD%OF%NYC'
OR upper(description) LIKE '%PRIORITY%GRID%'
OR upper(description) LIKE '%PROCUREMENT%'
OR upper(description) LIKE '%PROFESSIONAL%SERVICE%'
OR upper(description) LIKE '%PROJECT%RENEWAL'
OR upper(description) LIKE '%PROG%'
OR upper(description) LIKE '%PROTECTION%CITYWIDE%'
OR upper(description) LIKE '%REIMBURSEMENT%'
OR upper(description) LIKE '%RESILIENCY%MEASURES%'
OR upper(description) LIKE '%RESOURCES%'
OR upper(description) LIKE '%REVITAL%PROJECT%'
OR upper(description) LIKE '%SAFE%COMMUNIT%'
OR upper(description) LIKE '%SAFE%ROUTE%SCHOOL%'
OR upper(description) LIKE '%SAFE%ROUTE%TO %'
OR upper(description) LIKE '%SAFETY%IMPROVEMENT%'
OR upper(description) LIKE '%SAFETY%PROJECT%'
OR upper(description) LIKE '%SAMPLING%'
OR upper(description) LIKE 'SCA%'
OR upper(description) LIKE '%SE%&%WM%'
OR upper(description) LIKE '%SEEDING%'
OR upper(description) LIKE '%SERVICE%'
OR upper(description) LIKE '%SERVICE%AGREEMENT%'
OR upper(description) LIKE '%SEWER%WATER%'
OR upper(description) LIKE '%SEWER%WM%'
OR upper(description) LIKE '%SOCIETY%'
OR upper(description) LIKE '%STAFF%'
OR upper(description) LIKE '%STORM%WM%'
OR upper(description) LIKE '%STORM%WATER%MANAGEMENT%'
OR upper(description) LIKE '%STORM%WATER%MGMT%'
OR upper(description) LIKE '%STRATEGIC%PLAN%'
OR upper(description) LIKE '%STUDIES%'
OR upper(description) LIKE '%SUPPORT%'
OR upper(description) LIKE '%SURPLUS%'
OR upper(description) LIKE '%SWER%WM%'
OR upper(description) LIKE '%SWR%WM%'
OR upper(description) LIKE '%SWR%W/M%'
OR upper(description) LIKE '%SYSTEMWIDE%RENO%NEW%EXPAN%'
OR upper(description) LIKE '%TASK%ORDER%'
OR upper(description) LIKE '%TEN%YEAR%PLAN%'
OR upper(description) LIKE '%TESTING%'
OR upper(description) LIKE '%TORTS%'
OR upper(description) LIKE '%TREES%'	
OR upper(description) LIKE '%ULURP%'
OR upper(description) LIKE '%VARIOUS%LOCATIONS%'
OR upper(description) LIKE '%VARIOUS%WORK%'
OR upper(description) LIKE '%VISION%ZERO%'
OR upper(description) LIKE '%VOLUNTEERS%'
OR upper(description) LIKE '%W/M%SEWER%'
OR upper(description) LIKE '%W/M%SWR%'
OR upper(description) LIKE '%WATER%MAIN%SEWER%'
OR upper(description) LIKE '%WM%SEWER%'
OR upper(description) LIKE '%WM%SWR%'

)
AND( upper(description) NOT LIKE '%SPACE%')
AND( upper(description) NOT LIKE '%RESTOR%' )
AND typecategory IS NULL;

--Group projects into the Fixed Asset category
--managing agency: ALL
--SELECT * FROM cpdb_dcpattributes
UPDATE cpdb_dcpattributes SET typecategory = 'Fixed Asset'
WHERE (
upper(description) LIKE '%AUDITORIUM%'
OR upper(description) LIKE '%BASIN%'
OR upper(description) LIKE '%BATHROOM%'
OR upper(description) LIKE '%BOILER%'
OR upper(description) LIKE '%BORING%'
OR upper(description) LIKE '%BLVD%'
OR upper(description) LIKE '%BRIDGE%'
OR upper(description) LIKE '%BUILDING%'
OR upper(description) LIKE '%BULKHEAD%'
OR upper(description) LIKE '%CAFETERIA%'
OR upper(description) LIKE '%CANAL%'
OR upper(description) LIKE '%CEILING%'
OR upper(description) LIKE '%CENTER%'
OR upper(description) LIKE '%CLIMATE%'
OR upper(description) LIKE '%CONSTRUCTION%'
OR upper(description) LIKE '%COOLING%'
OR upper(description) LIKE '%CULVERT%'
OR upper(description) LIKE '%DAY CARE%'
OR upper(description) LIKE '%DEPOT%'
OR upper(description) LIKE '%ELECTRICAL%'
OR upper(description) LIKE '%ELEVATOR%'
OR upper(description) LIKE '%ESCALATOR%'
OR upper(description) LIKE '%EXTERIOR%'
OR upper(description) LIKE '%FACILITY%'
OR upper(description) LIKE '%FENC%'
OR upper(description) LIKE '%FIELD%'
OR upper(description) LIKE '%FIXTURE%'
OR upper(description) LIKE '%FLOOR%'
OR upper(description) LIKE '%GARAGE%'
OR upper(description) LIKE '%GARDEN%'
OR upper(description) LIKE '%GREENWAY%'
OR upper(description) LIKE '%GYM%'
OR upper(description) LIKE '%HALL%'
OR upper(description) LIKE '%HEATING%'
OR upper(description) LIKE '%HOSPITAL%'
OR upper(description) LIKE '%HOUSE%'
OR upper(description) LIKE '%HVAC%'
OR upper(description) LIKE '%INTERIOR%'
OR upper(description) LIKE '%KITCHEN%'
OR upper(description) LIKE '%LAB%'
OR upper(description) LIKE '%LANDING%'
OR upper(description) LIKE '%LIBRARY%'
OR upper(description) LIKE '%LIGHTING%'
OR upper(description) LIKE '%MASONRY%'
OR upper(description) LIKE '%MILLING%'
OR upper(description) LIKE '%MTS%'
OR upper(description) LIKE '%MUSEUM%'
OR upper(description) LIKE '%PARAPET%'
OR upper(description) LIKE '%PARK%'
OR upper(description) LIKE '%PIER%'
OR upper(description) LIKE '%PIPE%'
OR upper(description) LIKE '%PIPING%'
OR upper(description) LIKE '%PLANT%'
OR upper(description) LIKE '%PLAYGROUND%'
OR upper(description) LIKE '%PLAZA%'
OR upper(description) LIKE '%POOL%'
OR upper(description) LIKE '%RAMP%'
OR upper(description) LIKE '%RECON%'
OR upper(description) LIKE '%REHAB%'
OR upper(description) LIKE '%RENOVAT%'
OR upper(description) LIKE '%REPLACE%'
OR upper(description) LIKE '%RESTORATION%'
OR upper(description) LIKE '%ROOF%'
OR upper(description) LIKE '%ROOM%'
OR upper(description) LIKE '%SEWER%'
OR upper(description) LIKE '%SHELTER%'
OR upper(description) LIKE '%SIDEWALK%'
OR upper(description) LIKE '%SITE ACQ%'
OR upper(description) LIKE '%SPRAY%BOOTH%'
OR upper(description) LIKE '%STADIUM%'
OR upper(description) LIKE '%STATION%'
OR upper(description) LIKE '%STREET%'
OR upper(description) LIKE '%TERMINAL%'
OR upper(description) LIKE '%THEATER%'
OR upper(description) LIKE '%TOILET%'
OR upper(description) LIKE '%TUNNEL%'
OR upper(description) LIKE '%VENTILATION%'
OR upper(description) LIKE '%WASTE%'
OR upper(description) LIKE '%WINDOW%'
OR upper(description) LIKE '%WPC%'
OR upper(description) LIKE '%WWTP%'

--new
OR upper(description) LIKE '%A/C%'
OR upper(description) LIKE '%ACQ%'
OR upper(description) LIKE '%ACQUISITION%'
OR upper(description) LIKE '%AERATION%'
OR upper(description) LIKE '%ADA%'
OR upper(description) LIKE '%ADDITION%'
OR upper(description) LIKE '%AIR%BOX%'
OR upper(description) LIKE '%AIR%CON%'
OR upper(description) LIKE '%ALARM%BOX%'
OR upper(description) LIKE '%ANNEX%'
OR upper(description) LIKE '%ARENA%'
OR upper(description) LIKE '%ART%'
OR upper(description) LIKE '%ASBESTOS%'
OR upper(description) LIKE '%ASPHALT%'
OR upper(description) LIKE '%ATRIUM%'
OR upper(description) LIKE '%ATC%'
OR upper(description) LIKE '%AQUARIUM%'
OR upper(description) LIKE '%BACKFLOW%SYS%'
OR upper(description) LIKE '%BARRIER%'
OR upper(description) LIKE '%BOAT%LAUNCH%'
OR upper(description) LIKE '%BIKEWAY%'
OR upper(description) LIKE '%BIN%'
OR upper(description) LIKE '%BIOSWALE%'
OR upper(description) LIKE '%BLDG%'
OR upper(description) LIKE '%BLDG%ACQ%'
OR upper(description) LIKE '%BLUEBELT%'
OR upper(description) LIKE '%BOARDWALK%'
OR upper(description) LIKE '%BURNER%'
OR upper(description) LIKE '%CABLING%'
OR upper(description) LIKE '%CALL%BOX%'
OR upper(description) LIKE '%CAMPUS%'
OR upper(description) LIKE '%CAR%PORT%'
OR upper(description) LIKE '%CATWALK%'
OR upper(description) LIKE '%CEMETERY%'
OR upper(description) LIKE '%CHAMBER%'
OR upper(description) LIKE '%CHILLER%'
OR upper(description) LIKE '%CLINIC%'
OR upper(description) LIKE '%COMFORT%ST%'
OR upper(description) LIKE '%COMPACTOR%'
OR upper(description) LIKE '%COMPUTER%LAB%'
OR upper(description) LIKE '%COMPUTER%ROOM%'
OR upper(description) LIKE '%CONDUIT%'
OR upper(description) LIKE '%CONSOLIDATION%'
OR upper(description) LIKE '%CONSTRUCT%'
OR upper(description) LIKE '%CONVERSION%'
OR upper(description) LIKE '%CORRIDOR%'
OR upper(description) LIKE '%COURT%'
OR upper(description) LIKE '% CTS %'
OR upper(description) LIKE 'CTS %'
OR upper(description) LIKE '% CTS'
OR upper(description) LIKE '%CSO%'
OR upper(description) LIKE '%DAM%'
OR upper(description) LIKE '%DEMOLITION%'
OR upper(description) LIKE '%DEVELOPMENT%'
OR upper(description) LIKE '%DIGESTER%'
OR upper(description) LIKE '%DIMMER%SYST%'
OR upper(description) LIKE '%DOCK%'
OR upper(description) LIKE '%DOG%RUN%'
OR upper(description) LIKE '%DOOR%'
OR upper(description) LIKE '%DORM%'
OR upper(description) LIKE '%DUCT%'
OR upper(description) LIKE '%EE%UPGRADE%'
OR upper(description) LIKE '%EJECTOR%'
OR upper(description) LIKE '%ELECTRIC%SYS%'
OR upper(description) LIKE '%ELEC%UPGRADE%'
OR upper(description) LIKE '%ENCLOS%'
OR upper(description) LIKE '%ENERGY%UPGRADE%'
OR upper(description) LIKE '%ENTRANCE%'
OR upper(description) LIKE '%ENTRY'
OR upper(description) LIKE '%ESPLANADE%'
OR upper(description) LIKE '%EXHAUST%SYSTEM%'
OR upper(description) LIKE '%EXHIBIT%'
OR upper(description) LIKE '%EXPANSION%'
OR upper(description) LIKE '%EXTENSION%'
OR upper(description) LIKE '%FACADE%'
OR upper(description) LIKE '%FACILIT%'
OR upper(description) LIKE '%FIRE%ALAR%'
OR upper(description) LIKE '%FIRE%SAFETY%'
OR upper(description) LIKE '%FIRE%SYSTEM%'
OR upper(description) LIKE '%FIRE%UPGRADE%'
OR upper(description) LIKE '%FLAG%'
OR upper(description) LIKE '%FOUNTAIN%'
OR upper(description) LIKE '%GALLERY%'
OR upper(description) LIKE '%GAS%'
OR upper(description) LIKE '%GATE%'
OR upper(description) LIKE '%GOLF%COURSE%'
OR upper(description) LIKE '%GOVERNORS%ISLAND%'
OR upper(description) LIKE '% GRAT%'
OR upper(description) LIKE '%GUARDS%'
OR upper(description) LIKE '%HEAT%'
OR upper(description) LIKE '%HIGH%LINE%'
OR upper(description) LIKE '%HOT%WATER%'
OR upper(description) LIKE '%INFRASTRUCTURE%'
OR upper(description) LIKE '%INSTALLATION%'
OR upper(description) LIKE '%INTERCONNECTION%'
OR upper(description) LIKE '%IRRIGATION%'
OR upper(description) LIKE '%LAMP%'
OR upper(description) LIKE '%LAWNS%'
OR upper(description) LIKE '%LEASE%RENEW%'
OR upper(description) LIKE '%LIGHTS%'
OR upper(description) LIKE '%LIGHTPOLE%'
OR upper(description) LIKE '%LOCAL%LAW%11%'
OR upper(description) LIKE '%LOUNGE%'
OR upper(description) LIKE '%MARINA%'
OR upper(description) LIKE '%MEDIAN%'
OR upper(description) LIKE '%MICROFILTRATION%'
OR upper(description) LIKE '%MODERNIZATION%'
OR upper(description) LIKE '% MOVE %'
OR upper(description) LIKE '%NEW%BRANCH%'
OR upper(description) LIKE 'NDF%'
OR upper(description) LIKE '%OBSERVATORY%'
OR upper(description) LIKE '%OFFICES%'
OR upper(description) LIKE '%OUTDOOR%SPACE%'
OR upper(description) LIKE '%OUTFITTIN%'
OR upper(description) LIKE '%OUT-FITTIN%'
OR upper(description) LIKE '%OVERPASS%'
OR upper(description) LIKE '%PASSIVE%LANDSCAPE%'
OR upper(description) LIKE '%PATH%'
OR upper(description) LIKE '%PAVEMENT%'
OR upper(description) LIKE '% PEN %'
OR upper(description) LIKE '%PEDESTALS%'
OR upper(description) LIKE '%PLDG%'
OR upper(description) LIKE '%PLGD%'
OR upper(description) LIKE '%PLGRD%'
OR upper(description) LIKE '%PLYG%'
OR upper(description) LIKE '%PRINTSHOP%'
OR upper(description) LIKE '%PROMENADE%'
OR upper(description) LIKE '%PUMP%'
OR upper(description) LIKE '%PV PANELS%'
OR upper(description) LIKE '%REFURB%'
OR upper(description) LIKE '%RELOCAT%'
OR upper(description) LIKE '%REMOVAL%'
OR upper(description) LIKE '%RENO%'
OR upper(description) LIKE '%REPAIR%SHOP%'
OR upper(description) LIKE '%REP% WM %'
OR upper(description) LIKE '%RESTITUTION%'
OR upper(description) LIKE '%RESURFACING%'
OR upper(description) LIKE '%RETAINING%WALL%'
OR upper(description) LIKE '%RETRO%FIT%'
OR upper(description) LIKE '%RIDING%RING%'
OR upper(description) LIKE '%RINK%'
OR upper(description) LIKE '%RD%IMPROVEMENT%'
OR upper(description) LIKE '%ROAD%IMPROVEMENT%'
OR upper(description) LIKE '%ROAD%WIDE%'
OR upper(description) LIKE '%ROPE%'
OR upper(description) LIKE '%SCHOOLYARDS%'
OR upper(description) LIKE '%SBS %'
OR upper(description) LIKE '% SBS%'
OR upper(description) LIKE '%SEAT %'
OR upper(description) LIKE '%SEATING%'
OR upper(description) LIKE '%SECURITY%INSTALL%'
OR upper(description) LIKE '%SECURITY%SYS%'
OR upper(description) LIKE '%SECURITY%UPG%'
OR upper(description) LIKE '%SHAFT%'
OR upper(description) LIKE '%SHED%'
OR upper(description) LIKE '%SHORELINE%'
OR upper(description) LIKE '%SHOWER%'
OR upper(description) LIKE '%SIGN%'
OR upper(description) LIKE '%SKATE P%'
OR upper(description) LIKE '%SKYLIGHT%'
OR upper(description) LIKE '%SMOKE%SYSTEM%'
OR upper(description) LIKE '%SOLAR%PHOTO%'
OR upper(description) LIKE '%SOLAR%PV%'
OR upper(description) LIKE '%SPACE%'
OR upper(description) LIKE '%SOCCER%'
OR upper(description) LIKE '%SPORT%AREA%'
OR upper(description) LIKE '%SPORT%COMPLEX%'
OR upper(description) LIKE '%SPACE%IMPRO%'
OR upper(description) LIKE '%SPRINKLER%'
OR upper(description) LIKE '%STABILIZATION%'
OR upper(description) LIKE '%STAGE%'
OR upper(description) LIKE '%STAIR%'
OR upper(description) LIKE '%STAIRCASE%'
OR upper(description) LIKE '%STEAM%'
OR upper(description) LIKE '%STM%SWR%'
OR upper(description) LIKE '%STORM%SWR%'
OR upper(description) LIKE '%STORAGE%'
OR upper(description) LIKE '%STRM%SWR%'
OR upper(description) LIKE '%STRUCTURE%'
OR upper(description) LIKE '%STUDIO%'
OR upper(description) LIKE '%SWING%'
OR upper(description) LIKE '%SWR%'
OR upper(description) LIKE '%TANK%'
OR upper(description) LIKE '%TOW%POUND%'
OR upper(description) LIKE '%TOWER%'
OR upper(description) LIKE '%TRAIL%'
OR upper(description) LIKE '%TRNG%RM%'
OR upper(description) LIKE '%TRUNK%'
OR upper(description) LIKE '%TURNSTILE%'
OR upper(description) LIKE '%UNDERGROUND%'
OR upper(description) LIKE '%UNDERPASS%'
OR upper(description) LIKE '%VALVE%'
OR upper(description) LIKE '% WALL%'
OR upper(description) LIKE '%WAREHOUSE%'
OR upper(description) LIKE '%WATER%MAIN%'
OR upper(description) LIKE '%WATER%TOWER%'
OR upper(description) LIKE '%WAYFINDING%'
OR upper(description) LIKE '%WEIR%'
OR upper(description) LIKE '%WETLAND%'
OR upper(description) LIKE '%WIDENING%'
OR upper(description) LIKE '%WIER%'
OR upper(description) LIKE '%WING%'
OR upper(description) LIKE '%WORKSPACE%'
OR upper(description) LIKE '% WMS %'
OR upper(description) LIKE '%WM%REPL%'
OR upper(description) LIKE '%YACHT%CLUB%'
OR upper(description) LIKE '%YARD%'
OR upper(description) LIKE '%YMCA%'
OR upper(description) LIKE '%YWHA%'
OR upper(description) LIKE '%ZOO%'
)
AND typecategory IS NULL;

--DPR specific
UPDATE cpdb_dcpattributes SET typecategory = 'Fixed Asset'
WHERE description ~ '[BMQRX][0-9][0-9][0-9]' AND magencyacro = 'DPR'
AND typecategory IS NULL;




--EVERYTHING BELOW IS DRAFT
--working
--SELECT a.maprojid, b.magencyacro, a.description, a.category FROM dcpattributestaging a
--LEFT JOIN projectstaging b
--ON a.maprojid=b.maprojid
--ORDER BY b.magencyacro, a.description
--
-- working
--WITH categorized AS ( SELECT * FROM projectstaging
--WHERE
--upper(description) LIKE '%VEHICLE%'
--OR upper(description) LIKE '%TRUCK%'
--OR upper(description) LIKE '% IT %'
--OR upper(description) LIKE '%TELECOMMUNICATION%'
--OR upper(description) LIKE '%SERVER%'
--OR upper(description) LIKE '%COMPUTERS%'
--OR upper(description) LIKE '%TELEPHONE%'
--OR upper(description) LIKE '%EQUIPMENT%'
--OR upper(description) LIKE '%FURNITURE%'
--OR upper(description) LIKE '%CAMERA%'
--OR upper(description) LIKE '%MOBILE%'
--OR upper(description) LIKE '%LUMP SUM%'
--OR upper(description) LIKE '%FUND%'
--OR upper(description) LIKE '%SURVEY%'
--OR upper(description) LIKE '%SUPERVISION%'
--OR upper(description) LIKE '%PROGRAM%'
--OR upper(description) LIKE '%AUDITORIUM%'
--OR upper(description) LIKE '%BATHROOM%'
--OR upper(description) LIKE '%BOILER%'
--OR upper(description) LIKE '%BRIDGE%'
--OR upper(description) LIKE '%CAFETERIA%'
--OR upper(description) LIKE '%CEILING%'
--OR upper(description) LIKE '%CLIMATE%'
--OR upper(description) LIKE '%COOLING%'
--OR upper(description) LIKE '%DEPOT%'
--OR upper(description) LIKE '%ELECTRICAL%'
--OR upper(description) LIKE '%ELEVATOR%'
--OR upper(description) LIKE '%ESCALATOR%'
--OR upper(description) LIKE '%EXTERIOR%'
--OR upper(description) LIKE '%FACILIT%'
--OR upper(description) LIKE '%FENC%'
--OR upper(description) LIKE '%FIELD%'
--OR upper(description) LIKE '%FIXTURE%'
--OR upper(description) LIKE '%FLOOR%'
--OR upper(description) LIKE '%GARAGE%'
--OR upper(description) LIKE '%GARDEN%'
--OR upper(description) LIKE '%GYM%'
--OR upper(description) LIKE '%HEATING%'
--OR upper(description) LIKE '%HOUSE%'
--OR upper(description) LIKE '%HVAC%'
--OR upper(description) LIKE '%INTERIOR%'
--OR upper(description) LIKE '%KITCHEN%'
--OR upper(description) LIKE '%LAB%'
--OR upper(description) LIKE '%LANDING%'
--OR upper(description) LIKE '%LIBRARY%'
--OR upper(description) LIKE '%LIGHTING%'
--OR upper(description) LIKE '%MASONRY%'
--OR upper(description) LIKE '%MTS%'
--OR upper(description) LIKE '%PARAPET%'
--OR upper(description) LIKE '%PARK%'
--OR upper(description) LIKE '%PIER%'
--OR upper(description) LIKE '%PIPE%'
--OR upper(description) LIKE '%PIPING%'
--OR upper(description) LIKE '%PLANT%'
--OR upper(description) LIKE '%PLAYGROUND%'
--OR upper(description) LIKE '%PLAZA%'
--OR upper(description) LIKE '%POOL%'
--OR upper(description) LIKE '%RENOVATION%'
--OR upper(description) LIKE '%ROOF%'
--OR upper(description) LIKE '%ROOM%'
--OR upper(description) LIKE '%STATION%'
--OR upper(description) LIKE '%TERMINAL%'
--OR upper(description) LIKE '%TOILET%'
--OR upper(description) LIKE '%VENTILATION%'
--OR upper(description) LIKE '%WASTE%'
--OR upper(description) LIKE '%WINDOW%'
--OR upper(description) LIKE '%DOITT%'
--OR upper(description) LIKE '%WIFI%'
--OR upper(description) LIKE '%GIS %'
--OR upper(description) LIKE '%HOSPITAL%'----------------------------------------------------------
--)

--SELECT * FROM projectstaging a WHERE a.maprojid NOT IN (SELECT b.maprojid FROM categorized b)


--Meeting on OneNYC metric
--next reprot is three weeks away
--structure measures city has some control over - hosuing density and commercial 
--vote: 1) not report by explaining that data hasen't changed 2) rerun including Q

--ssh adoyle@gw.cusp.nyu.edu -L 8000:compute.cusp.nyu.edu:8000

--Confirmed
--2 session
--confirm session dates
--Three instructors are coteaching
--Where should the students go?
--10 groups will go to 10 different sites
--send groups to decion makers 
--city councl distruct staff and invite con








