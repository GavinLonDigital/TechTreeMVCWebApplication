using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TechTreeMVCWebApplication.Data;
using TechTreeMVCWebApplication.Entities;
using TechTreeMVCWebApplication.Models;

namespace TechTreeMVCWebApplication.Controllers
{
    [Authorize]
    public class CategoriesToUserController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IDataFunctions _dataFunctions;

        public CategoriesToUserController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, IDataFunctions dataFunctions)
        {
            _context = context;
            _userManager = userManager;
            _dataFunctions = dataFunctions;
        }
        public async Task<IActionResult> Index()
        {
            CategoriesToUserModel categoriesToUserModel = new CategoriesToUserModel();

            var userId = _userManager.GetUserAsync(User).Result?.Id;

            categoriesToUserModel.Categories = await GetCategoriesThatHaveContent();

            categoriesToUserModel.CategoriesSelected = await GetCategoriesCurrentlySavedForUser(userId);

            categoriesToUserModel.UserId = userId;

            return View(categoriesToUserModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Index(string[] categoriesSelected)
        {
            var userId = _userManager.GetUserAsync(User).Result?.Id;

            List<UserCategory> userCategoriesToDelete = await GetCategoriesToDeleteForUser(userId);
            List<UserCategory> userCategoriesToAdd =  GetCategoriesToAddForUser(categoriesSelected, userId);

            await _dataFunctions.UpdateUserCategoryEntityAsync(userCategoriesToDelete, userCategoriesToAdd);

            return RedirectToAction("Index", "Home");
        }

        private async Task<List<Category>> GetCategoriesThatHaveContent()
        {
            var categoriesThatHaveContent = await (from category in _context.Category
                                                   join categoryItem in _context.CategoryItem
                                                   on category.Id equals categoryItem.CategoryId
                                                   join content in _context.Content
                                                   on categoryItem.Id equals content.CategoryItem.Id
                                                   select new Category
                                                   {
                                                       Id = category.Id,
                                                       Title = category.Title,
                                                       Description = category.Description
                                                   }).Distinct().ToListAsync();

            return categoriesThatHaveContent;
        }
        private async Task<List<Category>> GetCategoriesCurrentlySavedForUser(string userId)
        {
            var categoriesCurrentlySavedForUser = await (from userCategory in _context.UserCategory
                                                         where userCategory.UserId == userId
                                                         select new Category
                                                         {
                                                             Id = userCategory.CategoryId,
                                                         }).ToListAsync();
            return categoriesCurrentlySavedForUser;
        }
        private async Task<List<UserCategory>> GetCategoriesToDeleteForUser(string userId)
        {
            var categoriesToDelete = await (from userCat in _context.UserCategory
                                            where userCat.UserId == userId
                                            select new UserCategory
                                            {
                                                Id = userCat.Id,
                                                CategoryId = userCat.CategoryId,
                                                UserId = userId
                                            }).ToListAsync();

            return categoriesToDelete;
        }

        private List<UserCategory> GetCategoriesToAddForUser(string[] categoriesSelected, string userId)
        {
            var categoriesToAdd = (from categoryId in categoriesSelected
                                   select new UserCategory
                                   {
                                       UserId = userId,
                                       CategoryId = int.Parse(categoryId)
                                   }).ToList();

            return categoriesToAdd;
                
        }

    }
}
