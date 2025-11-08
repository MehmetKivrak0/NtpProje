using System;

namespace NtpProje.Entities.Concrete
{
    public class CommentDTO
    {
        public int CommentId { get; set; }
        public string AuthorName { get; set; }
        public string AuthorEmail { get; set; }
        public string Content { get; set; }
        public DateTime CommentDate { get; set; }
        public bool IsApproved { get; set; }
        
        // İlişkiler
        public int PostId { get; set; }
        public string PostTitle { get; set; } // Join için
        
        public int? UserId { get; set; }

        public CommentDTO() { }

        public CommentDTO(int commentId, string authorName, string content)
        {
            this.CommentId = commentId;
            this.AuthorName = authorName;
            this.Content = content;
        }

        public override string ToString()
        {
            return $"Comment by {AuthorName} on {PostTitle}";
        }
    }
}

