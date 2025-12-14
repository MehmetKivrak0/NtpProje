using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class CategoryDTO : BaseDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Slug { get; set; }
    }
}