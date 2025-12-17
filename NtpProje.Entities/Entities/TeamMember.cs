using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Takım üyesi domain entity'si
    /// Veritabanı tablosu: team_members
    /// </summary>
    public class TeamMember : BaseEntity
    {
        /// <summary>
        /// Üye adı ve soyadı
        /// </summary>
        public string Name { get; set; }
        
        /// <summary>
        /// Ünvan/Görev
        /// </summary>
        public string Title { get; set; }
        
        /// <summary>
        /// Pozisyon
        /// </summary>
        public string Position { get; set; }
        
        /// <summary>
        /// Profil fotoğrafı URL'i
        /// </summary>
        public string ImageUrl { get; set; }
        
        /// <summary>
        /// Biyografi
        /// </summary>
        public string Bio { get; set; }
        
        /// <summary>
        /// E-posta adresi
        /// </summary>
        public string Email { get; set; }
        
        /// <summary>
        /// Telefon numarası
        /// </summary>
        public string PhoneNumber { get; set; }
        
        /// <summary>
        /// LinkedIn profil URL'i
        /// </summary>
        public string LinkedInUrl { get; set; }
        
        /// <summary>
        /// Twitter profil URL'i
        /// </summary>
        public string TwitterUrl { get; set; }
        
        /// <summary>
        /// GitHub profil URL'i
        /// </summary>
        public string GithubUrl { get; set; }
        
        /// <summary>
        /// Görüntülenme sırası
        /// </summary>
        public int DisplayOrder { get; set; }
    }
}

