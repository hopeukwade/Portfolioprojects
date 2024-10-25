SELECT *
  FROM  [portfolio].[dbo].[Nashville Housing]


  --standardize Data format

  select SaleDateConverted, CONVERT(Date,SaleDate)
  from [portfolio].[dbo].[Nashville Housing]

  Update [Nashville Housing]
  SET SaleDate = CONVERT(Date,SaleDate)

  ALTER TABLE[Nashville Housing]
  Add SaleDateConverted Date;

  Update [Nashville Housing]
  SET SaleDateConverted = CONVERT(Date,SaleDate)

  --Populate Property Address data
  Select *
  from [portfolio].[dbo].[Nashville Housing]
  --where PropertyAddress is null
  order by ParcelID

 Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
  from [portfolio].[dbo].[Nashville Housing] a
  JOIN [portfolio].[dbo].[Nashville Housing] b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
  where a.PropertyAddress is null

  Update a
  SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
  from [portfolio].[dbo].[Nashville Housing] a
  JOIN [portfolio].[dbo].[Nashville Housing] b
    ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
	where a.PropertyAddress is null

	--Breaking out Address into Individual Columns9Adress,City,State)
	Select PropertyAddress
	from [portfolio].[dbo].[Nashville Housing]
	--where PropertyAddress is null
	--order by ParcelID

	SELECT
	SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1 ) as Address 
	, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress)) as Address
	from [portfolio].[dbo].[Nashville Housing]

	ALTER TABLE[Nashville Housing]
  Add PropertySplitAddress Nvarchar(255);

  Update [Nashville Housing]
  SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1 ) 

  ALTER TABLE[Nashville Housing]
  Add PropertySplitCity Nvarchar(255);

  Update [Nashville Housing]
  SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))

  select *
  from [portfolio].[dbo].[Nashville Housing]

  select OwnerAddress
  from [portfolio].[dbo].[Nashville Housing]

 SELECT
 PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)
 ,PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)
 ,PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
  from [portfolio].[dbo].[Nashville Housing]

  ALTER TABLE[Nashville Housing]
  Add OwnerSplitAddress Nvarchar(255);

  Update [Nashville Housing]
  SET OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) 

  ALTER TABLE[Nashville Housing]
  Add OwnerSplitCity Nvarchar(255);

  Update [Nashville Housing]
  SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

  ALTER TABLE[Nashville Housing]
  Add OwnerSplitState Nvarchar(255);

  Update [Nashville Housing]
  SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1) 

  Select *
  from [portfolio].[dbo].[Nashville Housing] 

  --Change 0 and 1 to Yes and No in 'Sold as Vacant' Field

  Select Distinct(SoldAsVacant),Count(SoldAsVacant)
 from[portfolio].[dbo].[Nashville Housing]
 Group by SoldAsVacant
 Order by 2

 ALTER TABLE [Nashville Housing]
 ALTER COLUMN SoldAsVacant Nvarchar(50);

Update [Nashville Housing]
SET SoldAsVacant = CASE when SoldAsVacant = 0 THEN 'No'
       when SoldAsVacant = 1 THEN 'Yes'
	   ELSE SoldAsVacant
	   END 

 SELECT *
 FROM [portfolio].[dbo].[Nashville Housing]

 --Delete unused columns

 SELECT *
 FROM [portfolio].[dbo].[Nashville Housing]

 ALTER TABLE [portfolio].[dbo].[Nashville Housing]
 DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

  ALTER TABLE [portfolio].[dbo].[Nashville Housing]
 DROP COLUMN SaleDate