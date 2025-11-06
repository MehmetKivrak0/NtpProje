using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities
{
    public class Comment
    {
        public int CommentId { get; set; }

        public string AuthorName { get; set; } // Yorumu yapanın adı (Misafir olabilir)
        public string AuthorEmail { get; set; } // Yorumu yapanın e-postası
        public string Content { get; set; } // Yorum içeriği
        public DateTime CommentDate { get; set; }
        public bool IsApproved { get; set; } // Admin onayı (true/false)

        // --- İlişkiler ---

        // 1. Bu yorum hangi yazıya (Post) ait?
        public int PostId { get; set; }
        public virtual Post Post { get; set; }

        // 2. (İsteğe bağlı) Bu yorumu kayıtlı bir kullanıcı (User) mı yaptı?
        //    'int?' (nullable int) misafirlerin de yorum yapmasına izin verir.
        public int? UserId { get; set; }
        public virtual User User { get; set; }
    }
}
