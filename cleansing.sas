libname Mylib '/folders/myfolders/Lab03/';
data Mylib.TPCWcustomer;
infile '/folders/myfolders/Lab03/TPCWcustomer.csv' dsd delimiter=';' firstobs=2;
format customerID best12.;
format name $50.;
format addr2 $50.;
format city $35.;
format state $35.;
format zip $5.;
format typeName $15.;
input customerID name $ addr2 $ city $ state $ zip $ typeName $;
run;
data Mylib.TPCWcustomer;
	set Mylib.TPCWcustomer;
	format addr1 $25.;
	addr1 = '';
run;
data Mylib.TPCWcustomer;
	retain customerID name addr1 addr2 city state zip typeName;
	set Mylib.TPCWcustomer;
run;
data Mylib.TPCWcustomer;
	modify Mylib.TPCWcustomer;
	
	if scan(name,-1,' ') = 'Corp' then
		name = tranwrd(name,'Corp','Corporation');
	if scan(name,-1,' ') = 'Corp.' then
		name = tranwrd(name,'Corp.','Corporation');
		
	if scan(name,-1,' ') = 'Inc' then
		name = tranwrd(name,'Inc','Incorporated');
	if scan(name,-1,' ') = 'Inc.' then
		name = tranwrd(name,'Inc.','Incorporated');
		
	if scan(name,-1,' ') = 'Co' then
		name = tranwrd(name,'Co','Company');
	if scan(name,-1,' ') = 'Co.' then
		name = tranwrd(name,'Co.','Company');
	
	if (typeName = 'Comm' or typeName = 'COMMERCIAL') 
		then typeName = 'Commercial';
	if (typeName = 'State' or typeName = 'STATELOCALGOVT') 
		then typeName = 'State_Local Gov';
	if (typeName = 'Edu' or typeName = 'EDUCATION') 
		then typeName = 'Education';
	if (typeName = 'Govt' or typeName = 'USGOVT') 
		then typeName = 'US Govt';
		
	if (index(addr2,'Suite') > 0) or (index(addr2,'Dept') > 0) then do;
	addr1 = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ');
	addr2 = tranwrd(addr2,trim(addr1),"");
	addr2 = strip(addr2);
	end;
	
	if (index(addr2,'P.O. Box') > 0) then do;
	temp = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ') || 
		' ' || scan(addr2,3,' ');
	addr1 = substr(temp, 1, length(temp)-1);
	addr2 = tranwrd(addr2,trim(temp),"");
	addr2 = strip(addr2);
	end;
	
	if (index(addr2, 'Rd.') > 0) then
		addr2 = tranwrd(addr2, 'Rd.', "Road");
	if (index(addr2, 'St.') > 0) then
		addr2 = tranwrd(addr2, 'St.', "Street");
	if scan(addr2,-1,' ') = 'Dr' then
		addr2 = tranwrd(addr2,'Dr','Drive');
	if scan(addr2,-1,' ') = 'Dr.' then
		addr2 = tranwrd(addr2,'Dr.','Drive');
	if (index(addr2, 'Ave.') > 0) then
		addr2 = tranwrd(addr2, 'Ave.', "Avenue");
	if (index(addr2, 'Av.') > 0) then
		addr2 = tranwrd(addr2, 'Av.', "Avenue");
	if substr(addr2,length(addr2)-2,length(addr2)) = 'Ave' then
		addr2 = tranwrd(addr2, 'Ave', "Avenue");
	
	addr2 = tranwrd(addr2,'.','');
	addr2 = tranwrd(addr2,',','');
	
	if length(zip) = 4 then
		zip = zip || '0';
	
	if length(state) = 2 then state = upcase(state);
	if state = 'AL' then state = 'Alabama';
	if state = 'AK' then state = 'Alaska';
	if state = 'AZ' then state = 'Arizona';
	if state = 'AR' then state = 'Arkansas';
	if state = 'CA' then state = 'California';
	if state = 'CO' then state = 'Colorado';
	if state = 'CT' then state = 'Connecticut';
	if state = 'DE' then state = 'Delaware';
	if state = 'FL' then state = 'Florida';
	if state = 'GA' then state = 'Georgia';
	if state = 'HI' then state = 'Hawaii';
	if state = 'ID' then state = 'Idaho';
	if state = 'IL' then state = 'Illinois';
	if state = 'IN' then state = 'Indiana';
	if state = 'IA' then state = 'Iowa';
	if state = 'KS' then state = 'Kansas';
	if state = 'KY' then state = 'Kentucky';
	if state = 'LA' then state = 'Louisiana';
	if state = 'ME' then state = 'Maine';
	if state = 'MD' then state = 'Maryland';
	if state = 'MA' then state = 'Massachusetts';
	if state = 'MI' then state = 'Michigan';
	if state = 'MN' then state = 'Minnesota';
	if state = 'MS' then state = 'Mississippi';
	if state = 'MO' then state = 'Missouri';
	if state = 'MT' then state = 'Montana';
	if state = 'NE' then state = 'Nebraska';
	if state = 'NV' then state = 'Nevada';
	if state = 'NH' then state = 'New Hampshire';
	if state = 'NJ' then state = 'New Jersey';
	if state = 'NM' then state = 'New Mexico';
	if state = 'NY' then state = 'New York';
	if state = 'NC' then state = 'North Carolina';
	if state = 'ND' then state = 'North Dakota';
	if state = 'OH' then state = 'Ohio';
	if state = 'OK' then state = 'Oklahoma';
	if state = 'OR' then state = 'Oregon';
	if state = 'PA' then state = 'Pennsylvania';
	if state = 'RI' then state = 'Rhode Island';
	if state = 'SC' then state = 'South Carolina';
	if state = 'SD' then state = 'South Dakota';
	if state = 'TN' then state = 'Tennessee';
	if state = 'TX' then state = 'Texas';
	if state = 'UT' then state = 'Utah';
	if state = 'VT' then state = 'Vermont';
	if state = 'VA' then state = 'Virginia';
	if state = 'WA' then state = 'Washington';
	if state = 'WV' then state = 'West Virginia';
	if state = 'WI' then state = 'Wisconsin';
	if state = 'WY' then state = 'Wyoming';
	if state = 'DC' then state = 'District of Columbia';
	if state = 'PR' then state = 'Puerto Rico';
run;

proc sort data = Mylib.TPCWcustomer nodupkey;
	by customerID;
run;

proc export data=Mylib.TPCWcustomer outfile = '/folders/myfolders/Lab03/TPCWcustomer_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.TPCWcustomer;
	set Mylib.TPCWcustomer;
	rename customerID = customerIDTPCW_NK;
run;

data Mylib.TPCWcustomer;
	retain customerIDTPCW_NK name addr1 addr2
		city state zip typeName;
	set Mylib.TPCWcustomer;
run;

proc sort data = Mylib.TPCWcustomer;
	by name city state typeName;
run;

data Mylib.PECcustomer;
infile '/folders/myfolders/Lab03/PECcustomer.csv' dsd delimiter=';' firstobs=2;
format customerID best12.;
format name $40.;
format addr2 $50.;
format city $35.;
format state $35.;
format zip $5.;
format typeName $15.;
input customerID name $ addr2 $ city $ state $ zip $ typeName $;
run;
data Mylib.PECcustomer;
	set Mylib.PECcustomer;
	format addr1 $25.;
	addr1 = '';
run;
data Mylib.PECcustomer;
	retain customerID name addr1 addr2 city state zip typeName;
	set Mylib.PECcustomer;
