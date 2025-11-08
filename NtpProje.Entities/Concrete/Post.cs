using System;

namespace NtpProje.Entities.Concrete
{
    public class PostDTO
    {
        public int PostId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public DateTime PublishDate { get; set; }
        public string Status { get; set; }
        
        // İlişkiler
        public int UserId { get; set; }
        public string AuthorName { get; set; } // Join için
        
        public int CategoryId { get; set; }
        public string CategoryName { get; set; } // Join için

        public PostDTO() { }

        public PostDTO(int postId, string title, string content)
        {
            this.PostId = postId;
            this.Title = title;
            this.Content = content;
        }

        public override string ToString()
        {
            return $"Post: {Title} - Author: {AuthorName}";
        }
    }
}

