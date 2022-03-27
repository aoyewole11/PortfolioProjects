/*
Cleaning Data 
*/
Select * from NashvilleHousing

-------------------------------------------------
--Standardize Date Format
--didnt work
--Select SaleDate--, CAST(SaleDate as Date)
--From NashvilleHousing

--Update NashvilleHousing
--Set SaleDate = convert(Date,SaleDate) --CAST(SaleDate as Date)

Alter table nashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = CAST(SaleDate as Date)
Select SaleDateConverted from NashvilleHousing


--Populate Property Address Data

Select * from NashvilleHousing
--where PropertyAddress is null
order by 2


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing as A 
join NashvilleHousing as B
on a.ParcelID =b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


Update A
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing as A 
join NashvilleHousing as B
on a.ParcelID =b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-------------------------------------------------------------------------------
--Breaking out Address into individual columns (Address, City, State)

Select 

SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress) ) as Address

from NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1)


Alter Table NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress) )

------------------------------------------------------
--OWNER ADDRESS USING PARSE NAME IS EASIER

Select 
PARSENAME(REPLACE(OwnerAddress, ',','.'), 3 ),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 2 ),
PARSENAME(REPLACE(OwnerAddress, ',','.'), 1 )

from NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
set OwnerSplitAddress= PARSENAME(REPLACE(OwnerAddress, ',','.'), 3 )


Alter Table NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2 )

Alter Table NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1 )

-------------------------------------------------
--Change Y and N to Yes and No in "Sold as vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
FROM NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant,
Case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end

FROM NashvilleHousing

Update NashvilleHousing
set SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end
	from NashvilleHousing


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From NashvilleHousing


ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate



