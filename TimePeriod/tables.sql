CREATE TABLE [dbo].[Article](
    [area] varchar(64) NOT NULL,
    [createTime] varchar(64) NOT NULL,
    [imgCover] varchar(64)  NOT NULL,
    [imgThumbnail] varchar(64) NOT NULL,
    [rticleaID] nvarchar(16) NOT NULL,
    [title] varchar(64) NOT NULL,
    [updateTime] varchar(64)  NOT NULL, 
    PRIMARY KEY CLUSTERED ([rticleaID])
);
CREATE TABLE [dbo].[NearShop](
    [rticleaID] nvarchar(16) NOT NULL,
    [distance] nvarchar(32) NOT NULL,
    [area] varchar(64)  NOT NULL,
    [shopID] nvarchar(16) NOT NULL,
    [shopName] varchar(64) NOT NULL,
    [imgThumbnail] varchar(64) NOT NULL,
    PRIMARY KEY CLUSTERED ([rticleaID])
);