run;
data Mylib.PECcustomer;
	modify Mylib.PECcustomer;
	
	if scan(name,-1,' ') = 'Corp' then
		name = tranwrd(name,'Corp','Corporation');
	if scan(name,-1,' ') = 'Corp.' then
		name = tranwrd(name,'Corp.','Corporation');
		
	if scan(name,-1,' ') = 'Inc' then
		name = tranwrd(name,'Inc','Incorporated');
	if scan(name,-1,' ') = 'Inc.' then
		name = tranwrd(name,'Inc.','Incorporated');
		
	if scan(name,-1,' ') = 'Co' then
		name = tranwrd(name,'Co','Company');
	if scan(name,-1,' ') = 'Co.' then
		name = tranwrd(name,'Co.','Company');
	
	if (typeName = 'Comm' or typeName = 'COMMERCIAL') 
		then typeName = 'Commercial';
	if (typeName = 'State' or typeName = 'STATELOCALGOVT') 
		then typeName = 'State_Local Gov';
	if (typeName = 'Edu' or typeName = 'EDUCATION') 
		then typeName = 'Education';
	if (typeName = 'Govt' or typeName = 'USGOVT') 
		then typeName = 'US Govt';
		
	if (index(addr2,'Suite') > 0) or (index(addr2,'Dept') > 0) then do;
		addr1 = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ');
		addr2 = tranwrd(addr2,trim(addr1),"");
		addr2 = strip(addr2);
	end;
	
	if (index(addr2,'P.O. Box') > 0) then do;
		temp = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ') || 
			' ' || scan(addr2,3,' ');
		addr1 = substr(temp, 1, length(temp)-1);
		addr2 = tranwrd(addr2,trim(temp),"");
		addr2 = strip(addr2);
	end;
	
	if (index(addr2, 'Rd.') > 0) then
		addr2 = tranwrd(addr2, 'Rd.', "Road");
	if (index(addr2, 'St.') > 0) then
		addr2 = tranwrd(addr2, 'St.', "Street");
	if scan(addr2,-1,' ') = 'Dr' then
		addr2 = tranwrd(addr2,'Dr','Drive');
	if scan(addr2,-1,' ') = 'Dr.' then
		addr2 = tranwrd(addr2,'Dr.','Drive');
	if (index(addr2, 'Ave.') > 0) then
		addr2 = tranwrd(addr2, 'Ave.', "Avenue");
	if (index(addr2, 'Av.') > 0) then
		addr2 = tranwrd(addr2, 'Av.', "Avenue");
	if substr(addr2,length(addr2)-2,length(addr2)) = 'Ave' then
		addr2 = tranwrd(addr2, 'Ave', "Avenue");
		
	addr2 = tranwrd(addr2,'.','');
	addr2 = tranwrd(addr2,',','');
		
	if length(zip) = 4 then
		zip = zip || '0';
	
	if length(state) = 2 then state = upcase(state);
	if state = 'AL' then state = 'Alabama';
	if state = 'AK' then state = 'Alaska';
	if state = 'AZ' then state = 'Arizona';
	if state = 'AR' then state = 'Arkansas';
	if state = 'CA' then state = 'California';
	if state = 'CO' then state = 'Colorado';
	if state = 'CT' then state = 'Connecticut';
	if state = 'DE' then state = 'Delaware';
	if state = 'FL' then state = 'Florida';
	if state = 'GA' then state = 'Georgia';
	if state = 'HI' then state = 'Hawaii';
	if state = 'ID' then state = 'Idaho';
	if state = 'IL' then state = 'Illinois';
	if state = 'IN' then state = 'Indiana';
	if state = 'IA' then state = 'Iowa';
	if state = 'KS' then state = 'Kansas';
	if state = 'KY' then state = 'Kentucky';
	if state = 'LA' then state = 'Louisiana';
	if state = 'ME' then state = 'Maine';
	if state = 'MD' then state = 'Maryland';
	if state = 'MA' then state = 'Massachusetts';
	if state = 'MI' then state = 'Michigan';
	if state = 'MN' then state = 'Minnesota';
	if state = 'MS' then state = 'Mississippi';
	if state = 'MO' then state = 'Missouri';
	if state = 'MT' then state = 'Montana';
	if state = 'NE' then state = 'Nebraska';
	if state = 'NV' then state = 'Nevada';
	if state = 'NH' then state = 'New Hampshire';
	if state = 'NJ' then state = 'New Jersey';
	if state = 'NM' then state = 'New Mexico';
	if state = 'NY' then state = 'New York';
	if state = 'NC' then state = 'North Carolina';
	if state = 'ND' then state = 'North Dakota';
	if state = 'OH' then state = 'Ohio';
	if state = 'OK' then state = 'Oklahoma';
	if state = 'OR' then state = 'Oregon';
	if state = 'PA' then state = 'Pennsylvania';
	if state = 'RI' then state = 'Rhode Island';
	if state = 'SC' then state = 'South Carolina';
	if state = 'SD' then state = 'South Dakota';
	if state = 'TN' then state = 'Tennessee';
	if state = 'TX' then state = 'Texas';
	if state = 'UT' then state = 'Utah';
	if state = 'VT' then state = 'Vermont';
	if state = 'VA' then state = 'Virginia';
	if state = 'WA' then state = 'Washington';
	if state = 'WV' then state = 'West Virginia';
	if state = 'WI' then state = 'Wisconsin';
	if state = 'WY' then state = 'Wyoming';
	if state = 'DC' then state = 'District of Columbia';
	if state = 'PR' then state = 'Puerto Rico';
run;

proc sort data = Mylib.PECcustomer nodupkey;
	by customerID;
run;

proc export data=Mylib.PECcustomer outfile = '/folders/myfolders/Lab03/PECcustomer_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.PECcustomer;
	set Mylib.PECcustomer;
	rename customerID = customerIDPEC_NK;
run;

data Mylib.PECcustomer;
	retain customerIDPEC_NK name addr1 addr2
		city state zip typeName;
	set Mylib.PECcustomer;
run;

proc sort data = Mylib.PECcustomer;
	by name city state typeName;
run;

data Mylib.TPCEcustomer_original;
infile '/folders/myfolders/Lab03/customer.csv' dsd delimiter=';' firstobs=2;
format customerID best12.;
format name $40.;
format addr1 $25.;
format addr2 $50.;
format city $35.;
format state $35.;
format zip $5.;
format custtypeid $15.;
input customerID name $ addr1 $ addr2 $ city $ state $ zip $ custtypeid $;
run;
proc sort data=Mylib.TPCEcustomer_original;
	by custtypeid;
run;
data Mylib.TPCEcustomer_type;
infile '/folders/myfolders/Lab03/customer_type.csv' dsd delimiter=';' firstobs=2;
format custtypeID $1.;
format typeName $15.;
input custtypeid $ typeName $;
run;
proc sort data=Mylib.TPCEcustomer_type;
	by custtypeid;
run;
data Mylib.TPCEcustomer;
	merge Mylib.TPCEcustomer_original Mylib.TPCEcustomer_type;
	by custtypeid;
run;
data Mylib.TPCEcustomer;
	set Mylib.TPCEcustomer (drop = custtypeid);
run;
data Mylib.TPCEcustomer;
	retain customerID name addr1 addr2 city state zip typeName;
	set Mylib.TPCEcustomer;
