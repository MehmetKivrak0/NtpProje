using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NtpProje.Entities
{
    public class TeamMember
    {
        public int TeamMemberId { get; set; }
        public string Name { get; set; }
        public string Title { get; set; } // Görevi, örn: "Yazılım Geliştirici"
        public string ImageUrl { get; set; }
        public string Bio { get; set; } // Kısa biyografi
    }
}
