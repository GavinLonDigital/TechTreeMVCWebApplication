using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TechTreeMVCWebApplication.Entities
{
    public class UserCategory
    {
        public int Id { get; set; }

        public string UserId { get; set; }
        
        public int CategoryId { get; set; }
   
    }
}
