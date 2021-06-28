using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using TechTreeMVCWebApplication.Data;
using TechTreeMVCWebApplication.Entities;
using TechTreeMVCWebApplication.Extensions;

namespace TechTreeMVCWebApplication.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class CategoryItemController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CategoryItemController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Admin/CategoryItem
        public async Task<IActionResult> Index(int categoryId)
        {

            List<CategoryItem> list = await (from catItem in _context.CategoryItem
                                             join contentItem in _context.Content
                                             on catItem.Id equals contentItem.CategoryItem.Id
                                             into gj
                                             from subContent in gj.DefaultIfEmpty()
                                             where catItem.CategoryId == categoryId
                                             select new CategoryItem
                                             { 
                                                Id = catItem.Id,
                                                Title = catItem.Title,
                                                Description = catItem.Description,
                                                DateTimeItemReleased = catItem.DateTimeItemReleased,
                                                MediaTypeId = catItem.MediaTypeId,
                                                CategoryId = categoryId,
                                                ContentId = (subContent != null) ? subContent.Id : 0

                                             }).ToListAsync();


            ViewBag.CategoryId = categoryId;

            return View(list);
        }

        // GET: Admin/CategoryItem/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var categoryItem = await _context.CategoryItem
                .FirstOrDefaultAsync(m => m.Id == id);
            if (categoryItem == null)
            {
                return NotFound();
            }

            return View(categoryItem);
        }

        // GET: Admin/CategoryItem/Create
        public async Task<IActionResult> Create(int categoryId)
        {
            List<MediaType> mediaTypes = await _context.MediaType.ToListAsync();

            CategoryItem categoryItem = new CategoryItem
            {
                CategoryId = categoryId,
                MediaTypes = mediaTypes.ConvertToSelectList(0)
            };
       


            return View(categoryItem);
        }

        // POST: Admin/CategoryItem/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Title,Description,CategoryId,MediaTypeId,DateTimeItemReleased")] CategoryItem categoryItem)
        {
            if (ModelState.IsValid)
            {
                _context.Add(categoryItem);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index),new {categoryId = categoryItem.CategoryId });
            }
            List<MediaType> mediaTypes = await _context.MediaType.ToListAsync();
            categoryItem.MediaTypes = mediaTypes.ConvertToSelectList(categoryItem.MediaTypeId);


            return View(categoryItem);
        }

        // GET: Admin/CategoryItem/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            List<MediaType> mediaTypes = await _context.MediaType.ToListAsync();

            var categoryItem = await _context.CategoryItem.FindAsync(id);
            
            if (categoryItem == null)
            {
                return NotFound();
            }

            categoryItem.MediaTypes = mediaTypes.ConvertToSelectList(categoryItem.MediaTypeId);

            return View(categoryItem);
        }

        // POST: Admin/CategoryItem/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Title,Description,CategoryId,MediaTypeId,DateTimeItemReleased")] CategoryItem categoryItem)
        {
            if (id != categoryItem.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(categoryItem);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CategoryItemExists(categoryItem.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index), new {categoryId = categoryItem.CategoryId });
            }
            return View(categoryItem);
        }

        // GET: Admin/CategoryItem/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var categoryItem = await _context.CategoryItem
                .FirstOrDefaultAsync(m => m.Id == id);
            if (categoryItem == null)
            {
                return NotFound();
            }

            return View(categoryItem);
        }

        // POST: Admin/CategoryItem/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var categoryItem = await _context.CategoryItem.FindAsync(id);
            _context.CategoryItem.Remove(categoryItem);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index),new {categoryId=categoryItem.CategoryId });
        }

        private bool CategoryItemExists(int id)
        {
            return _context.CategoryItem.Any(e => e.Id == id);
        }
    }
}
