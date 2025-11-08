using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class TeamMemberDTO : BaseDTO
    {
        // BaseDTO'dan Id ve Name gelir
        public string Title { get; set; }
        public string ImageUrl { get; set; }
        public string Bio { get; set; }

        public TeamMemberDTO() { }

        public TeamMemberDTO(int id, string name, string title)
        {
            this.Id = id;
            this.Name = name;
            this.Title = title;
        }

        public override string ToString()
        {
            return $"Team Member: {Name} - {Title}";
        }
    }
}

