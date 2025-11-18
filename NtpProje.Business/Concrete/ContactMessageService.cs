using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete;
using NtpProje.Data.Concrete;

namespace NtpProje.Business.Concrete
{
    public class ContactMessageService : IBaseService<ContactMessageDTO>
    {
        private readonly ContactMessageRepository _contactRepository;

        public ContactMessageService()
        {
            _contactRepository = new ContactMessageRepository();
        }

        public bool Add(ContactMessageDTO dto)
        {

            if (string.IsNullOrWhiteSpace(dto.email) || string.IsNullOrWhiteSpace(dto.message))
            {
                return false;
            }

            var entity = new NtpProje.Data.DataModel.contact_message
            {
                full_name = dto.full_name,
                email = dto.email,
                phone_number = dto.phone_number,
                subject = dto.subject,
                message = dto.message,
                ip_address = dto.ip_address,
                is_read = false, // Yeni mesaj okunmamış kabul edilir
                created_date = dto.Created_date
            };

            _contactRepository.Add(entity);
            return true;

        }

        public List<ContactMessageDTO> GetAll()
        {

            var entities = _contactRepository.GetAll();
            var dtos = new List<ContactMessageDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new ContactMessageDTO
                {
                    contact_message_id = entity.contact_message_id,
                    full_name = entity.full_name,
                    email = entity.email,
                    subject = entity.subject,
                    is_read = entity.is_read ?? false, // Nullable kontrolü
                    Created_date = entity.created_date ?? DateTime.MinValue
                });
            }
            return dtos;
        }

        public ContactMessageDTO GetById(int id)
        {
            var entity = _contactRepository.Get(id);
            if (entity == null)

                if (entity.is_read == false)
                {
                    entity.is_read = true;
                    _contactRepository.Update(entity);
                }
            return new ContactMessageDTO
            {
                contact_message_id = entity.contact_message_id,
                full_name = entity.full_name,
                email = entity.email,
                message = entity.message,
                subject = entity.subject,
                is_read = entity.is_read ?? true,
                Created_date = entity.created_date ?? DateTime.MinValue
            };
        }

        public bool Update(ContactMessageDTO dto)
        {
            var entity = _contactRepository.Get(dto.contact_message_id);
            if (entity == null) return false;

            entity.is_read = dto.is_read;
            entity.reply_date = dto.reply_date;
            _contactRepository.Update(entity);
            return true;
        }

        public bool Delete(int id)
        {
            var entity = _contactRepository.Get(id);
            if (entity == null) return false;
            _contactRepository.Delete(entity);
            return true;
        }

    }


}
