create table Model (
	modelID int identity(1,1),
    make varchar(50),
    model varchar(50),
    color varchar(50),	
    year int,
    upholsteryStyle varchar(50),
    constraint pk_modelID primary key(modelID)
);
insert into Model (modelID, make, model, color, year) values (default, 'Jaguar', 'UX', 'Black', 1997);
insert into Model (modelID, make, model, color, year, upholsteryStyle) values (default, 'Mercedes Benz', 'JL', 'Red', 1997, 'Leather');

create table ProspectiveCustomer (
	prospectiveCustomerNo int identity(1,1),
    name varchar(50),
    address varchar(50),
    phoneNumber numeric,
    constraint pk_prospectiveCustomerNo primary key(prospectiveCustomerNo)
);
insert into ProspectiveCustomer (prospectiveCustomerNo, name, address, phoneNumber) values (default, 'Same Molare', '45 Main Street', 4128564510);
insert into ProspectiveCustomer (prospectiveCustomerNo, name, address, phoneNumber) values (default, 'Daffy Duck', '12 Hunter Street', 4531028460);

create table Customer (
	custID numeric identity(1,1),
	name varchar(50),
	address varchar(50),
	city varchar(50),
	state varchar(50),
	postCode varchar(50),
	workPhone varchar(50),
	homePhone varchar(50),
	constraint pk_custID primary key(custID)
);
insert into Customer (custID, name, address, city, state, postCode, workPhone, homePhone) values (default, 'Bugs Bunny', '24 Carrot Lane', 'Looneyville', 'California', '555555', 8904535421);
insert into Customer (custID, name, address, city, state, postCode, workPhone, homePhone) values (default, 'Elmer Fudd', '319 Befuddle Street', 'Looneyville', 'California', '00000', 891456445);

create table Insurance (
	insuranceID int identity(1,1),
	fireTheft bit,
	collision bit,
	liability bit,
	propertyDamage bit,
	constraint pk_insuranceID primary key(insuranceID)
);
insert into Insurance (insuranceID, fireTheft, collision, liability, propertyDamage) values (default, 1, 0, 0, 1);
insert into Insurance (insuranceID, fireTheft, collision, liability, propertyDamage) values (default, 1, 1, 0, 0);

create table Job (
	jobID int identity(1,1),
    title varchar(50),
    constraint pk_jobID primary key(jobID)
);
insert into Job (jobID, title) values (default, 'General Manager');
insert into Job (jobID, title) values (default, 'Assistant Manager');

create table Part (
    serialNo varchar(50),
    cost numeric,
    sale numeric,
    constraint pk_serialNo primary key(serialNo)
);
insert into Part (serialNo, cost, sale) values ('R63', 120.00, 140.00);
insert into Part (serialNo, cost, sale) values ('S24', 320.00, 349.00);

create table SalesInvoice (
	salesInvoiceNo varchar(50),
	date date,
	custID int,
	empID int,
	constraint pk_salesInvoiceNo primary key(salesInvoiceNo),
	constraint fk_custID foreign key(custID) references Customer(custID),	
	constraint fk_empID foreign key(empID) references Employee(empID)
);
insert into SalesInvoice (salesInvoiceNo, date, custID, empID) values ('S1239', '1997-14-01', 1, 2);
insert into SalesInvoice (salesInvoiceNo, date, custID, empID) values ('S1252', '1997-28-01', 2, 1);

create table SalesInvoiceInsurance (
	insuranceID int,
	salesInvoiceNo varchar(50),
    constraint pk primary key(salesInvoiceNo, insuranceID),
	constraint fk_salesInvoiceNo foreign key(salesInvoiceNo) references SalesInvoice(salesInvoiceNo),
    constraint fk_insuranceID foreign key(insuranceID) references Insurance(insuranceID)
);
insert into SalesInvoiceInsurance (insuranceID, salesInvoiceNo) values (1, 'S1239');
insert into SalesInvoiceInsurance (insuranceID, salesInvoiceNo) values (2, 'S1252');

create table SalesInvoiceCar (
	salesInvoiceNo int,
    serialNo varchar(50),
    allowance numeric,
	constraint pk primary key(salesInvoiceNo, serialNo),
	constraint fk_salesInvoiceNo foreign key(salesInvoiceNo) references SalesInvoice(salesInvoiceNo),
    constraint fk_serialNo foreign key(serialNo) references Car(serialNo)
);
insert into SalesInvoiceCar (salesInvoiceNo, serialNo, allowance) values ('S1239', 'J97UX301', 13000.00);
insert into SalesInvoiceCar (salesInvoiceNo, serialNo, allowance) values ('S1252', 'M97CL701', 5000.00);

