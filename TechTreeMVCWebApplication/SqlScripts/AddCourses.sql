  use [TechTree]
  
  --Initialise database
IF EXISTS (SELECT * FROM [dbo].Content)
BEGIN  
  Delete from [dbo].Content
  DBCC CHECKIDENT (Content, RESEED, 0)
END

IF EXISTS (SELECT * FROM [dbo].[CategoryItem])
BEGIN 
 Delete FROM [dbo].[CategoryItem]
 DBCC CHECKIDENT ([CategoryItem], RESEED, 0)
END

IF EXISTS (SELECT * FROM [dbo].[MediaType]) 
BEGIN
  Delete from [dbo].MediaType
  DBCC CHECKIDENT ([MediaType], RESEED, 0)
END
if EXISTS(SELECT * FROM [dbo].[Category])
BEGIN
  Delete from [dbo].[Category]
  DBCC CHECKIDENT ([Category], RESEED, 0)
END  
    --Populate database with default values
if EXISTS(SELECT * FROM [dbo].[UserCategory])
BEGIN
  Delete from [dbo].UserCategory
  DBCC CHECKIDENT (UserCategory, RESEED, 0)
END

  --Populate media types
  INSERT INTO [dbo].[MediaType]
           ([Title]
           ,[ThumbnailImagePath])
     VALUES
           ('Article',
		   '/images/ArticleImage.jpeg')
GO
INSERT INTO [dbo].[MediaType]
           ([Title]
           ,[ThumbnailImagePath])
     VALUES
           ('Video',
		   '/images/VideoImage.jpeg')
GO
  --Categories
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('C# for Beginners', 'C# Beginners Course', '/images/CsharpBeginners.jpeg')
GO
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Advanced C#', 'Advanced C# Course', '/images/AdvancedCSharp.jpeg')
GO
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Azure', 'Azure Cloud Course', '/images/AzureCloud.jpeg')
GO
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Fullstack Development Course', 'Fullstack development course', '/images/FullStackDev.jpeg')
GO
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('JavaScript Beginners Course', 'JavaScript beginners course', '/images/JavaScriptBeginners.jpeg')
GO 
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Responsive Web Design', 'Responsive web design course', '/images/ResponsiveWebDesign.jpeg')
 GO 
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('SQL Server for Beginners', 'SQL Server beginners course', '/images/SqlServerBeginners.jpeg')
GO  
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('.NET MAUI for Beginners', '.NET MAUI begginers course', '/images/Mobile.jpeg')

  --Category Items
GO
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Introduction to C#', 'This tutorial introduces a learner to the C# language', 1, 2, GetDate())
GO
  Insert Into .[dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('C# Data Types', 'This tutorial introduces a learner to C# data types', 1, 2, GetDate())
GO
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('C# Variables', 'This tutorial introduces a learner to C# variables', 1, 2, GetDate())
GO
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Advanced C#', 'Introduction to Avanced C# Concepts',2,2, GetDate())
GO
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Azure', 'Introduction to Azure Cloud',3,2, GetDate())
GO  
Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Fullstack Development Course', 'Introduction to fullStack concepts',4,2, GetDate())
GO
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('JavaScript Development for Beginners', 'Introduction to beginner JavaScript concepts',5,2, GetDate())
GO 
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Responsive Web Design for Beginners', 'Introduction to responsive web design concepts', 6, 2, GetDate())
GO  
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('SQL Server for Beginners', 'Introduction to SQL Server concepts', 7, 2, GetDate())
GO  
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('.NET MAUI for Beginners', 'Introduction to .NET MAUI begginer concepts',8,2, GetDate())
GO
 Insert into [dbo].[Content]
      ([Title]
      ,[HTMLContent]
      ,[VideoLink]
      ,[CategoryItemId])
  Values('C# for Beginners','<h1>C# for Beginners</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 1)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('C# Data Types','<h1>C# Data Types</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 2)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('C# Variables','<h1>C# Variables</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 3)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Advanced C# Concepts','<h1>Introduction to Advanced C# Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 4)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Azure','<h1>Introduction to Azure Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 5)
GO

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Fullstack Development Course','<h1>Introduction to Fullstack Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 6)

GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to JavaScript','<h1>Introduction to begginer JavaScript concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 7)
GO

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Responsive Web Design','<h1>Introduction to responsive web design concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 8)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to SQL Server','<h1>Introduction to SQL Server begginer concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 9)
GO
Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('.NET MAUI for Beginners','<h1>Introduction to .NET MAUI for Beginners concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 10)
GO
