  use [TechTree]

  --Initialise database

  Delete from [dbo].MediaType

  DBCC CHECKIDENT ([MediaType], RESEED, 0)

    Delete from [dbo].Content

  DBCC CHECKIDENT (Content, RESEED, 0)

  Delete FROM [dbo].[CategoryItem]
  
  DBCC CHECKIDENT ([CategoryItem], RESEED, 0)
  
  Delete from [dbo].[Category]

  DBCC CHECKIDENT ([Category], RESEED, 0)

  
    --Populate database with default values

  Delete from [dbo].UserCategory

 DBCC CHECKIDENT (UserCategory, RESEED, 0)

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

  --Categories
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('C# for Beginners', 'C# Beginners Course', '/images/CsharpBeginners.jpeg')

  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Advanced C#', 'Advanced C# Course', '/images/AdvancedCSharp.jpeg')

  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Azure', 'Azure Cloud Course', '/images/AzureCloud.jpeg')

  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Fullstack Development Course', 'Fullstack development course', '/images/FullStackDev.jpeg')

  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('JavaScript Beginners Course', 'JavaScript beginners course', '/images/JavaScriptBeginners.jpeg')
 
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('Responsive Web Design', 'Responsive web design course', '/images/ResponsiveWebDesign.jpeg')
  
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('SQL Server for Beginners', 'SQL Server beginners course', '/images/SqlServerBeginners.jpeg')
  
  Insert Into [dbo].[Category] ([Title], [Description], [ThumbnailImagePath])
  VALUES ('.NET MAUI for Beginners', '.NET MAUI begginers course', '/images/Mobile.jpeg')

  --Category Items

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Introduction to C#', 'This tutorial introduces a learner to the C# language', 1, 2, GetDate())

  Insert Into .[dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('C# Data Types', 'This tutorial introduces a learner to C# data types', 1, 2, GetDate())

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('C# Variables', 'This tutorial introduces a learner to C# variables', 1, 2, GetDate())

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Advanced C#', 'Introduction to Avanced C# Concepts',2,2, GetDate())

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Azure', 'Introduction to Azure Cloud',3,2, GetDate())

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Fullstack Development Course', 'Introduction to fullStack concepts',4,2, GetDate())

  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('JavaScript Development for Beginners', 'Introduction to beginner JavaScript concepts',5,2, GetDate())
 
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('Responsive Web Design for Beginners', 'Introduction to responsive web design concepts', 6, 2, GetDate())
  
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('SQL Server for Beginners', 'Introduction to SQL Server concepts', 7, 2, GetDate())
  
  Insert Into [dbo].[CategoryItem] ([Title], [Description], [CategoryId], [MediaTypeId],[DateTimeItemReleased])
  VALUES ('.NET MAUI for Beginners', 'Introduction to .NET MAUI begginer concepts',8,2, GetDate())


 Insert into [dbo].[Content]
      ([Title]
      ,[HTMLContent]
      ,[VideoLink]
      ,[CategoryItemId])
  Values('C# for Beginners','<h1>C# for Beginners</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 1)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('C# Data Types','<h1>C# Data Types</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 2)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('C# Variables','<h1>C# Variables</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 3)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Advanced C# Concepts','<h1>Introduction to Advanced C# Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 4)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Azure','<h1>Introduction to Azure Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 5)


Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Fullstack Development Course','<h1>Introduction to Fullstack Concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 6)


Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to JavaScript','<h1>Introduction to begginer JavaScript concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 7)


Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to Responsive Web Design','<h1>Introduction to responsive web design concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 8)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('Introduction to SQL Server','<h1>Introduction to SQL Server begginer concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 9)

Insert into [dbo].[Content]
    ([Title]
    ,[HTMLContent]
    ,[VideoLink]
    ,[CategoryItemId])
Values('.NET MAUI for Beginners','<h1>Introduction to .NET MAUI for Beginners concepts</h1>','https://www.youtube.com/embed/JKgZAsn06zY', 10)