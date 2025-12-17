using System;

namespace NtpProje.Entities.Abstract
{
    /// <summary>
    /// Tüm entity'lerin base interface'i
    /// </summary>
    public interface IEntity
    {
    }
    
    /// <summary>
    /// Id'si olan entity'ler için generic interface
    /// </summary>
    /// <typeparam name="TKey">Primary key tipi (genellikle int)</typeparam>
    public interface IEntity<TKey> : IEntity
    {
        TKey Id { get; set; }
    }
}

