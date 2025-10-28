namespace NtpProje.DataAccess.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddBioToUser : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Users", "Bio", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Users", "Bio");
        }
    }
}
