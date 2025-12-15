using System;
using System.Diagnostics;

namespace NtpProje.Entities.Logging
{
    // Basit merkezi logger: Trace'e yazar. İstenirse farklı hedefe yönlendirilebilir.
    public static class AppLogger
    {
        public static void LogError(Exception ex, string context = "")
        {
            try
            {
                var message = string.IsNullOrWhiteSpace(context)
                    ? ex.ToString()
                    : $"{context} | {ex}";
                Trace.TraceError(message);
            }
            catch
            {
                // Logger'da hata yutulur; uygulama akışını etkilemesin.
            }
        }
    }
}

