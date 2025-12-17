using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    public class PostDTO : BaseDTO
    {
        // SQL: post_id --> C#: Id (veya PostId) olmal�d�r
        public int Id { get; set; }

        // SQL: title --> C#: Title olmal�d�r
        public string Title { get; set; }

        public string Slug { get; set; }
        public string Content { get; set; }
        public string Summary { get; set; }

        // SQL: image_url --> C#: ImageUrl olmal�d�r
        public string ImageUrl { get; set; }

        public int CategoryId { get; set; }
        public int UserId { get; set; }
        public string Status { get; set; }
        public DateTime? PublishDate { get; set; } // Nullable yap�ld�

        public int ViewCount { get; set; }
        public int ReadingTime { get; set; }

        // UI i�in ekstra alanlar
        public string CategoryName { get; set; }
        public string AuthorFullName { get; set; }
    }
}