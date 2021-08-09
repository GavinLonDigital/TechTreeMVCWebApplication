using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TechTreeMVCWebApplication.Areas.Admin.Models
{
    public class UserModel
    {
        public string Id { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
