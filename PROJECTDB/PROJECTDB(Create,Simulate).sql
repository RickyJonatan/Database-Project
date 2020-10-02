/*
 * Kelompok 7 / Kelompok G
 * 1. William Suryadi       - 2201742135
 * 2. Ricky Jonatan         - 2201772472
 * 3. Osvaldo Richie Riady  - 2201823290
 * 4. Louis Raymond         - 2201849535
 */

IF DB_ID('Project') IS NOT NULL
	BEGIN
		PRINT 'Database Project Exists';
		SET NOEXEC ON;
	END
ELSE
	BEGIN
		CREATE DATABASE Project;
	END

GO
USE Project;


/* TABLE AND COLUMN CREATION */

/*
 * LEGEND:
 * TABLE Studio - Line 44
 * TABLE Movie  - Line 54
 * TABLE ScheduleTrans - Line 65
 * Table Staff - Line 79
 * Table MovieTrans - Line 97
 * Table RefreshmentType - Line 110
 * Table Refreshment - Line 117
 * Table RefreshmentTrans - Line 130
 * Note 1 (Staff name must be between 7 and 30 characters) - Line 89
 * Note 2 (Staff’s age must be more than or equal to 18) - Line 91
 * Note 3 (Staff gender must be either “Male” or “Female” (without quote)) - Line 93
 * Note 4 (Refreshment stock must be more than 50) - Line 125
 * Note 5 (Studio price must be between 35000 and 65000) - Line 50
 * Note 6 (Movie duration must be less than equal to 240 minutes) - Line 61
 * Note 7 (Schedule movie must be at least 7 days ahead of present time) - Line 72
 */

CREATE TABLE Studio(
	studioID VARCHAR(255)  PRIMARY KEY,
	studioName VARCHAR(255),
	studioPrice INT,

	CONSTRAINT vStudio CHECK (studioID LIKE 'ST[0-9][0-9][0-9]'),
	-- Note 5: Studio price must be between 35000 and 65000.
	CONSTRAINT PriceStudio CHECK (studioPrice BETWEEN 35000 AND 65000)
);

CREATE TABLE Movie(
	movieID VARCHAR(255) PRIMARY KEY,
	movieName VARCHAR(255),
	movieLicense INT,
	movieDuration INT,

	CONSTRAINT vMovie CHECK (movieID LIKE 'MV[0-9][0-9][0-9]'),
	-- Note 6: Movie duration must be less than equal to 240 minutes.
	CONSTRAINT DurationMovie CHECK (movieDuration <= 240)
);

CREATE TABLE ScheduleTrans(
	scheduleID VARCHAR(255)  PRIMARY KEY,
	movieID VARCHAR(255),
	studioID VARCHAR(255),
	showTime SMALLDATETIME,

	CONSTRAINT vScheduleTrans CHECK (scheduleID LIKE 'MS[0-9][0-9][0-9]'),
	-- Note 7: Schedule movie must be at least 7 days ahead of present time.
	CONSTRAINT MinimumDate CHECK (DATEDIFF(DD, GETDATE(), showTime) >= 7),

	FOREIGN KEY (movieID) REFERENCES Movie(movieID),
	FOREIGN KEY (studioID) REFERENCES Studio(studioID)
);

CREATE TABLE Staff(
	staffID VARCHAR(255)  PRIMARY KEY,
	staffName VARCHAR(255),
	staffEmail VARCHAR(255),
	staffGender VARCHAR(255),
	staffDob DATE,
	staffPhone VARCHAR(255),
	staffAdress VARCHAR(255),

	CONSTRAINT vStaff CHECK (staffID LIKE 'SF[0-9][0-9][0-9]'),
	-- Note 1: Staff name must be between 7 and 30 characters.
	CONSTRAINT NameStaff CHECK(LEN(StaffName) BETWEEN 7 AND 30),
	-- Note 2: Staff’s age must be more than or equal to 18.
	CONSTRAINT AgeMinimum CHECK(DATEDIFF(YY, staffDob, GETDATE()) >= 18),
	-- Note 3: Staff gender must be either “Male” or “Female” (without quote).
	CONSTRAINT GenderStaff CHECK(staffGender LIKE 'Male' OR staffGender LIKE 'Female'),
);

