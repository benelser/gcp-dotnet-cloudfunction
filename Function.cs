using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using System.IO;
using System.Threading.Tasks;
using System.Text.Json;
using Microsoft.Extensions.Logging;

namespace first_gcp_func
{
    public class Function : IHttpFunction
    {
        /// <summary>
        /// Logic for your function goes here.
        /// </summary>
        /// <param name="context">The HTTP context, containing the request and the response.</param>
        /// <returns>A task representing the asynchronous operation.</returns>
        private readonly ILogger _logger;

        public Function(ILogger<Function> logger) =>
            _logger = logger;

        public async Task HandleAsync(HttpContext context)
        {

            if (context.Request.Method != "POST")
            {
                context.Response.StatusCode = 405;
                string message = "Method not allowed";
                context.Response.Headers.Add("Content-Length", message.Length.ToString());
                await context.Response.WriteAsync(message);
            }
            else
            {
                // Read body here
                using TextReader reader = new StreamReader(context.Request.Body);
                string text = await reader.ReadToEndAsync();
                if(text.Length > 0)
                {
                    try
                    {
                        Person p = JsonSerializer.Deserialize<Person>(text);
                        await context.Response.WriteAsync(p.FName);

                    }
                    catch (JsonException parseException)
                    {
                        _logger.LogError(parseException, "Error parsing JSON request");
                        context.Response.StatusCode = 400;
                        await context.Response.WriteAsync("Error parsing JSON request");
                    }
                }
                else
                {
                    context.Response.StatusCode = 400;
                    await context.Response.WriteAsync("Error parsing JSON request");
                }

            }
        }

        public class Person
        {
            public string FName { get; set; }
            public string LName { get; set; }
        }
    }
}
