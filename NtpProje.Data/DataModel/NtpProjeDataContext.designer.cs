using System;
using System.Data.Linq;
using System.Data.Linq.Mapping;

namespace NtpProje.DataAccess.DataModel
{
    [Database(Name = "NtpProjeDB")]
    public partial class NtpProjeDataContext : DataContext
    {
        private static MappingSource mappingSource = new AttributeMappingSource();

        public NtpProjeDataContext() :
            base(global::System.Configuration.ConfigurationManager.ConnectionStrings["NtpProjeDataContext"].ConnectionString, mappingSource)
        {
            OnCreated();
        }

        public NtpProjeDataContext(string connection) :
            base(connection, mappingSource)
        {
            OnCreated();
        }

        public NtpProjeDataContext(System.Data.IDbConnection connection) :
            base(connection, mappingSource)
        {
            OnCreated();
        }

        public NtpProjeDataContext(string connection, MappingSource mappingSource) :
            base(connection, mappingSource)
        {
            OnCreated();
        }

        public NtpProjeDataContext(System.Data.IDbConnection connection, MappingSource mappingSource) :
            base(connection, mappingSource)
        {
            OnCreated();
        }

        public Table<User> Users
        {
            get
            {
                return this.GetTable<User>();
            }
        }

        public Table<Category> Categories
        {
            get
            {
                return this.GetTable<Category>();
            }
        }

        public Table<Post> Posts
        {
            get
            {
                return this.GetTable<Post>();
            }
        }

        public Table<Project> Projects
        {
            get
            {
                return this.GetTable<Project>();
            }
        }

        public Table<Service> Services
        {
            get
            {
                return this.GetTable<Service>();
            }
        }

        public Table<TeamMember> TeamMembers
        {
            get
            {
                return this.GetTable<TeamMember>();
            }
        }

        public Table<Comment> Comments
        {
            get
            {
                return this.GetTable<Comment>();
            }
        }

        partial void OnCreated();
    }

