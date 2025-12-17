using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Yorum domain entity'si
    /// Veritabanı tablosu: comments
    /// </summary>
    public class Comment : BaseEntity
    {
        /// <summary>
        /// Yorum yazarının adı
        /// </summary>
        public string AuthorName { get; set; }
        
        /// <summary>
        /// Yorum yazarının e-posta adresi
        /// </summary>
        public string AuthorEmail { get; set; }
        
        /// <summary>
        /// Yorum içeriği
        /// </summary>
        public string Content { get; set; }
        
        /// <summary>
        /// Yorumun yazıldığı tarih
        /// </summary>
        public DateTime CommentDate { get; set; }
        
        /// <summary>
        /// Yorum onaylandı mı?
        /// </summary>
        public bool IsApproved { get; set; }
        
        /// <summary>
        /// Hangi yazıya yapılan yorum (Foreign Key)
        /// </summary>
        public int PostId { get; set; }
        
        /// <summary>
        /// Üye ID'si (üye ise, değilse null)
        /// </summary>
        public int? UserId { get; set; }
        
        /// <summary>
        /// Üst yorum ID'si (alt yorum ise)
        /// </summary>
        public int? ParentCommentId { get; set; }
    }
}