CREATE TABLE MovieTrans(
	movieTransID VARCHAR(255)  PRIMARY KEY,
	staffID VARCHAR(255),
	scheduleID VARCHAR(255),
	transactionMDate DATE,
	seatSold INT,

	CONSTRAINT vMovieTrans CHECK (movieTransID LIKE 'MTr[0-9][0-9][0-9]'),

	FOREIGN KEY (staffID) REFERENCES Staff(staffID),
	FOREIGN KEY (scheduleID) REFERENCES ScheduleTrans(scheduleID)
);

CREATE TABLE RefreshmentType(
	refreshmentTypeID VARCHAR(255)  PRIMARY KEY,
	refreshmentType VARCHAR(255),

	CONSTRAINT vRefreshmentType CHECK (refreshmentTypeID LIKE 'RT[0-9][0-9][0-9]')
);

CREATE TABLE Refreshment(
	refreshmentID VARCHAR(255)  PRIMARY KEY,
	refreshmentTypeID VARCHAR(255),
	refreshmentName VARCHAR(255),
	refreshmentPrice INT,
	refreshmentStock INT,

	CONSTRAINT vRefreshment CHECK (refreshmentID LIKE 'RE[0-9][0-9][0-9]'),
	-- Note 4: Refreshment stock must be more than 50.
	CONSTRAINT StockRefreshment CHECK (refreshmentStock > 50),
	FOREIGN KEY (refreshmentTypeID) REFERENCES RefreshmentType(refreshmentTypeID)
);

CREATE TABLE RefreshmentTrans(
	refreshmentTransID VARCHAR(255)  PRIMARY KEY,
	staffID VARCHAR(255),
	refreshmentID VARCHAR(255),
	quantitySold INT,
	transactionRDate DATE,

	CONSTRAINT vRefreshmentTrans CHECK (refreshmentTransID LIKE 'RTr[0-9][0-9][0-9]'),

	FOREIGN KEY (staffID) REFERENCES Staff(staffID),
	FOREIGN KEY (refreshmentID) REFERENCES Refreshment(refreshmentID)
);

/* DATA INSERTION */

INSERT INTO Movie VALUES
('MV001', 'Kafe'			,   '1', '90'),
('MV002', 'Theme'			,  '2', '100'),
('MV003', 'Oregon			', '3', '120'),
('MV004', 'Robin'			,  '4', '90'),
('MV005', 'Batman'			, '5', '120'),
('MV006', 'Jumanji'			, '6', '140'),
('MV007', 'Rainbow'			, '2', '100'),
('MV008', 'Tower'			, '3', '80'),
('MV009', 'Death or Alive'	, '2', '100'),
('MV010', 'Kpop Star'		, '6', '120'),
('MV011', 'Naruto'			, '4', '90'),
('MV012', 'Dora the Explorer', '2', '80'),
('MV013', 'Tokyo Drift'		, '1', '150'),
('MV014', 'Shoot or Die'	, '5', '115'),
('MV015', 'Pinky Boy'		, '7', '110');

INSERT INTO Studio VALUES
('ST001', 'Satin1', '35000'),
('ST002', 'Satin2', '40000'),
('ST003', 'Satin3', '50000'),
('ST004', 'Satin4', '60000'),
('ST005', 'Satin5', '30000'),
('ST006', 'Satin2', '65000'),
('ST007', 'Satin3', '55000'),
('ST008', 'Satin4', '35000'),
('ST009', 'Satin6', '65000'),
('ST010', 'Satin2', '50000'),
('ST011', 'Satin1', '55000'),
('ST012', 'Satin5', '40000'),
('ST013', 'Satin5', '75000'),
('ST014', 'Satin6', '55000'),
('ST015', 'Satin3', '45000');

