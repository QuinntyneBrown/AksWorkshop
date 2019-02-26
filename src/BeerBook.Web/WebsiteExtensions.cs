using BeerBook.Web.Clients;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeerBook.Web
{
    static class WebsiteExtensions
    {
        public static IServiceCollection AddHttpClientFactory(this IServiceCollection services)
        {
            services.AddHttpClient<ICatalogClient, CatalogClient>();
            return services;
        }
    }
}
