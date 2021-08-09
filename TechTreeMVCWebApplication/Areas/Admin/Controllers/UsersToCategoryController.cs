using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TechTreeMVCWebApplication.Areas.Admin.Models;
using TechTreeMVCWebApplication.Data;
using TechTreeMVCWebApplication.Entities;

namespace TechTreeMVCWebApplication.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class UsersToCategoryController : Controller
    {
        private readonly ApplicationDbContext _context;

        public UsersToCategoryController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetUsersForCategory(int categoryId)
        {
            UsersCategoryListModel usersCategoryListModel = new UsersCategoryListModel();

            var allUsers = await GetAllUsers();
            var selectedUsersForCategory = await GetSavedSelectedUsersForCategory(categoryId);

            usersCategoryListModel.Users = allUsers;
            usersCategoryListModel.UsersSelected = selectedUsersForCategory;

            return PartialView("_UsersListViewPartial", usersCategoryListModel);

        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Category.ToListAsync());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SaveSelectedUsers([Bind("CategoryId, UsersSelected")] UsersCategoryListModel usersCategoryListModel)
        {
            List<UserCategory> usersSelectedForCategoryToAdd = null;

            if(usersCategoryListModel.UsersSelected != null)
            {
                usersSelectedForCategoryToAdd = await GetUsersForCategoryToAdd(usersCategoryListModel);
            }

            var usersSelectedForCategoryToDelete = await GetUsersForCategoryToDelete(usersCategoryListModel.CategoryId);
            
            using (var dbContextTransaction = await _context.Database.BeginTransactionAsync())
            {
                try
                {

                    _context.RemoveRange(usersSelectedForCategoryToDelete);
                    await _context.SaveChangesAsync();

                    if (usersSelectedForCategoryToAdd != null)
                    {
                        _context.AddRange(usersSelectedForCategoryToAdd);
                        await _context.SaveChangesAsync();
                    }
                    await dbContextTransaction.CommitAsync();

                }

                catch (Exception ex)
                {
                    await dbContextTransaction.DisposeAsync();
                }
            }
           
            usersCategoryListModel.Users = await GetAllUsers();

            return PartialView("_UsersListViewPartial", usersCategoryListModel);

        }





        private async Task<List<UserModel>> GetAllUsers()
        {
            var allUsers = await (from user in _context.Users
                                  select new UserModel
                                  {
                                      Id = user.Id,
                                      UserName = user.UserName,
                                      FirstName = user.FirstName,
                                      LastName = user.LastName
                                  }
                                  ).ToListAsync();
            return allUsers;
        }

        private async Task<List<UserCategory>> GetUsersForCategoryToAdd(UsersCategoryListModel usersCategoryListModel)
        {
            var usersForCategoryToAdd =  (from userCat in usersCategoryListModel.UsersSelected
                                         select new UserCategory
                                         {
                                             CategoryId = usersCategoryListModel.CategoryId,
                                             UserId = userCat.Id
                                         }).ToList();

            return await Task.FromResult(usersForCategoryToAdd);
        
        }
        private async Task<List<UserCategory>> GetUsersForCategoryToDelete(int categoryId)
        {
            var usersForCategoryToDelete = await (from userCat in _context.UserCategory
                                                  where userCat.CategoryId == categoryId
                                                  select new UserCategory
                                                  {
                                                        Id = userCat.Id,
                                                        CategoryId = categoryId,
                                                        UserId = userCat.UserId
                                                  }
                                                  ).ToListAsync();
            return usersForCategoryToDelete;

        }
        private async Task<List<UserModel>> GetSavedSelectedUsersForCategory(int categoryId)
        {
            var savedSelectedUsersForCategory = await (from usersToCat in _context.UserCategory
                                                       where usersToCat.CategoryId == categoryId
                                                       select new UserModel
                                                       {
                                                           Id = usersToCat.UserId
                                                       }).ToListAsync();
            return savedSelectedUsersForCategory;
        }



        }
}