INSERT INTO ScheduleTrans VALUES
('MS001', 'MV001', 'ST001', '2020-02-14 12:00:00 AM'),
('MS002', 'MV002', 'ST002', '2020-02-21 1:00:00 PM'),
('MS003', 'MV003', 'ST003', '2020-03-22 1:00:00 PM'),
('MS004', 'MV004', 'ST004', '2020-03-23 3:00:00 PM'),
('MS005', 'MV005', 'ST005', '2020-03-24 4:00:00 PM'),
('MS006', 'MV006', 'ST006', '2020-03-25 5:00:00 PM'),
('MS007', 'MV007', 'ST007', '2020-03-26 2:00:00 PM'),
('MS008', 'MV008', 'ST008', '2020-03-27 6:00:00 PM'),
('MS009', 'MV009', 'ST009', '2020-03-28 7:05:00 PM'),
('MS010', 'MV010', 'ST010', '2020-03-29 4:00:00 PM'),
('MS011', 'MV011', 'ST011', '2020-04-01 11:00:00 AM'),
('MS012', 'MV012', 'ST012', '2020-04-02 10:00:00 AM'),
('MS013', 'MV013', 'ST013', '2020-04-03 6:00:00 PM'),
('MS014', 'MV002', 'ST004', '2020-04-04 7:20:00 PM'),
('MS015', 'MV015', 'ST001', '2020-04-05 8:00:00 PM'),
('MS016', 'MV014', 'ST004', '2020-04-04 10:00:00 PM'),
('MS017', 'MV014', 'ST007', '2020-04-10 11:00:00 PM'),
('MS018', 'MV009', 'ST009', '2020-05-09 9:30:00 PM'),
('MS019', 'MV006', 'ST002', '2020-06-08 8:10:00 PM'),
('MS020', 'MV004', 'ST003', '2020-07-07 7:15:00 PM'),
('MS021', 'MV006', 'ST012', '2020-08-04 9:00:00 AM'),
('MS022', 'MV007', 'ST011', '2020-09-04 10:10:00 AM'),
('MS023', 'MV008', 'ST010', '2020-10-06 7:40:00 PM'),
('MS024', 'MV011', 'ST008', '2020-11-05 7:45:00 PM'),
('MS025', 'MV012', 'ST009', '2020-12-14 7:55:00 PM');

INSERT INTO Staff VALUES
('SF001', 'Twistor Kellyson',       'twist99@hypertwisted.id',   'Female', '1990-12-01', '081234567890', 'Twin St.'),
('SF002', 'Zoff Frank',	            'zoff842@yahoo.com',         'Male',   '1994-02-02', '081234567891', 'Zapper St.'),
('SF003', 'Jaggerstone Klausetine', 'jaggy.k@klausecloud.co.uk', 'Male',   '1987-12-11', '081234567892', 'Jaggernaut St.'),
('SF004', 'Strandstein Gorgon',     'strands@gmail.com',         'Male',   '1990-06-17', '081234567893', 'Leopard St.'),
('SF005', 'Jessica Kendra',         'jkendra@mail.com',          'Female', '1992-02-02', '081234567894', 'Highway St.'),
('SF006', 'Desti Iskandar',         'diskandar@mail.com',        'Female', '1999-07-19', '081234567895', 'Stanford St.'),
('SF007', 'Jessica Iskandar',       'jeskandar@mail.com',        'Female', '1999-07-19', '081234567895', 'Kebayoran St.'),
('SF008', 'Christian Tanu',         'christan@gmail.com',		'Male',	 '1999-07-19', '081234567555', 'Palmerah St.'),
('SF009', 'Juan Atipa',				'atipa@mail.com',			'Male'	,'1999-07-19', '081234564444', 'Kangkung St.'),
('SF010', 'Melvin Lee',				'MelLee@mail.com',			'Male'	, '1999-07-19', '081234567231', 'Bayam St.'),
('SF011', 'Nicky Lee',				'NickL@mail.com',			'Male'	, '1999-07-19', '081234569876', 'Mangga St.'),
('SF012', 'Marsha Law',				'Law@mail.com',				'Male'	, '1999-07-19', '081234560293', 'Hero St.'),
('SF013', 'Frost Trap',				'Ftrap@mail.com',			'Female', '1999-07-19', '081234569876', 'Markisa St.'),
('SF014', 'Lesion Gu',				'Lgu@mail.com',				'Male'	, '1999-07-19', '081234565674', 'Ancol St.'),
('SF015', 'Caveira Capoiera',       'Cavcapo@mail.com',			 'Female', '1999-07-19', '081234562341', 'Jumanji St.');