run;
data Mylib.TPCEcustomer;
	modify Mylib.TPCEcustomer;
	
	if scan(name,-1,' ') = 'Corp' then
		name = tranwrd(name,'Corp','Corporation');
	if scan(name,-1,' ') = 'Corp.' then
		name = tranwrd(name,'Corp.','Corporation');
		
	if scan(name,-1,' ') = 'Inc' then
		name = tranwrd(name,'Inc','Incorporated');
	if scan(name,-1,' ') = 'Inc.' then
		name = tranwrd(name,'Inc.','Incorporated');
		
	if scan(name,-1,' ') = 'Co' then
		name = tranwrd(name,'Co','Company');
	if scan(name,-1,' ') = 'Co.' then
		name = tranwrd(name,'Co.','Company');
	
	if (typeName = 'Comm' or typeName = 'COMMERCIAL') 
		then typeName = 'Commercial';
	if (typeName = 'State' or typeName = 'STATELOCALGOVT') 
		then typeName = 'State_Local Gov';
	if (typeName = 'Edu' or typeName = 'EDUCATION') 
		then typeName = 'Education';
	if (typeName = 'Govt' or typeName = 'USGOVT') 
		then typeName = 'US Govt';
		
	if (index(addr2,'Suite') > 0) or (index(addr2,'Dept') > 0) then do;
	addr1 = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ');
	addr2 = tranwrd(addr2,trim(addr1),"");
	addr2 = strip(addr2);
	end;
	
	if (index(addr2,'P.O. Box') > 0) then do;
	temp = scan(addr2,1,' ') || ' ' || scan(addr2,2,' ') || 
		' ' || scan(addr2,3,' ');
	addr1 = substr(temp, 1, length(temp)-1);
	addr2 = tranwrd(addr2,trim(temp),"");
	addr2 = strip(addr2);
	end;
	
	if (index(addr2, 'Rd.') > 0) then
		addr2 = tranwrd(addr2, 'Rd.', "Road");
	if (index(addr2, 'St.') > 0) then
		addr2 = tranwrd(addr2, 'St.', "Street");
	if scan(addr2,-1,' ') = 'Dr' then
		addr2 = tranwrd(addr2,'Dr','Drive');
	if scan(addr2,-1,' ') = 'Dr.' then
		addr2 = tranwrd(addr2,'Dr.','Drive');
	if (index(addr2, 'Ave.') > 0) then
		addr2 = tranwrd(addr2, 'Ave.', "Avenue");
	if (index(addr2, 'Av.') > 0) then
		addr2 = tranwrd(addr2, 'Av.', "Avenue");
	if substr(addr2,length(addr2)-2,length(addr2)) = 'Ave' then
		addr2 = tranwrd(addr2, 'Ave', "Avenue");
	
	addr2 = tranwrd(addr2,'.','');
	addr2 = tranwrd(addr2,',','');
		
	if length(zip) = 4 then
		zip = zip || '0';
	
	if length(state) = 2 then state = upcase(state);
	if state = 'AL' then state = 'Alabama';
	if state = 'AK' then state = 'Alaska';
	if state = 'AZ' then state = 'Arizona';
	if state = 'AR' then state = 'Arkansas';
	if state = 'CA' then state = 'California';
	if state = 'CO' then state = 'Colorado';
	if state = 'CT' then state = 'Connecticut';
	if state = 'DE' then state = 'Delaware';
	if state = 'FL' then state = 'Florida';
	if state = 'GA' then state = 'Georgia';
	if state = 'HI' then state = 'Hawaii';
	if state = 'ID' then state = 'Idaho';
	if state = 'IL' then state = 'Illinois';
	if state = 'IN' then state = 'Indiana';
	if state = 'IA' then state = 'Iowa';
	if state = 'KS' then state = 'Kansas';
	if state = 'KY' then state = 'Kentucky';
	if state = 'LA' then state = 'Louisiana';
	if state = 'ME' then state = 'Maine';
	if state = 'MD' then state = 'Maryland';
	if state = 'MA' then state = 'Massachusetts';
	if state = 'MI' then state = 'Michigan';
	if state = 'MN' then state = 'Minnesota';
	if state = 'MS' then state = 'Mississippi';
	if state = 'MO' then state = 'Missouri';
	if state = 'MT' then state = 'Montana';
	if state = 'NE' then state = 'Nebraska';
	if state = 'NV' then state = 'Nevada';
	if state = 'NH' then state = 'New Hampshire';
	if state = 'NJ' then state = 'New Jersey';
	if state = 'NM' then state = 'New Mexico';
	if state = 'NY' then state = 'New York';
	if state = 'NC' then state = 'North Carolina';
	if state = 'ND' then state = 'North Dakota';
	if state = 'OH' then state = 'Ohio';
	if state = 'OK' then state = 'Oklahoma';
	if state = 'OR' then state = 'Oregon';
	if state = 'PA' then state = 'Pennsylvania';
	if state = 'RI' then state = 'Rhode Island';
	if state = 'SC' then state = 'South Carolina';
	if state = 'SD' then state = 'South Dakota';
	if state = 'TN' then state = 'Tennessee';
	if state = 'TX' then state = 'Texas';
	if state = 'UT' then state = 'Utah';
	if state = 'VT' then state = 'Vermont';
	if state = 'VA' then state = 'Virginia';
	if state = 'WA' then state = 'Washington';
	if state = 'WV' then state = 'West Virginia';
	if state = 'WI' then state = 'Wisconsin';
	if state = 'WY' then state = 'Wyoming';
	if state = 'DC' then state = 'District of Columbia';
	if state = 'PR' then state = 'Puerto Rico';
run;

proc sort data = Mylib.TPCEcustomer nodupkey;
	by customerID;
run;

data Mylib.TPCEcustomer;
	set Mylib.TPCEcustomer;
	rename customerID = customerIDTPCE_NK;
run;

data Mylib.TPCEcustomer;
	retain customerIDTPCE_NK name addr1 addr2
		city state zip typeName;
	set Mylib.TPCEcustomer;
run;

proc sort data = Mylib.TPCEcustomer;
	by name city state typeName;
run;

data Mylib.customer_dim;
	merge Mylib.TPCEcustomer Mylib.TPCWcustomer Mylib.PECcustomer;
	by name city state typeName;
run;

data Mylib.customer_dim;
	set Mylib.customer_dim;
	format customer_SK best12.;
	customer_SK = _N_;
run;

data Mylib.customer_dim;
	retain customer_SK customerIDTPCE_NK customerIDTPCW_NK customerIDPEC_NK 
		name addr1 addr2 city state zip typeName;
	set Mylib.customer_dim;
run;

proc export data=Mylib.customer_dim outfile = '/folders/myfolders/Lab03/customer_dim.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

* cleansing product tables;

data Mylib.TPCEproduct;
infile '/folders/myfolders/Lab03/product.csv' dsd delimiter=';' firstobs=2;
format prodID best12.;
format description $50.;
format price1 best12.;
format price2 best12.;
format prodtypeID $4.;
format unitCost best12.;
format supplierID best12.;
input prodID description $ price1 price2 prodtypeID $ unitCost supplierID;
run;

data Mylib.TPCEprod_type;
infile '/folders/myfolders/Lab03/prod_type.csv' dsd delimiter=';' firstobs=2;
format prodtypeID $4.;
format typeDescription $50.;
format buid $1.;
input prodtypeID $ typeDescription $ buid $;
run;

data Mylib.TPCEbusiness_unit;
infile '/folders/myfolders/Lab03/business_unit.csv' dsd delimiter=';' firstobs=2;
format buid $1.;
format businessUnitName $50.;
format abbrev $20.;
input buid $ businessUnitName $ abbrev $;
run;

data Mylib.TPCEsupplier;
infile '/folders/myfolders/Lab03/supplier.csv' dsd delimiter=';' firstobs=2;
format supplierID best12.;
format supplierName $50.;
format supplierAddr1 $50.;
format supplierAddr2 $50.;
format supplierCity $50.;
format supplierState $50.;
format supplierZip $5.;
input supplierID supplierName $ supplierAddr1 $ supplierAddr2 $
	supplierCity $ supplierState $ supplierZip $;
run;

data Mylib.TPCEbusiness_unit;
	modify Mylib.TPCEbusiness_unit;
	if missing(abbrev) and buid = 'D'
		then abbrev = "Misc";
run;

proc sort data=Mylib.TPCEprod_type;
	by buid;
run;

data Mylib.prodtypeAndBU;
	merge Mylib.TPCEprod_type Mylib.TPCEbusiness_unit;
	by buid;
run;

data Mylib.prodtypeAndBU;
	set Mylib.prodtypeAndBU (drop = buid abbrev);
run;

proc sort data = Mylib.prodtypeAndBU;
	by prodtypeID;
run;

proc sort data = Mylib.TPCEproduct;
	by prodtypeID;
run;

data Mylib.TPCEproduct;
	merge Mylib.TPCEproduct Mylib.prodtypeAndBU;
	by prodtypeID;
run;

data Mylib.TPCEproduct;
	set Mylib.TPCEproduct (drop = prodtypeID);
run;

proc sort data = Mylib.TPCEproduct;
	by supplierID;
