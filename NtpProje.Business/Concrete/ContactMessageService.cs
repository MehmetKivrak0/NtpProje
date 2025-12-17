using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.DTOs; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (contact_message)
using NtpProje.Entities.Logging;

namespace NtpProje.Business.Concrete
{
    public class ContactMessageService : IBaseService<ContactMessageDTO>
    {
        private readonly ContactMessageRepository _contactRepository;

        public ContactMessageService()
        {
            _contactRepository = new ContactMessageRepository();
        }

        // 1. LİSTELEME (GET ALL)
        public List<ContactMessageDTO> GetAll()
        {
            var entities = _contactRepository.GetAll();
            var dtos = new List<ContactMessageDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new ContactMessageDTO
                {
                    // SOL: DTO (PascalCase) = SAĞ: SQL Sütunları (snake_case)
                    Id = entity.contact_message_id,
                    NameSurname = entity.full_name,    // full_name
                    Email = entity.email,
                    Phone = entity.phone_number,       // phone_number
                    Subject = entity.subject,
                    Message = entity.message,

                    // Nullable kontrolü (?? false veya ?? DateTime.MinValue)
                    IsRead = entity.is_read ?? false,
                    IsReplied = entity.is_replied ?? false,
                    ReplyMessage = entity.reply_message,
                    ReplyDate = entity.reply_date,
                    IpAddress = entity.ip_address,
                    CreatedDate = entity.created_date ?? DateTime.MinValue
                });
            }
            return dtos;
        }

        // 2. GET BY ID
        public ContactMessageDTO GetById(int id)
        {
            var entity = _contactRepository.GetAll().FirstOrDefault(c => c.contact_message_id == id);
            if (entity == null) return null;

            // Detaya girince "Okundu" işaretle
            if (entity.is_read == false)
            {
                entity.is_read = true;
                _contactRepository.Update(entity);
            }

            return new ContactMessageDTO
            {
                Id = entity.contact_message_id,
                NameSurname = entity.full_name,
                Email = entity.email,
                Phone = entity.phone_number,
                Subject = entity.subject,
                Message = entity.message,
                IsRead = entity.is_read ?? true,
                IsReplied = entity.is_replied ?? false,
                ReplyMessage = entity.reply_message,
                ReplyDate = entity.reply_date,
                IpAddress = entity.ip_address,
                CreatedDate = entity.created_date ?? DateTime.MinValue
            };
        }

        // 3. EKLEME (ADD)
        public bool Add(ContactMessageDTO dto)
        {
            try
            {
                var entity = new contact_message
                {
                    // DTO -> Entity Eşleşmesi
                    full_name = dto.NameSurname,
                    email = dto.Email,
                    phone_number = dto.Phone,
                    subject = dto.Subject,
                    message = dto.Message,
                    ip_address = dto.IpAddress,

                    // Varsayılan Değerler
                    created_date = DateTime.Now,
                    is_read = false,
                    is_replied = false
                };

                _contactRepository.Add(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ContactMessageService.Add");
                throw;
            }
        }

        // 4. GÜNCELLEME (UPDATE)
        public bool Update(ContactMessageDTO dto)
        {
            try
            {
                var entity = _contactRepository.GetAll().FirstOrDefault(c => c.contact_message_id == dto.Id);
                if (entity == null) return false;

                // Cevaplandı mı?
                entity.is_replied = dto.IsReplied;
                entity.reply_message = dto.ReplyMessage;
                entity.reply_date = dto.ReplyDate;
                entity.is_read = dto.IsRead;

                _contactRepository.Update(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ContactMessageService.Update");
                throw;
            }
        }

        // 5. SİLME (DELETE)
        public bool Delete(int id)
        {
            try
            {
                var entity = _contactRepository.GetAll().FirstOrDefault(c => c.contact_message_id == id);
                if (entity == null) return false;

                _contactRepository.Delete(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ContactMessageService.Delete");
                throw;
            }
        }

        // 6. SAYIM: Toplam mesaj adedi
        public int CountAll()
        {
            try
            {
                return _contactRepository.GetAll().Count();
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ContactMessageService.CountAll");
                throw;
            }
        }
    }
}