INSERT INTO MovieTrans VALUES
('MTr001', 'SF001', 'MS001', '2019-01-12', '9'),
('MTr002', 'SF002', 'MS002', '2019-01-01', '2'),
('MTr003', 'SF003', 'MS003', '2019-01-02', '7'),
('MTr004', 'SF004', 'MS004', '2020-01-04', '12'),
('MTr005', 'SF005', 'MS005', '2020-01-05', '20'),
('MTr006', 'SF006', 'MS006', '2020-01-06', '5'),
('MTr007', 'SF007', 'MS007', '2020-01-07', '14'),
('MTr008', 'SF008', 'MS008', '2020-01-08', '3'),
('MTr009', 'SF009', 'MS009', '2020-01-09', '50'),
('MTr010', 'SF010', 'MS010', '2020-01-10', '25'),
('MTr011', 'SF011', 'MS011', '2020-01-11', '21'),
('MTr012', 'SF012', 'MS012', '2020-01-12', '11'),
('MTr013', 'SF013', 'MS013', '2020-01-13', '80'),
('MTr014', 'SF014', 'MS014', '2020-01-14', '99'),
('MTr015', 'SF015', 'MS015', '2020-01-15', '88'),
('MTr016', 'SF011', 'MS016', '2020-02-15', '65'),
('MTr017', 'SF011', 'MS017', '2020-03-15', '40'),
('MTr018', 'SF001', 'MS018', '2020-04-15', '50'),
('MTr019', 'SF006', 'MS019', '2020-05-15', '89'),
('MTr020', 'SF013', 'MS020', '2020-06-15', '40'),
('MTr021', 'SF010', 'MS021', '2020-07-15', '67'),
('MTr022', 'SF010', 'MS022', '2020-01-15', '43'),
('MTr023', 'SF005', 'MS023', '2020-01-15', '65'),
('MTr024', 'SF009', 'MS024', '2020-01-15', '59'),
('MTr025', 'SF005', 'MS025', '2020-01-15', '90');

INSERT INTO RefreshmentType VALUES
('RT001', 'Coffee'),
('RT002', 'Soda'),
('RT003', 'Juice'),
('RT004', 'Tea'),
('RT005', 'Other Beverages'),
('RT006', 'Western Food'),
('RT007', 'Heavy Snacks'),
('RT008', 'Traditional Food'),
('RT009', 'Eastern Food'),
('RT010', 'Light Snacks');

INSERT INTO Refreshment VALUES
('RE001', 'RT001', 'Nescafe'	,   '15000',  '215'),
('RE002', 'RT002', 'Fanta'		,   '20000',  '140'),
('RE003', 'RT003', 'Apple'		,   '30000',  '90'),
('RE004', 'RT004', 'Fruit Tea'	,	'30000',  '190'),
('RE005', 'RT006', 'Steak'		,   '100000', '60'),
('RE006', 'RT003', 'Melon '		,   '60000',  '600'),
('RE007', 'RT003', 'Pear'		,   '60000',  '700'),
('RE008', 'RT004', 'Jasmine'	,   '40000',  '100'),
('RE009', 'RT002', 'Cola'		,   '10000',  '200'),
('RE010', 'RT005', 'Siomay'		,   '50000',  '100'),
('RE011', 'RT010', 'Candy'		,   '20000',  '200'),
('RE012', 'RT001', 'Latte'		,   '45000',  '400'),
('RE013', 'RT010', 'Nachos'		,   '55000',  '700'),
('RE014', 'RT007', 'Sausage'	,   '20000',  '1400'),
('RE015', 'RT010', 'Crisps'		,   '15000',  '2000'),
('RE016', 'RT010', 'Crackers'	,   '25000',  '2000');

