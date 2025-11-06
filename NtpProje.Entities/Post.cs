using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NtpProje.Entities;

namespace NtpProje.Entities
{
    public class Post
    {
        public int PostId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public DateTime PublishDate { get; set; }
        public string Status { get; set; } // Örn: "Yayında", "Taslak"

        // --- İlişkiler ---
        public int UserId { get; set; } // Yazarın kim olduğu (User'a bağlı)
        public virtual User Author { get; set; }

        public int CategoryId { get; set; } // Kategorinin ne olduğu (Category'ye bağlı)
        public virtual Category Category { get; set; }
    }
}
