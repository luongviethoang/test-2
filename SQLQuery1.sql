create database HighlandsCoffee
go
use HighlandsCoffee
go
create table Provinces (
	ProvinceID int primary key,
	ProvinceName nvarchar(200)
)
go
create table District(
	DistrictID int primary key,
	DistrictName nvarchar(300),
	ProvinceID int foreign key references Provinces(ProvinceID)
)
go
create table Utilities (
	UtilitiesID int primary key,
	UtilitiesName nvarchar(200)
)
go
create table HighLandsCoffeeStore (
	StoreName nvarchar(400) primary key,
	ProvincesID int foreign key references Provinces(ProvinceID),
	DistrictID int foreign key references District(DistrictID),
	Address nvarchar(400),
	UtilitiesID　int foreign key references Utilities(UtilitiesID)
)
insert into Provinces(ProvinceID, ProvinceName)
	values
		(29, N'Hà Nội'),
		(35, N'Ninh Bình'),
		(50, N'Thành Phố Hồ Chí Minh')
select * from Provinces where ProvinceName = N'Hà Nội'
insert into District(ProvinceID, DistrictID, DistrictName)
	values
		(29, 01, N'Hà Đông'),
		(29, 02, N'Thanh Xuân'),
		(29, 03, N'Cầu Giấy'),
		(35, 04, N'Thành Phố Ninh Bình'),
		(50, 05, N'Quận 1'),
		(50, 06, N'Quận 10'),
		(50, 07, N'Quận Bình Thạnh')
select * from District
insert into  Utilities(UtilitiesID, UtilitiesName)
	values
		(1, N'Wifi miễn phí'),
		(2, N'Thanh toán bằng thẻ'),
		(3, N'Wifi miễn phí và Thanh toán bằng thẻ')
select * from Utilities
insert into HighLandsCoffeeStore(StoreName, ProvincesID, DistrictID, Address ,UtilitiesID)
	values
		(N'Highlands Coffee Nguyễn Văn Lộc', 29, 01, N'16b2 Nguyễn Văn Lộc', 3),
		(N'Highlands Coffee AEON MALL Hà Đông', 29, 01, N'AEON MALL Dương Nội, Hà Đông', 3),
		(N'Highlands Coffee Phúc Thành', 35, 04, N'12b Phúc Thành, Tp.Ninh Bình', 1),
		(N'Highlands Coffee Nguyễn Bỉnh Khiêm', 50, 05, N'16a Nguyễn Bỉnh Khiêm', 3),
		(N'Highlands Coffee Nguyễn Chí Thanh', 50, 06, N'21b2 Nguyễn Chí Thanh', 2),
		(N'Highlands Coffee Đinh Tiên Hoàng', 50, 07, N'82b Đinh Tiên Hoàng', 3)
select * from HighlandsCoffeeStore
-- Truy Vấn
	-- Truy vấn tới các quán ở Hà Nội 
	select StoreName from HighlandsCoffeeStore
	where ProvincesID in (
		select ProvinceID from Provinces
		where ProvinceName like N'Hà Nội%'
	)
	-- Truy vấn tới các quán ở quận 1 Tp.HCM
	select StoreName from HighLandsCoffeeStore
	where ProvincesID in (
		select ProvinceID from Provinces
		where ProvinceName like N'Thành Phố Hồ Chí Minh%'
	)
	and DistrictID in (
		select DistrictID from District
		where DistrictName like N'Quận 1'
	)
	-- Truy vấn tới các quán có tiện ích wifi miễn phí
	select StoreName from HighLandsCoffeeStore
	where UtilitiesID in (
		select UtilitiesID from Utilities
		where UtilitiesName like N'Wifi miễn phí%'
	)