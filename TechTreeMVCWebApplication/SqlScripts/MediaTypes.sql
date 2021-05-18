USE [TechTree]
GO

--MediaType
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