    [Table(Name = "dbo.Users")]
    public partial class User
    {
        [Column(Storage = "_UserId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int UserId { get; set; }

        [Column(Storage = "_FullName", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string FullName { get; set; }

        [Column(Storage = "_Email", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string Email { get; set; }

        [Column(Storage = "_PhoneNumber", DbType = "NVarChar(20)")]
        public string PhoneNumber { get; set; }

        [Column(Storage = "_Password", DbType = "NVarChar(255) NOT NULL", CanBeNull = false)]
        public string Password { get; set; }

        [Column(Storage = "_Role", DbType = "NVarChar(50)")]
        public string Role { get; set; }

        [Column(Storage = "_Bio", DbType = "NVarChar(MAX)")]
        public string Bio { get; set; }

        private int _UserId;
        private string _FullName;
        private string _Email;
        private string _PhoneNumber;
        private string _Password;
        private string _Role;
        private string _Bio;
    }

    [Table(Name = "dbo.Categories")]
    public partial class Category
    {
        [Column(Storage = "_CategoryId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int CategoryId { get; set; }

        [Column(Storage = "_CategoryName", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string CategoryName { get; set; }

        private int _CategoryId;
        private string _CategoryName;
    }

    [Table(Name = "dbo.Posts")]
    public partial class Post
    {
        [Column(Storage = "_PostId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int PostId { get; set; }

        [Column(Storage = "_Title", DbType = "NVarChar(200) NOT NULL", CanBeNull = false)]
        public string Title { get; set; }

        [Column(Storage = "_Content", DbType = "NVarChar(MAX)")]
        public string Content { get; set; }

        [Column(Storage = "_PublishDate", DbType = "DateTime NOT NULL")]
        public DateTime PublishDate { get; set; }

        [Column(Storage = "_Status", DbType = "NVarChar(50)")]
        public string Status { get; set; }

        [Column(Storage = "_UserId", DbType = "Int NOT NULL")]
        public int UserId { get; set; }

        [Column(Storage = "_CategoryId", DbType = "Int NOT NULL")]
        public int CategoryId { get; set; }

        private int _PostId;
        private string _Title;
        private string _Content;
        private DateTime _PublishDate;
        private string _Status;
        private int _UserId;
        private int _CategoryId;
    }

    [Table(Name = "dbo.Projects")]
    public partial class Project
    {
        [Column(Storage = "_ProjectId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int ProjectId { get; set; }

        [Column(Storage = "_ProjectName", DbType = "NVarChar(200) NOT NULL", CanBeNull = false)]
        public string ProjectName { get; set; }

        [Column(Storage = "_Description", DbType = "NVarChar(MAX)")]
        public string Description { get; set; }

        [Column(Storage = "_ImageUrl", DbType = "NVarChar(500)")]
        public string ImageUrl { get; set; }

        [Column(Storage = "_ProjectDate", DbType = "DateTime NOT NULL")]
        public DateTime ProjectDate { get; set; }

        [Column(Storage = "_ClientName", DbType = "NVarChar(100)")]
        public string ClientName { get; set; }

        private int _ProjectId;
        private string _ProjectName;
        private string _Description;
        private string _ImageUrl;
        private DateTime _ProjectDate;
        private string _ClientName;
    }

    [Table(Name = "dbo.Services")]
    public partial class Service
    {
        [Column(Storage = "_ServiceId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int ServiceId { get; set; }

        [Column(Storage = "_ServiceName", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string ServiceName { get; set; }

        [Column(Storage = "_Description", DbType = "NVarChar(MAX)")]
        public string Description { get; set; }

        [Column(Storage = "_IconClass", DbType = "NVarChar(50)")]
        public string IconClass { get; set; }

        private int _ServiceId;
        private string _ServiceName;
        private string _Description;
        private string _IconClass;
    }

    [Table(Name = "dbo.TeamMembers")]
    public partial class TeamMember
    {
        [Column(Storage = "_TeamMemberId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int TeamMemberId { get; set; }

        [Column(Storage = "_Name", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string Name { get; set; }

        [Column(Storage = "_Title", DbType = "NVarChar(100)")]
        public string Title { get; set; }

        [Column(Storage = "_ImageUrl", DbType = "NVarChar(500)")]
        public string ImageUrl { get; set; }

        [Column(Storage = "_Bio", DbType = "NVarChar(MAX)")]
        public string Bio { get; set; }

        private int _TeamMemberId;
        private string _Name;
        private string _Title;
        private string _ImageUrl;
        private string _Bio;
    }

    [Table(Name = "dbo.Comments")]
    public partial class Comment
    {
        [Column(Storage = "_CommentId", AutoSync = AutoSync.OnInsert, DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int CommentId { get; set; }

        [Column(Storage = "_AuthorName", DbType = "NVarChar(100) NOT NULL", CanBeNull = false)]
        public string AuthorName { get; set; }

        [Column(Storage = "_AuthorEmail", DbType = "NVarChar(100)")]
        public string AuthorEmail { get; set; }

        [Column(Storage = "_Content", DbType = "NVarChar(MAX) NOT NULL", CanBeNull = false)]
        public string Content { get; set; }

        [Column(Storage = "_CommentDate", DbType = "DateTime NOT NULL")]
        public DateTime CommentDate { get; set; }

        [Column(Storage = "_IsApproved", DbType = "Bit NOT NULL")]
        public bool IsApproved { get; set; }

        [Column(Storage = "_PostId", DbType = "Int NOT NULL")]
        public int PostId { get; set; }

        [Column(Storage = "_UserId", DbType = "Int")]
        public int? UserId { get; set; }

        private int _CommentId;
        private string _AuthorName;
        private string _AuthorEmail;
        private string _Content;
        private DateTime _CommentDate;
        private bool _IsApproved;
        private int _PostId;
        private int? _UserId;
    }
}

