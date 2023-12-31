﻿using DataLayer.DBObject;

namespace ServiceLayer.Interface.Db;

public interface IDocumentFileService
{
    IQueryable<DocumentFile> GetList();
    
    IQueryable<DocumentFile> GetListByGroupId(int groupId, bool? approved);
    
    IQueryable<DocumentFile> GetListByAccountId(int accountId);


    Task CreateDocumentFile(DocumentFile documentFile);
    
    Task UpdateDocumentFile(DocumentFile documentFile);
    
    Task<DocumentFile> GetById(int id);
    
    Task DeleteDocumentFile(int id);
}