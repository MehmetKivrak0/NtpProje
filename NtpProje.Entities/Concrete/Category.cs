using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class CategoryDTO : BaseDTO
    {
        // BaseDTO'dan Id ve Name gelir
        
        public CategoryDTO() { }

        public CategoryDTO(int id, string name)
        {
            this.Id = id;
            this.Name = name;
        }

        public override string ToString()
        {
            return $"ID: {Id}, Name: {Name}";
        }
    }
}