run;

data Mylib.TPCEproduct;
	merge Mylib.TPCEproduct Mylib.TPCEsupplier;
	by supplierID;
run;

data Mylib.TPCEproduct;
	set Mylib.TPCEproduct (drop = supplierID);
run;

data Mylib.TPCEproduct;
	modify Mylib.TPCEproduct;
	
	if scan(description,-1,' ') = 'Equip' then
		description = tranwrd(description,'Equip','Equipment');
	if scan(typeDescription,-1,' ') = 'Equip' then
		typeDescription = tranwrd(typeDescription,'Equip','Equipment');
	if scan(businessUnitName,-1,' ') = 'Equip' then
		businessUnitName = tranwrd(businessUnitName,'Equip','Equipment');
	
	if length(supplierZip) = 4 then
		supplierZip = supplierZip || '0';
		
	if scan(supplierName,-1,' ') = 'Corp' then
		supplierName = tranwrd(supplierName,'Corp','Corporation');
	if scan(supplierName,-1,' ') = 'Corp.' then
		supplierName = tranwrd(supplierName,'Corp.','Corporation');
		
	if scan(supplierName,-1,' ') = 'Inc' then
		supplierName = tranwrd(supplierName,'Inc','Incorporated');
	if scan(supplierName,-1,' ') = 'Inc.' then
		supplierName = tranwrd(supplierName,'Inc.','Incorporated');
		
	if scan(supplierName,-1,' ') = 'Co' then
		supplierName = tranwrd(supplierName,'Co','Company');
	if scan(supplierName,-1,' ') = 'Co.' then
		supplierName = tranwrd(supplierName,'Co.','Company');
	
	if length(supplierState) = 2 then supplierState = upcase(supplierState);
	if supplierState = 'AL' then supplierState = 'Alabama';
	if supplierState = 'AK' then supplierState = 'Alaska';
	if supplierState = 'AZ' then supplierState = 'Arizona';
	if supplierState = 'AR' then supplierState = 'Arkansas';
	if supplierState = 'CA' then supplierState = 'California';
	if supplierState = 'CO' then supplierState = 'Colorado';
	if supplierState = 'CT' then supplierState = 'Connecticut';
	if supplierState = 'DE' then supplierState = 'Delaware';
	if supplierState = 'FL' then supplierState = 'Florida';
	if supplierState = 'GA' then supplierState = 'Georgia';
	if supplierState = 'HI' then supplierState = 'Hawaii';
	if supplierState = 'ID' then supplierState = 'Idaho';
	if supplierState = 'IL' then supplierState = 'Illinois';
	if supplierState = 'IN' then supplierState = 'Indiana';
	if supplierState = 'IA' then supplierState = 'Iowa';
	if supplierState = 'KS' then supplierState = 'Kansas';
	if supplierState = 'KY' then supplierState = 'Kentucky';
	if supplierState = 'LA' then supplierState = 'Louisiana';
	if supplierState = 'ME' then supplierState = 'Maine';
	if supplierState = 'MD' then supplierState = 'Maryland';
	if supplierState = 'MA' then supplierState = 'Massachusetts';
	if supplierState = 'MI' then supplierState = 'Michigan';
	if supplierState = 'MN' then supplierState = 'Minnesota';
	if supplierState = 'MS' then supplierState = 'Mississippi';
	if supplierState = 'MO' then supplierState = 'Missouri';
	if supplierState = 'MT' then supplierState = 'Montana';
	if supplierState = 'NE' then supplierState = 'Nebraska';
	if supplierState = 'NV' then supplierState = 'Nevada';
	if supplierState = 'NH' then supplierState = 'New Hampshire';
	if supplierState = 'NJ' then supplierState = 'New Jersey';
	if supplierState = 'NM' then supplierState = 'New Mexico';
	if supplierState = 'NY' then supplierState = 'New York';
	if supplierState = 'NC' then supplierState = 'North Carolina';
	if supplierState = 'ND' then supplierState = 'North Dakota';
	if supplierState = 'OH' then supplierState = 'Ohio';
	if supplierState = 'OK' then supplierState = 'Oklahoma';
	if supplierState = 'OR' then supplierState = 'Oregon';
	if supplierState = 'PA' then supplierState = 'Pennsylvania';
	if supplierState = 'RI' then supplierState = 'Rhode Island';
	if supplierState = 'SC' then supplierState = 'South Carolina';
	if supplierState = 'SD' then supplierState = 'South Dakota';
	if supplierState = 'TN' then supplierState = 'Tennessee';
	if supplierState = 'TX' then supplierState = 'Texas';
	if supplierState = 'UT' then supplierState = 'Utah';
	if supplierState = 'VT' then supplierState = 'Vermont';
	if supplierState = 'VA' then supplierState = 'Virginia';
	if supplierState = 'WA' then supplierState = 'Washington';
	if supplierState = 'WV' then supplierState = 'West Virginia';
	if supplierState = 'WI' then supplierState = 'Wisconsin';
	if supplierState = 'WY' then supplierState = 'Wyoming';
	if supplierState = 'DC' then supplierState = 'District of Columbia';
	if supplierState = 'PR' then supplierState = 'Puerto Rico';
	
	if (index(supplierAddr2, 'Rd.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Rd.', "Road");
	if (index(supplierAddr2, 'St.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'St.', "Street");
	if scan(supplierAddr2,-1,' ') = 'Dr' then
		supplierAddr2 = tranwrd(supplierAddr2,'Dr','Drive');
	if scan(supplierAddr2,-1,' ') = 'Dr.' then
		supplierAddr2 = tranwrd(supplierAddr2,'Dr.','Drive');
	if (index(supplierAddr2, 'Ave.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Ave.', "Avenue");
	if (index(supplierAddr2, 'Av.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Av.', "Avenue");
	if substr(supplierAddr2,length(supplierAddr2)-2,length(supplierAddr2)) = 'Ave' then
		supplierAddr2 = tranwrd(supplierAddr2, 'Ave', "Avenue");
	
	supplierAddr2 = tranwrd(supplierAddr2,'.','');
	supplierAddr2 = tranwrd(supplierAddr2,',','');
run;

data Mylib.TPCEproduct;
	set Mylib.TPCEproduct;
	rename prodID = prodIDTPCE_NK;
run;

data Mylib.TPCEproduct;
	retain prodIDTPCE_NK description price1 price2 unitCost typeDescription
		businessUnitName supplierName supplierAddr1 supplierAddr2 supplierCity
		supplierState supplierZip;
	set Mylib.TPCEproduct;
run;

proc sort data = Mylib.TPCEproduct nodupkey;
	by prodIDTPCE_NK;
run;

proc sort data = Mylib.TPCEproduct;
	by description price1 price2 unitCost supplierName supplierAddr1 
		supplierAddr2 supplierCity supplierState supplierZip;
run;

* cleansing TPCW product data;

data Mylib.TPCWproduct;
infile '/folders/myfolders/Lab03/TPCWproduct.csv' dsd delimiter=';' firstobs=1;
format prodID best12.;
format description $50.;
format price1 best12.;
format price2 best12.;
format unitCost best12.;
format supplierName $50.;
format supplierAddr1 $50.;
format supplierAddr2 $50.;
format supplierCity $50.;
format supplierState $50.;
format supplierZip $5.;
format prodtypeID $4.;
input prodID description $ price1 price2 unitCost  
	supplierName $ supplierAddr1 $ supplierAddr2 $ supplierCity $ 
	supplierState $ supplierZip $ prodtypeID $;
run;

data Mylib.TPCWproduct;
	modify Mylib.TPCWproduct;
	
	if length(prodtypeID) = 1 then
		prodtypeID = '000' || prodtypeID;
	if length(prodtypeID) = 2 then
		prodtypeID = '00' || prodtypeID;
		
	if prodID = 12 then
		prodtypeID = '0009';
	
	if scan(description,-1,' ') = 'Equip' then
		description = tranwrd(description,'Equip','Equipment');
		
	if length(supplierZip) = 4 then
		supplierZip = supplierZip || '0';
		
	if scan(supplierName,-1,' ') = 'Corp' then
		supplierName = tranwrd(supplierName,'Corp','Corporation');
	if scan(supplierName,-1,' ') = 'Corp.' then
		supplierName = tranwrd(supplierName,'Corp.','Corporation');
		
	if scan(supplierName,-1,' ') = 'Inc' then
		supplierName = tranwrd(supplierName,'Inc','Incorporated');
	if scan(supplierName,-1,' ') = 'Inc.' then
		supplierName = tranwrd(supplierName,'Inc.','Incorporated');
		
	if scan(supplierName,-1,' ') = 'Co' then
		supplierName = tranwrd(supplierName,'Co','Company');
	if scan(supplierName,-1,' ') = 'Co.' then
		supplierName = tranwrd(supplierName,'Co.','Company');
	
	if length(supplierState) = 2 then supplierState = upcase(supplierState);
	if supplierState = 'AL' then supplierState = 'Alabama';
	if supplierState = 'AK' then supplierState = 'Alaska';
	if supplierState = 'AZ' then supplierState = 'Arizona';
	if supplierState = 'AR' then supplierState = 'Arkansas';
	if supplierState = 'CA' then supplierState = 'California';
	if supplierState = 'CO' then supplierState = 'Colorado';
	if supplierState = 'CT' then supplierState = 'Connecticut';
	if supplierState = 'DE' then supplierState = 'Delaware';
	if supplierState = 'FL' then supplierState = 'Florida';
	if supplierState = 'GA' then supplierState = 'Georgia';
	if supplierState = 'HI' then supplierState = 'Hawaii';
	if supplierState = 'ID' then supplierState = 'Idaho';
	if supplierState = 'IL' then supplierState = 'Illinois';
	if supplierState = 'IN' then supplierState = 'Indiana';
	if supplierState = 'IA' then supplierState = 'Iowa';
	if supplierState = 'KS' then supplierState = 'Kansas';
	if supplierState = 'KY' then supplierState = 'Kentucky';
	if supplierState = 'LA' then supplierState = 'Louisiana';
	if supplierState = 'ME' then supplierState = 'Maine';
	if supplierState = 'MD' then supplierState = 'Maryland';
	if supplierState = 'MA' then supplierState = 'Massachusetts';
	if supplierState = 'MI' then supplierState = 'Michigan';
	if supplierState = 'MN' then supplierState = 'Minnesota';
	if supplierState = 'MS' then supplierState = 'Mississippi';
	if supplierState = 'MO' then supplierState = 'Missouri';
	if supplierState = 'MT' then supplierState = 'Montana';
	if supplierState = 'NE' then supplierState = 'Nebraska';
	if supplierState = 'NV' then supplierState = 'Nevada';
	if supplierState = 'NH' then supplierState = 'New Hampshire';
	if supplierState = 'NJ' then supplierState = 'New Jersey';
	if supplierState = 'NM' then supplierState = 'New Mexico';
	if supplierState = 'NY' then supplierState = 'New York';
	if supplierState = 'NC' then supplierState = 'North Carolina';
	if supplierState = 'ND' then supplierState = 'North Dakota';
	if supplierState = 'OH' then supplierState = 'Ohio';
	if supplierState = 'OK' then supplierState = 'Oklahoma';
	if supplierState = 'OR' then supplierState = 'Oregon';
	if supplierState = 'PA' then supplierState = 'Pennsylvania';
	if supplierState = 'RI' then supplierState = 'Rhode Island';
	if supplierState = 'SC' then supplierState = 'South Carolina';
	if supplierState = 'SD' then supplierState = 'South Dakota';
	if supplierState = 'TN' then supplierState = 'Tennessee';
	if supplierState = 'TX' then supplierState = 'Texas';
	if supplierState = 'UT' then supplierState = 'Utah';
	if supplierState = 'VT' then supplierState = 'Vermont';
	if supplierState = 'VA' then supplierState = 'Virginia';
	if supplierState = 'WA' then supplierState = 'Washington';
	if supplierState = 'WV' then supplierState = 'West Virginia';
	if supplierState = 'WI' then supplierState = 'Wisconsin';
	if supplierState = 'WY' then supplierState = 'Wyoming';
	if supplierState = 'DC' then supplierState = 'District of Columbia';
	if supplierState = 'PR' then supplierState = 'Puerto Rico';
	
	if (index(supplierAddr2, 'Rd.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Rd.', "Road");
	if (index(supplierAddr2, 'St.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'St.', "Street");
	if scan(supplierAddr2,-1,' ') = 'Dr' then
		supplierAddr2 = tranwrd(supplierAddr2,'Dr','Drive');
	if scan(supplierAddr2,-1,' ') = 'Dr.' then
		supplierAddr2 = tranwrd(supplierAddr2,'Dr.','Drive');
	if (index(supplierAddr2, 'Ave.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Ave.', "Avenue");
	if (index(supplierAddr2, 'Av.') > 0) then
		supplierAddr2 = tranwrd(supplierAddr2, 'Av.', "Avenue");
	if substr(supplierAddr2,length(supplierAddr2)-2,length(supplierAddr2)) = 'Ave' then
		supplierAddr2 = tranwrd(supplierAddr2, 'Ave', "Avenue");
	
	supplierAddr2 = tranwrd(supplierAddr2,'.','');
	supplierAddr2 = tranwrd(supplierAddr2,',','');
	
run;

proc export data=Mylib.TPCWproduct outfile = '/folders/myfolders/Lab03/TPCWproduct_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

proc sort data = Mylib.TPCWproduct;
	by prodtypeID;
run;

data Mylib.TPCWproduct;
	merge Mylib.TPCWproduct Mylib.prodtypeAndBU;
	by prodtypeID;
run;

data Mylib.TPCWproduct;
	set Mylib.TPCWproduct (drop = prodtypeID);
run;

data Mylib.TPCWproduct;
	modify Mylib.TPCWproduct;
	
	if scan(typeDescription,-1,' ') = 'Equip' then
		typeDescription = tranwrd(typeDescription,'Equip','Equipment');
	if scan(businessUnitName,-1,' ') = 'Equip' then
		businessUnitName = tranwrd(businessUnitName,'Equip','Equipment');
run;

data Mylib.TPCWproduct;
	set Mylib.TPCWproduct;
	rename prodID = prodIDTPCW_NK;
run;

proc sort data = Mylib.TPCWproduct nodupkey;
	by prodIDTPCW_NK;
run;

data Mylib.TPCWproduct;
	retain prodIDTPCW_NK description price1 price2 unitCost typeDescription
		businessUnitName supplierName supplierAddr1 supplierAddr2 supplierCity
		supplierState supplierZip;
	set Mylib.TPCWproduct;
run;

proc sort data = Mylib.TPCWproduct;
	by description price1 price2 unitCost supplierName supplierAddr1 
		supplierAddr2 supplierCity supplierState;
run;

* cleansing PEC product;

data Mylib.PECproduct;
infile '/folders/myfolders/Lab03/PECproduct.csv' dsd delimiter=';' firstobs=2;
format prodID best12.;
format description $50.;
format price1 best12.;
format price2 best12.;
format unitCost best12.;
format supplierName $50.;
format prodtypeID $4.;
input prodID description $ price1 price2 unitCost 
	supplierName $ prodtypeID $;
run;

data Mylib.PECproduct;
	modify Mylib.PECproduct;
	
	if length(prodtypeID) = 1 then
		prodtypeID = '000' || prodtypeID;
	if length(prodtypeID) = 2 then
		prodtypeID = '00' || prodtypeID;
		
	if scan(supplierName,-1,' ') = 'Corp' then
		supplierName = tranwrd(supplierName,'Corp','Corporation');
	if scan(supplierName,-1,' ') = 'Corp.' then
		supplierName = tranwrd(supplierName,'Corp.','Corporation');
		
	if scan(supplierName,-1,' ') = 'Inc' then
		supplierName = tranwrd(supplierName,'Inc','Incorporated');
	if scan(supplierName,-1,' ') = 'Inc.' then
		supplierName = tranwrd(supplierName,'Inc.','Incorporated');
		
	if scan(supplierName,-1,' ') = 'Co' then
		supplierName = tranwrd(supplierName,'Co','Company');
	if scan(supplierName,-1,' ') = 'Co.' then
		supplierName = tranwrd(supplierName,'Co.','Company');
	
	if missing(supplierName) then
		supplierName = 'PEC';
		
	if scan(description,-1,' ') = 'Equip' then
		description = tranwrd(description,'Equip','Equipment');
run;

* calculating the unit cost for PEC product;
data Mylib.PECinvoice;
infile '/folders/myfolders/Lab03/PECinvoice.csv' dsd delimiter=',' firstobs=2;
format invoiceID best12.;
format custID best12.;
format salesDate $8.;
format prodID best12.;
format amt best12.;
format qty best12.;
format shipMethod $20.;
format shipCost best12.;
format paymentMethod $20.;
format orderMethod $20.;
format orderDate $8.;
format discounted best12.;
input invoiceID custID salesDate $ prodID amt qty shipMethod $
	shipCost paymentMethod $ orderMethod $ orderDate $ discounted;
run;

data Mylib.PECinvoice;
	set Mylib.PECinvoice (keep = salesDate prodID qty);
run;

data Mylib.PECinvoice;
	modify Mylib.PECinvoice;
	if index(salesDate,'-') > 0 then
		salesDate = tranwrd(salesDate, '-', '/');

data Mylib.PECinvoice;
	set Mylib.PECinvoice;
	format month best12.;
	format year $2.;
	month = scan(salesDate,1,'/');
	year = scan(salesDate,3,'/');
run;

proc sql;
	create table Mylib.PECinvoice_grouped as
	select prodID, month, year, sum(qty) as total_quantity
	from Mylib.PECinvoice
	group by prodID, month, year;
quit;

proc sort data = Mylib.PECinvoice_grouped;
	by prodID month year;
run;

data Mylib.PECmanufacturingCosts;
infile '/folders/myfolders/Lab03/PECmanufacturingCosts.csv' dsd delimiter='|' firstobs=2;
format year $2.;
format month best12.;
format prodID best12.;
format manufacturingCost best12.;
input year month prodID manufacturingCost;
run;

data Mylib.PECmanufacturingCosts;
	modify Mylib.PECmanufacturingCosts;
	if length(year) = 1 then
		year = '0' || year;
run;

proc sql;
	create table Mylib.PECUnitCost as
	select *
	from Mylib.PECinvoice_grouped as one full join Mylib.PECmanufacturingCosts as two
	on one.prodID = two.prodID and one.month = two.month and one.year = two.year;
quit;

data Mylib.PECUnitCost;
	set Mylib.PECUnitCost;
	format unitCost_temp best12.;
	unitCost_temp = manufacturingCost/total_quantity;
run;

proc sort data = Mylib.PECUnitCost nodupkey;
	by prodID;
run;

data Mylib.PECUnitCost;
	set Mylib.PECUnitCost (keep = prodID unitCost_temp);
run;

data Mylib.PECproduct;
	merge Mylib.PECproduct Mylib.PECUnitCost;
	by prodID;
run;

data Mylib.PECproduct;
	modify Mylib.PECproduct;
	
	if missing(unitCost) then
		unitCost = unitCost_temp;
run;

data Mylib.PECproduct;
	set Mylib.PECproduct (drop = unitCost_temp);
run;

proc export data=Mylib.PECproduct outfile = '/folders/myfolders/Lab03/PECproduct_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

proc sort data = Mylib.PECproduct;
	by prodtypeID;
run;

proc sql;
	create table Mylib.PECproduct as
	select *
	from Mylib.PECproduct as one left join Mylib.prodtypeAndBU as two
	on one.prodtypeID = two.prodtypeID;
quit;

data Mylib.PECproduct;
	set Mylib.PECproduct (drop = prodtypeID);
run;

proc sort data = Mylib.PECproduct;
	by prodID;
run;

data Mylib.PECproduct;
	set Mylib.PECproduct;
	format supplierAddr1 $50.;
	format supplierAddr2 $50.;
	format supplierCity $20.;
	format supplierState $20.;
	format supplierZip $5.;
run;

data Mylib.PECproduct;
	retain prodID description price1 price2 unitCost typeDescription
		businessUnitName supplierName supplierAddr1 supplierAddr2 supplierCity
		supplierState supplierZip;
	set Mylib.PECproduct;
run;

data Mylib.PECproduct;
	modify Mylib.PECproduct;
	
	if scan(typeDescription,-1,' ') = 'Equip' then
		typeDescription = tranwrd(typeDescription,'Equip','Equipment');
	if scan(businessUnitName,-1,' ') = 'Equip' then
		businessUnitName = tranwrd(businessUnitName,'Equip','Equipment');
		
	if supplierName = 'TPC East' then 
		do;
			supplierCity = 'Stratford';
			supplierState = 'New York';
			supplierZip = '13470';
		end;
	
	if supplierName = 'TPC West' then 
		do;
			supplierCity = 'Fresno';
			supplierState = 'California';
			supplierZip = '93650';
		end;
	
	if supplierName = 'PEC' then 
		do;
			supplierCity = 'Naperville';
			supplierState = 'Illinois';
			supplierZip = '60440';
		end;
run;

proc sort data = Mylib.PECproduct nodupkey;
	by prodID;
run;

data Mylib.PECproduct;
	set Mylib.PECproduct;
	rename prodID = prodIDPEC_NK;
run;

data Mylib.PECproduct;
	retain prodIDPEC_NK description price1 price2 unitCost typeDescription
		businessUnitName supplierName supplierAddr1 supplierAddr2 supplierCity
		supplierState supplierZip;
	set Mylib.PECproduct;
run;

proc sort data = Mylib.PECproduct;
	by description price1 price2 unitCost supplierName supplierAddr1 
		supplierAddr2 supplierCity supplierState;
run;

data Mylib.product_dim;
	merge Mylib.TPCEproduct Mylib.TPCWproduct Mylib.PECproduct;
	by description price1 price2 unitCost supplierName supplierAddr1 
		supplierAddr2 supplierCity supplierState;
run;

data Mylib.product_dim;
	set Mylib.product_dim;
	format product_SK best12.;
	product_SK = _N_;
run;

data Mylib.product_dim;
	retain product_SK prodIDTPCE_NK prodIDTPCW_NK prodIDPEC_NK description price1 price2 unitCost 
	typeDescription businessUnitName supplierName supplierAddr1 supplierAddr2 
	supplierCity supplierState supplierZip;
	set Mylib.product_dim;
run;

proc export data=Mylib.product_dim outfile = '/folders/myfolders/Lab03/product_dim.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

* cleansing and preparing invoice dimensions;
data Mylib.TPCEinvoice;
infile '/folders/myfolders/Lab03/invoice.csv' dsd delimiter=',' firstobs=2;
format invoiceID best12.;
format customerID best12.;
format saleDate $10.;
input invoiceID customerID saleDate $;
run;

proc sort data = Mylib.TPCEinvoice;
	by invoiceID;
run;

data Mylib.TPCEinvoice_details;
infile '/folders/myfolders/Lab03/invoice_details.csv' dsd delimiter=',' firstobs=2;
format invoiceID best12.;
format prodID best12.;
format amt best12.;
format qty best12.;
format discounted $1.;
input invoiceID prodID amt qty discounted $;
run;

proc sort data = Mylib.TPCEinvoice_details;
	by invoiceID;
run;

data Mylib.TPCEinvoice;
	merge Mylib.TPCEinvoice Mylib.TPCEinvoice_details;
	by invoiceID;
run;

data Mylib.TPCEinvoice;
	modify Mylib.TPCEinvoice;
	
	format year $4.;
	format month $2.;
	format day $2.;
	
	if missing(discounted) then
		discounted = '0';
		
	saleDate = tranwrd(saleDate,'/','-');
	
	year = scan(saleDate,3,'-');
	if length(year) = 2 then
		year = '20' || year;
	month = scan(saleDate,1,'-');
	if length(month) = 1 then
		month = '0' || month;
	day = scan(saleDate,2,'-');
	if length(day) = 1 then
		day = '0' || day;
	
	saleDate = year || '-' || month || '-' || day;
	
run;

data Mylib.TPCEinvoice;
	set Mylib.TPCEinvoice;
	format division $4.;
	format orderDate $10.;
	format shippingMethod $10.;
	format orderMethod $10.;
	format paymentMethod $10.;
	format shippingCost best12.;
	division = 'TPCE';
run;

data Mylib.TPCEinvoice;
	retain invoiceID customerID prodID saleDate amt qty discounted
		orderDate shippingMethod orderMethod paymentMethod shippingCost division;
	set Mylib.TPCEinvoice;
run;

proc export data=Mylib.TPCEinvoice outfile = '/folders/myfolders/Lab03/TPCEinvoice_fact.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

* cleansing TPCW invoice;
data Mylib.TPCWinvoice;
infile '/folders/myfolders/Lab03/TPCWinvoice.csv' dsd delimiter=',' firstobs=2;
format invoiceID best12.;
format customerID best12.;
format prodID best12.;
format saleDate $10.;
format amt best12.;
format qty best12.;
format discounted $1.;
input invoiceID customerID prodID saleDate $ amt qty discounted $;
run;

data Mylib.TPCWinvoice;
	modify Mylib.TPCWinvoice;
	
	format year $4.;
	format month $2.;
	format day $2.;
	
	if customerID < 0 then
		customerID = customerID * -1;
	
	if missing(discounted) then
		discounted = '0';
		
	saleDate = tranwrd(saleDate,'/','-');
		
	year = scan(saleDate,3,'-');
	if length(year) = 2 then
		year = '20' || year;
	month = scan(saleDate,2,'-');
	if length(month) = 1 then
		month = '0' || month;
	day = scan(saleDate,1,'-');
	if length(day) = 1 then
		day = '0' || day;
	
	saleDate = year || '-' || month || '-' || day;
run;

proc sort data = Mylib.TPCWinvoice;
	by prodID;
run;

proc sql;
	create table Mylib.TPCW_invoice_product as
	select *
	from Mylib.TPCWinvoice as one inner join Mylib.TPCWproduct as two
	on one.prodID = two.prodIDTPCW_NK;
quit;

data Mylib.TPCW_invoice_product;
	modify Mylib.TPCW_invoice_product;
	
	if discounted = 1 then
		amt = price2 * qty;
	
	if discounted = 0 then
		amt = price1 * qty;

data Mylib.TPCWinvoice;
	set Mylib.TPCW_invoice_product (keep = invoiceID customerID prodID
		saleDate amt qty discounted);
run;

proc export data=Mylib.TPCWinvoice outfile = '/folders/myfolders/Lab03/TPCWinvoice_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.TPCWinvoice;
	set Mylib.TPCWinvoice;
	format division $4.;
	format orderDate $10.;
	format shippingMethod $10.;
	format orderMethod $10.;
	format paymentMethod $10.;
	format shippingCost best12.;
	division = 'TPCW';
run;

data Mylib.TPCWinvoice;
	retain invoiceID customerID prodID saleDate amt qty discounted
		orderDate shippingMethod orderMethod paymentMethod shippingCost division;
	set Mylib.TPCWinvoice;
run;

proc export data=Mylib.TPCWinvoice outfile = '/folders/myfolders/Lab03/TPCWinvoice_fact.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

* cleansing PEC invoice;
data Mylib.PECinvoice;
infile '/folders/myfolders/Lab03/PECinvoice.csv' dsd delimiter=',' firstobs=2;
format invoiceID best12.;
format customerID best12.;
format saleDate $10.;
format prodID best12.;
format amt best12.;
format qty best12.;
format shippingMethod $20.;
format shippingCost best12.;
format paymentMethod $20.;
format orderMethod $20.;
format orderDate $10.;
format discounted $1.;
input invoiceID customerID saleDate $ prodID amt qty shippingMethod $
	shippingCost paymentMethod $ orderMethod $ orderDate $ discounted $;
run;

data Mylib.PECinvoice;
	modify Mylib.PECinvoice;
	
	format saleYear $4.;
	format saleMonth $2.;
	format saleDay $2.;
	
	format orderYear $4.;
	format orderMonth $2.;
	format orderDay $2.;
	
	if missing(discounted) then
		discounted = '0';
		
	saleDate = tranwrd(saleDate,'/','-');
	
	saleYear = scan(saleDate,3,'-');
	if length(saleYear) = 2 then
		saleYear = '20' || saleYear;
	saleMonth = scan(saleDate,1,'-');
	if length(saleMonth) = 1 then
		saleMonth = '0' || saleMonth;
	saleDay = scan(saleDate,2,'-');
	if length(saleDay) = 1 then
		saleDay = '0' || saleDay;
	
	saleDate = saleYear || '-' || saleMonth || '-' || saleDay;
	
	orderDate = tranwrd(orderDate,'/','-');
	
	orderYear = scan(orderDate,3,'-');
	if length(orderYear) = 2 then
		orderYear = '20' || orderYear;
	orderMonth = scan(orderDate,1,'-');
	if length(orderMonth) = 1 then
		orderMonth = '0' || orderMonth;
	orderDay = scan(orderDate,2,'-');
	if length(orderDay) = 1 then
		orderDay = '0' || orderDay;
	
	orderDate = orderYear || '-' || orderMonth || '-' || orderDay;
	
	if shippingMethod = "aiir" then
		shippingMethod = "air";
	
	if shippingMethod = "trrain" or shippingMethod = "trran" then
		shippingMethod = "train";
	
	if shippingMethod = "tuck" then
		shippingMethod = "truck";
run;

proc sort data = Mylib.PECinvoice;
	by prodID;
run;

proc sql;
	create table Mylib.PEC_invoice_product as
	select *
	from Mylib.PECinvoice as one inner join Mylib.PECproduct as two
	on one.prodID = two.prodIDPEC_NK;
quit;

data Mylib.PEC_invoice_product;
	modify Mylib.PEC_invoice_product;
	
	if discounted = 1 then
		amt = (price2 * qty) + shippingCost;
	
	if discounted = 0 then
		amt = (price1 * qty) + shippingCost;

data Mylib.PECinvoice;
	set Mylib.PEC_invoice_product (keep = invoiceID customerID saleDate prodID
		amt qty shippingMethod shippingCost paymentMethod orderMethod
		orderDate discounted);
run;

proc export data=Mylib.PECinvoice outfile = '/folders/myfolders/Lab03/PECinvoice_cleaned.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.PECinvoice;
	set Mylib.PECinvoice;
	format division $4.;
	division = 'PEC';
run;

data Mylib.PECinvoice;
	retain invoiceID customerID prodID saleDate amt qty discounted
		orderDate shippingMethod orderMethod paymentMethod shippingCost division;
	set Mylib.PECinvoice;
run;

proc export data=Mylib.PECinvoice outfile = '/folders/myfolders/Lab03/PECinvoice_fact.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.invoice_total;
	set Mylib.TPCEinvoice Mylib.TPCWinvoice Mylib.PECinvoice;
run;

proc export data=Mylib.invoice_total outfile = '/folders/myfolders/Lab03/invoice_total.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.TPCEsaleDate_dimension;
	set Mylib.TPCEinvoice (keep = saleDate);
run;

data Mylib.TPCEsaleDate_dimension;
	set Mylib.TPCEsaleDate_dimension;
	
	format sale_calendarYear $4.;
	format sale_calendarQuarter best12.;
	format sale_calendarMonth $2.;
	format sale_calendarWeek best12.;
	format sale_calendarDay $2.;
	
	format sale_fiscalYear $4.;
	format sale_fiscalQuarter best12.;
	format sale_fiscalMonth $2.;
	format sale_fiscalWeek best12.;
	format sale_fiscalDay $2.;
	
	sale_calendarYear = scan(saleDate,1,'-');
	sale_calendarMonth = scan(saleDate,2,'-');
	sale_calendarDay = scan(saleDate,3,'-');
	sale_calendarWeek = ceil(input(sale_calendarDay,2.)/7);
	sale_calendarQuarter = ceil(input(sale_calendarMonth,2.)/3);
	
	sale_fiscalYear = sale_calendarYear;
	sale_fiscalQuarter = sale_calendarQuarter;
	sale_fiscalMonth = sale_calendarMonth;
	sale_fiscalWeek = sale_calendarWeek;
	sale_fiscalDay = sale_calendarDay;

run;

proc sort data = Mylib.TPCEsaleDate_dimension nodupkey;
	by sale_calendarYear sale_calendarMonth sale_calendarDay;
run;

data Mylib.TPCWsaleDate_dimension;
	set Mylib.TPCWinvoice (keep = saleDate);
run;

data Mylib.TPCWsaleDate_dimension;
	set Mylib.TPCWsaleDate_dimension;
	
	format sale_calendarYear $4.;
	format sale_calendarQuarter best12.;
	format sale_calendarMonth $2.;
	format sale_calendarWeek best12.;
	format sale_calendarDay $2.;
	
	format sale_fiscalYear $4.;
	format sale_fiscalQuarter best12.;
	format sale_fiscalMonth $2.;
	format sale_fiscalWeek best12.;
	format sale_fiscalDay $2.;
	
	sale_calendarYear = scan(saleDate,1,'-');
	sale_calendarMonth = scan(saleDate,2,'-');
	sale_calendarDay = scan(saleDate,3,'-');
	sale_calendarWeek = ceil(input(sale_calendarDay,2.)/7);
	sale_calendarQuarter = ceil(input(sale_calendarMonth,2.)/3);
	
	sale_fiscalYear = sale_calendarYear;
	sale_fiscalQuarter = sale_calendarQuarter;
	sale_fiscalMonth = sale_calendarMonth;
	sale_fiscalWeek = sale_calendarWeek;
	sale_fiscalDay = sale_calendarDay;

run;

proc sort data = Mylib.TPCWsaleDate_dimension nodupkey;
	by sale_calendarYear sale_calendarMonth sale_calendarDay;
run;

data Mylib.PECsaleDate_dimension;
	set Mylib.PECinvoice (keep = saleDate);
run;

data Mylib.PECsaleDate_dimension;
	set Mylib.PECsaleDate_dimension;
	
	format sale_calendarYear $4.;
	format sale_calendarQuarter best12.;
	format sale_calendarMonth $2.;
	format sale_calendarWeek best12.;
	format sale_calendarDay $2.;
	
	format sale_fiscalYear $4.;
	format sale_fiscalQuarter best12.;
	format sale_fiscalMonth $2.;
	format sale_fiscalWeek best12.;
	format sale_fiscalDay $2.;
	
	sale_calendarYear = scan(saleDate,1,'-');
	sale_calendarMonth = scan(saleDate,2,'-');
	sale_calendarDay = scan(saleDate,3,'-');
	sale_calendarWeek = ceil(input(sale_calendarDay,2.)/7);
	sale_calendarQuarter = ceil(input(sale_calendarMonth,2.)/3);
	
	sale_fiscalYear = sale_calendarYear;
	sale_fiscalQuarter = sale_calendarQuarter;
	sale_fiscalMonth = sale_calendarMonth;
	sale_fiscalWeek = sale_calendarWeek;
	sale_fiscalDay = sale_calendarDay;
	
run;

proc sort data = Mylib.PECsaleDate_dimension nodupkey;
	by sale_calendarYear sale_calendarMonth sale_calendarDay;
run;

data Mylib.PECorderDate_dimension;
	set Mylib.PECinvoice (keep = orderDate);
run;

data Mylib.PECorderDate_dimension;
	set Mylib.PECorderDate_dimension;
	
	format order_calendarYear $4.;
	format order_calendarQuarter best12.;
	format order_calendarMonth $2.;
	format order_calendarWeek best12.;
	format order_calendarDay $2.;
	
	format order_fiscalYear $4.;
	format order_fiscalQuarter best12.;
	format order_fiscalMonth $2.;
	format order_fiscalWeek best12.;
	format order_fiscalDay $2.;
	
	order_calendarYear = scan(orderDate,1,'-');
	order_calendarMonth = scan(orderDate,2,'-');
	order_calendarDay = scan(orderDate,3,'-');
	order_calendarWeek = ceil(input(order_calendarDay,2.)/7);
	order_calendarQuarter = ceil(input(order_calendarMonth,2.)/3);
	
	order_fiscalYear = order_calendarYear;
	order_fiscalQuarter = order_calendarQuarter;
	order_fiscalMonth = order_calendarMonth;
	order_fiscalWeek = order_calendarWeek;
	order_fiscalDay = order_calendarDay;

run;

proc sort data = Mylib.PECorderDate_dimension nodupkey;
	by order_calendarYear order_calendarMonth order_calendarDay;
run;

data Mylib.saleDate_dim;
	merge Mylib.TPCEsaleDate_dimension Mylib.TPCWsaleDate_dimension
		Mylib.PECsaleDate_dimension;
	by sale_calendarYear sale_calendarMonth sale_calendarDay;
run;

proc sort data = Mylib.saleDate_dim nodupkey;
	by sale_calendarYear sale_calendarMonth sale_calendarDay;
run;

data Mylib.saleDate_dim;
	set Mylib.saleDate_dim;
	format saleDate_SK best12.;
	saleDate_SK = _N_;
	rename saleDate = saleDate_NK;
run;

data Mylib.saleDate_dim;
	retain saleDate_SK saleDate_NK sale_calendarYear sale_calendarQuarter sale_calendarMonth 
		sale_calendarWeek sale_calendarDay sale_fiscalYear sale_fiscalQuarter 
		sale_fiscalMonth sale_fiscalWeek sale_fiscalDay;
	set Mylib.saleDate_dim;
run;

proc export data=Mylib.saleDate_dim outfile = '/folders/myfolders/Lab03/saleDate_dim.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.orderDate_dim;
	set Mylib.PECorderDate_dimension;
run;

proc sort data = Mylib.orderDate_dim nodupkey;
	by order_calendarYear order_calendarMonth order_calendarDay;
run;

data Mylib.orderDate_dim;
	set Mylib.orderDate_dim;
	format orderDate_SK best12.;
	orderDate_SK = _N_;
	rename orderDate = orderDate_NK;
run;

data Mylib.orderDate_dim;
	retain orderDate_SK orderDate_NK order_calendarYear order_calendarQuarter 
		order_calendarMonth order_calendarWeek order_calendarDay order_fiscalYear 
		order_fiscalQuarter order_fiscalMonth order_fiscalWeek order_fiscalDay;
	set Mylib.orderDate_dim;
run;

proc export data=Mylib.orderDate_dim outfile = '/folders/myfolders/Lab03/orderDate_dim.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;

data Mylib.saleOrderAttributes_dim;
	set Mylib.PECinvoice (keep = shippingMethod orderMethod paymentMethod);
run;

proc sort data = Mylib.saleOrderAttributes_dim nodupkey;
	by shippingMethod orderMethod paymentMethod;
run;

data Mylib.saleOrderAttributes_dim;
	set Mylib.saleOrderAttributes_dim;
	format saleOrderAttributes_SK best12.;
	saleOrderAttributes_SK = _N_;
run;

data Mylib.saleOrderAttributes_dim;
	retain saleOrderAttributes_SK shippingMethod orderMethod paymentMethod;
	set Mylib.saleOrderAttributes_dim;
run;

proc export data=Mylib.saleOrderAttributes_dim outfile = '/folders/myfolders/Lab03/saleOrderAttributes_dim.csv' 
	dbms=dlm replace;
	delimiter = ',';
run;