INSERT INTO RefreshmentTrans VALUES
('RTr001', 'SF001', 'RE001', '27', '2019-12-12'),
('RTr002', 'SF002', 'RE002', '32', '2020-01-01'),
('RTr003', 'SF003', 'RE003', '41', '2020-01-02'),
('RTr004', 'SF005', 'RE004', '56', '2020-01-04'),
('RTr005', 'SF006', 'RE005', '12', '2020-01-05'),
('RTr006', 'SF004', 'RE006', '314', '2020-01-06'),
('RTr007', 'SF005', 'RE009', '20', '2020-02-23'),
('RTr008', 'SF006', 'RE008', '10', '2020-05-4'),
('RTr009', 'SF002', 'RE007', '71', '2020-07-22'),
('RTr010', 'SF003', 'RE011', '22', '2020-01-21'),
('RTr011', 'SF002', 'RE012', '67', '2020-01-5'),
('RTr012', 'SF011', 'RE010', '72', '2020-05-3'),
('RTr013', 'SF002', 'RE004', '21', '2020-12-15'),
('RTr014', 'SF012', 'RE004', '9', '2020-11-9'),
('RTr015', 'SF013', 'RE006', '39', '2020-01-6'),
('RTr016', 'SF005', 'RE013', '18', '2020-01-8'),
('RTr017', 'SF006', 'RE015', '20', '2020-10-7'),
('RTr018', 'SF015', 'RE012', '58', '2020-01-6'),
('RTr019', 'SF012', 'RE010', '40', '2020-04-14'),
('RTr020', 'SF013', 'RE016', '50', '2020-06-12'),
('RTr021', 'SF011', 'RE014', '178', '2020-07-27'),
('RTr022', 'SF010', 'RE012', '70', '2020-08-19'),
('RTr023', 'SF007', 'RE011', '40', '2020-09-19'),
('RTr024', 'SF009', 'RE010', '20', '2020-01-10'),
('RTr025', 'SF008', 'RE006', '90', '2020-01-1');


----------------SIMULATION-----------------------

--Jisoo dan Jennie ingin menonton film Jumanji jam 5 sore tanggal 25 maret 2020 dan harga 1 tiketnya  Rp. 65000  .studio yang menayangkan film jumanji adalah studio 6.

INSERT INTO Movie VALUES
('MV006', 'Jumanji'			,   '6', '140');



INSERT INTO ScheduleTrans VALUES
('MS006', 'MV006', 'ST006', '2020-03-25 5:00:00 PM');


INSERT INTO Studio VALUES
('ST006', 'Satin2', '65000');

--Staff yang melayani Jisoo dan Jennie adalah Desti Iskandar dan kursi yang terjual hanya 2 yaitu untuk Jisoo dan Jennie .

INSERT INTO MovieTrans VALUES
('MTr006', 'SF006', 'MS006', '2020-03-25', '2');

-- Sebelum mulai bioskop Jisoo dan Jennie ingin membeli cemilan yang akan menemani mereka saat film dimulai,mereka ingin membeli 2 latte dan 2 steak
INSERT INTO RefreshmentType VALUES
('RT001', 'Coffee'),
('RT006', 'Western Food');


INSERT INTO Refreshment VALUES
('RE012', 'RT001', 'Latte'		,   '45000',  '400'),
('RE005', 'RT006', 'Steak'		,   '100000', '60');

--Staff yang Melayani mereka adalah Zoff Frank
INSERT INTO RefreshmentTrans VALUES
('RTr011', 'SF002', 'RE012', '2', '2020-03-25'),
('RTr005', 'SF002', 'RE005', '2', '2020-03-25');

--Stock diupdate karena berkurang 2
Update Refreshment
Set refreshmentStock = 398
Where refreshmentID = 'RE012'
Update Refreshment
Set refreshmentStock = 58
Where refreshmentID = 'RE005'





SET NOEXEC OFF;