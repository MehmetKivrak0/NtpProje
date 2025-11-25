using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (statistic)

namespace NtpProje.Business.Concrete
{
    public class StatisticService : IBaseService<StatisticDTO>
    {
        private readonly StatisticRepository _statisticRepository;

        public StatisticService()
        {
            _statisticRepository = new StatisticRepository();
        }

        // 1. GET ALL
        public List<StatisticDTO> GetAll()
        {
            // Sadece aktif olanları ve sıraya göre getir
            var entities = _statisticRepository.GetAll()
                            .Where(x => x.is_active == true)
                            .OrderBy(x => x.display_order)
                            .ToList();

            var dtos = new List<StatisticDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new StatisticDTO
                {
                    // SOL: DTO = SAĞ: SQL Sütunları
                    Id = entity.statistic_id,
                    Key = entity.statistic_key,
                    Value = entity.statistic_value,
                    Label = entity.statistic_label,
                    DisplayOrder = entity.display_order ?? 0,
                    IsActive = entity.is_active ?? true
                });
            }
            return dtos;
        }

        // 2. GET BY ID
        public StatisticDTO GetById(int id)
        {
            var entity = _statisticRepository.GetAll().FirstOrDefault(s => s.statistic_id == id);
            if (entity == null) return null;

            return new StatisticDTO
            {
                Id = entity.statistic_id,
                Key = entity.statistic_key,
                Value = entity.statistic_value,
                Label = entity.statistic_label,
                DisplayOrder = entity.display_order ?? 0,
                IsActive = entity.is_active ?? true
            };
        }

        // 3. ADD
        public bool Add(StatisticDTO dto)
        {
            try
            {
                var entity = new statistic
                {
                    statistic_key = dto.Key,
                    statistic_value = dto.Value,
                    statistic_label = dto.Label,
                    display_order = dto.DisplayOrder,
                    is_active = true,
                    updated_date = DateTime.Now
                };

                _statisticRepository.Add(entity);
                return true;
            }
            catch { return false; }
        }

        // 4. UPDATE
        public bool Update(StatisticDTO dto)
        {
            try
            {
                var entity = _statisticRepository.GetAll().FirstOrDefault(s => s.statistic_id == dto.Id);
                if (entity == null) return false;

                entity.statistic_key = dto.Key;
                entity.statistic_value = dto.Value;
                entity.statistic_label = dto.Label;
                entity.display_order = dto.DisplayOrder;
                entity.is_active = dto.IsActive;
                entity.updated_date = DateTime.Now;

                _statisticRepository.Update(entity);
                return true;
            }
            catch { return false; }
        }

        // 5. DELETE
        public bool Delete(int id)
        {
            try
            {
                var entity = _statisticRepository.GetAll().FirstOrDefault(s => s.statistic_id == id);
                if (entity == null) return false;

                _statisticRepository.Delete(entity);
                return true;
            }
            catch { return false; }
        }
    }
}