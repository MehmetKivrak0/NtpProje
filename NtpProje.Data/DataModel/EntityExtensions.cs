using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Data.DataModel
{
    /// <summary>
    /// LINQ to SQL tablo sınıflarını IEntity ile uyumlu hale getirir
    /// Partial class kullanarak mevcut sınıfları extend eder
    /// </summary>

    // user tablosu için IEntity uygulanması

    public partial class user : IEntity
    {
        // IEntity interface'i Id property gerektiriyor
        // LINQ to SQL'de user_id var, onu Id olarak map ediyoruz
        int IEntity.Id
        {
            get { return this.user_id; }
            set { this.user_id = value; }
        }
    }

    // category tablosu için IEntity uygulanması

    public partial class category : IEntity
    {
        int IEntity.Id
        {
            get { return this.category_id; }
            set { this.category_id = value; }
        }
    }

    // project tablosu için IEntity uygulanması

    public partial class project : IEntity
    {
        int IEntity.Id
        {
            get { return this.project_id; }
            set { this.project_id = value; }
        }
    }

    // post tablosu için IEntity uygulanması

    public partial class post : IEntity
    {
        int IEntity.Id
        {
            get { return this.post_id; }
            set { this.post_id = value; }
        }
    }

    // comment tablosu için IEntity uygulanması

    public partial class comment : IEntity
    {
        int IEntity.Id
        {
            get { return this.comment_id; }
            set { this.comment_id = value; }
        }
    }

    // service tablosu için IEntity uygulanması

    public partial class service : IEntity
    {
        int IEntity.Id
        {
            get { return this.service_id; }
            set { this.service_id = value; }
        }
    }

    // team_member tablosu için IEntity uygulanması

    public partial class team_member : IEntity
    {
        int IEntity.Id
        {
            get { return this.team_member_id; }
            set { this.team_member_id = value; }
        }
    }

    // contact_message tablosu için IEntity uygulanması

    public partial class contact_message : IEntity
    {
        int IEntity.Id
        {
            get { return this.contact_message_id; }
            set { this.contact_message_id = value; }
        }
    }

    // project_request tablosu için IEntity implementasyonu
    public partial class project_request : IEntity
    {
        int IEntity.Id
        {
            get { return this.project_request_id; }
            set { this.project_request_id = value; }
        }
    }

    // setting tablosu için IEntity implementasyonu
    public partial class setting : IEntity
    {
        int IEntity.Id
        {
            get { return this.setting_id; }
            set { this.setting_id = value; }
        }
    }

    // statistic tablosu için IEntity implementasyonu (eğer varsa)
    public partial class statistic : IEntity
    {
        int IEntity.Id
        {
            get { return this.statistic_id; }
            set { this.statistic_id = value; }
        }
    }
}

