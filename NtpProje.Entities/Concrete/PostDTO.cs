using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class PostDTO : BaseDTO
    {
        // HATA GÝDERÝLDÝ: PostService.cs (28. satýr) ve blog.aspx.cs (63. satýr) için post_id
        public int post_id { get; set; }

        // HATA GÝDERÝLDÝ: PostService.cs (29. satýr) ve blog.aspx.cs (60. satýr) için title
        public string title { get; set; }

        // HATA GÝDERÝLDÝ: blog.aspx.cs (63. satýr) için slug
        public string slug { get; set; }

        public string content { get; set; }
        public string summary { get; set; }
        public string image_url { get; set; }
        public int category_id { get; set; }
        public int user_id { get; set; }
        public string status { get; set; }
        public DateTime publish_date { get; set; }

        // HATA GÝDERÝLDÝ: blog.aspx.cs (77. satýr) için View_count -> C# kuralýna göre 'ViewCount' veya küçük harfle
        public int? view_count { get; set; } // Hata resminde 'View_count' geçtiði için bu þekilde varsayýyorum.

        // HATA GÝDERÝLDÝ: blog.aspx.cs (68. satýr) için CategoryName
        public string CategoryName { get; set; }
        public string AuthorFullName { get; set; }

        // created_date, updated_date, is_active BaseDTO'dan gelir.
    }
}