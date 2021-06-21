using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using TechTreeMVCWebApplication.Interfaces;

namespace TechTreeMVCWebApplication.Entities
{
    public class MediaType:IPrimaryProperties
    {
        public int Id { get; set; }

        [Required]
        [StringLength(200,MinimumLength = 2)]
        public string Title { get; set; }

        [Required]
        [Display(Name ="Thumbnail Image Path")]
        public string ThumbnailImagePath { get; set; }

        [ForeignKey("MediaTypeId")]
        public virtual ICollection<CategoryItem> CategoryItems { get; set; }
    }
}