create table Employee (
	empID int identity(1,1),
    firstName varchar(50),
    lastName varchar(50),
    jobID int,
    constraint pk_empID primary key(empID),
    constraint fk_jobID foreign key(jobID) references Job(jobID)
);
insert into Employee(empID, firstName, lastName, jobID) values (default, 'Maurice', 'Risner', 1);
insert into Employee(empID, firstName, lastName, jobID) values (default, 'Artur', 'Hrytsenko', 2);	

create table AddOnOption (
	code varchar(50),
    description varchar(200),
    listPrice numeric,
    constraint pk_code primary key(code)
);
insert into AddOnOptions(code, description, listPrice) values ('S24', 'Sunroof', 349.00);
insert into AddOnOptions(code, description, listPrice) values ('R63', 'Stereo Radio', 140.00);

create table SalesInvoiceOption (
	code varchar(50),
    salesInvoiceNo varchar(50),
    constraint pk primary key(code, salesInvoiceNo),
    constraint fk_code foreign key(code) references AddOnOption(code),
    constraint fk_salesInvoiceNo foreign key(salesInvoiceNo) references SalesInvoice(salesInvoiceNo)
);
insert into SalesInvoiceOption (code, salesInvoiceNo) values ('S24', 'S1239');
insert into SalesInvoiceOption (code, salesInvoiceNo) values ('S24', 'S1252');

create table VehicleInventoryRecord (
	vehicleInventoryRecordNo int identity(1,1),
    salesInvoiceNo varchar(50),
    constraint pk_vehicleInventoryRecordNo primary key(vehicleInventoryRecordNo),
    constraint fk_salesInvoiceNo foreign key(salesInvoiceNo) references SalesInvoice(salesInvoiceNo)
);
insert into VehicleInventoryRecord (vehicleInventoryRecordNo, salesInvoice) values (default, 'S1239'); 
insert into VehicleInventoryRecord (vehicleInventoryRecordNo, salesInvoice) values (default, 'S1252'); 

create table ServiceWorkOrder (
	serviceWorkOrderID varchar(50),
    serialNo varchar(50),
    custNo int,
    date date,
    workToBeDone varchar(250),
    constraint pk_serviceWorkOrderID primary key(serviceWorkOrderID),
    constraint fk_carSerialNo foreign key(carSerialNo) references Car(serialNo),
    constraint fk_custID foreign key(custID) references Customer(custID)
);
insert into ServiceWorkOrder (serviceWorkOrderID, serialNo, custNo, date, workToBeDone) values ('W22772', 'J34865', 1, '1997-05-11', 'oil change');
insert into ServiceWorkOrder (serviceWorkOrderID, serialNo, custNo, date, workToBeDone) values ('W21642', 'J34865', 1, '1997-02-11', 'Find squeak');

create table PartsServiceWorkOrder (
	serviceWorkOrderID varchar(50), -- to ServiceWorkORder
	serialNo varchar(50),-- to parts
	constraint fk_serialNo foreign key(serialNo) references Part(serialNo),
	constraint fk_serviceWorkOrderID foreign key(serviceWorkOrderID) references ServiceWorkOrder(serviceWorkOrderID)
);
insert into PartsServiceWorkOrder (serviceWorkOrderID, serialNo) values ('W22772', 'R63');
insert into PartsServiceWorkOrder (serviceWorkOrderID, serialNo) values ('W21642', 'S24');

create table ServiceLog (
	serviceLogID int identity(1,1),
    serviceWorkOrderID varchar(50),
    constraint pk_serviceLogID primary key(serviceLogID),
    constraint fk_serviceWorkOrderID foreign key(serviceWorkOrderID) references ServiceWorkOrder(serviceWorkOrderID)
);
insert into ServiceLog (serviceLogID, serviceWorkOrderID) values (default, 'W22772');
insert into ServiceLog (serviceLogID, serviceWorkOrderID) values (default, 'W21642');

create table ProspectiveCustomerModel (
	    modelID int,
        prospectiveCustomerNo int,
        constraint pk primary key(modelID, prospectiveCustomerNo),
        constraint fk_modelID foreign key(modelID) references Model(modelID),
        constraint fk_prospectiveCustomerNo foreign key(prospectiveCustomerNo) references ProspectiveCustomer(prospectiveCustomerNo)
);
insert into ProspectiveCustomerModel (modelID, prospectiveCustomerNo) values (1, 2);
insert into ProspectiveCustomerModel (modelID, prospectiveCustomerNo) values (2, 1);

create table Car (
	serialNo varchar(50),
    modelID int,
    tradeInStatus bit,
    constraint pk_serialNo primary key(serialNo),
    constraint fk_modeID foreign key(modelID) references Model(modelID)
);
insert into Car (serialNo, modelID, tradeInStatus) VALUES ('J97UX301', 1, 0);
insert into Car(serialNo, modelID, tradeInStatus) VALUES ('M97CL701', 2, 1);
