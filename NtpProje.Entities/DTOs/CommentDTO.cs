using System;

namespace NtpProje.Entities.DTOs
{
    public class CommentDTO
    {
        // SQL: comment_id
        public int Id { get; set; }

        // SQL: author_name
        public string AuthorName { get; set; }

        // SQL: author_email
        public string AuthorEmail { get; set; }

        // SQL: content
        public string Content { get; set; }

        // SQL: comment_date
        public DateTime CommentDate { get; set; }

        // SQL: is_approved
        public bool IsApproved { get; set; }

        // SQL: post_id (Hangi yaz�ya yorum yap�ld�?)
        public int PostId { get; set; }

        // SQL: user_id (E�er �ye ise ID'si, de�ilse null olabilir)
        public int? UserId { get; set; }

        // SQL: parent_comment_id (Alt yorum mu? Varsa �st yorumun ID'si)
        public int? ParentCommentId { get; set; }

    }
}

